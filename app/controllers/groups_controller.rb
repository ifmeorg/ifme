class GroupsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.groups.order("created_at DESC")
    @page_title = "Groups"
    @page_tooltip = "New group"
    accepted_allies = current_user.allies_by_status(:accepted)
    @page_new = new_group_path

    @available_groups = Array.new
    find_available_groups = GroupMember.where(userid: accepted_allies).all.order("created_at DESC")
    find_available_groups.each do |group|
      if !GroupMember.where(userid: current_user.id, groupid: group.groupid).exists?
        @available_groups.push(group)
      end
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @page_title = @group.name
    @is_group_member = if GroupMember.where(groupid: @group.id, userid: current_user.id).exists? then true else false end
    if @is_group_member
      @meetings = Meeting.where(groupid: @group.id).order('created_at DESC')
    end
    @group_leaders = GroupMember.where(groupid: @group.id, leader: true).all
    @group_deletable = GroupMember.where(groupid: @group.id, userid: current_user.id, leader: true).exists? && GroupMember.where(groupid: @group.id, leader: true).count == 1 && GroupMember.where(groupid: @group.id).count == 1

    if (GroupMember.where(groupid: @group.id, leader: true, userid: current_user.id).exists?)
      @page_new = new_meeting_path + '/?groupid=' + @group.id.to_s
      @page_tooltip = "New meeting"
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
    @page_title = "New Group"
  end

  # GET /groups/1/edit
  def edit
    @page_title = "Edit " + @group.name
    @group_members = GroupMember.where(groupid: @group.id).all
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @page_title = "New Group"
    respond_to do |format|
      if @group.save
        group_member = GroupMember.new(groupid: @group.id, userid: current_user.id, leader: true)

        # Notify allies that you created a new group
        accepted_allies = current_user.allies_by_status(:accepted)

        uniqueid = 'new_group_' + current_user.id.to_s

        accepted_allies.each do |ally|
          data = JSON.generate({
            user: current_user.name,
            groupid: @group.id,
            group: @group.name,
            type: 'new_group',
            uniqueid: uniqueid
          })

          Notification.create(userid: ally.id, uniqueid: uniqueid, data: data)
          notifications = Notification.where(userid: ally.id).order("created_at ASC").all
          Pusher['private-' + ally.id.to_s].trigger('new_notification', {notifications: notifications})

          NotificationMailer.notification_email(ally.id, data).deliver
        end

        if group_member.save
          format.html { redirect_to group_path(@group) }
          format.json { render :show, status: :created, location: @group }
        end
      end

      format.html { render :new }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @page_title = "Edit " + @group.name
    respond_to do |format|
      if @group.update(group_params) && !params[:group][:leader].nil?
        group_members = GroupMember.where(groupid: @group.id).all
        group_members.each do |member|
          group_member_id = GroupMember.where(groupid: @group.id, userid: member.userid).first.id
          if params[:group][:leader].include? member.userid.to_s
            GroupMember.update(group_member_id, groupid: @group.id, userid: member.userid, leader: true)
            pusher_type = 'add_group_leader'
          else
            GroupMember.update(group_member_id, groupid: @group.id, userid: member.userid, leader: false)
            pusher_type = 'remove_group_leader'
          end

          # Notify leaders that a leader has been added or removed
          uniqueid = pusher_type + '_' + current_user.id.to_s
          group_leaders = GroupMember.where(groupid: @group.id, leader: true).all
          group = Group.where(id: @group.id).first.name

          group_leaders.each do |leader|
            if leader.userid != current_user.id
              user = User.where(id: member.userid).first.name
              data = JSON.generate({
                user: user,
                groupid: @group.id,
                group: group,
                type: pusher_type,
                uniqueid: uniqueid
              })

              Notification.create(userid: leader.userid, uniqueid: uniqueid, data: data)
              notifications = Notification.where(userid: leader.userid).order("created_at ASC").all
              Pusher['private-' + leader.userid.to_s].trigger('new_notification', {notifications: notifications})

              NotificationMailer.notification_email(leader.userid, data).deliver
            end
          end
        end
        format.html { redirect_to groups_path }
        format.json { head :no_content }
      else
        @group_members = GroupMember.where(groupid: @group.id).all
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @group_member = GroupMember.create!(groupid: params[:groupid], userid: current_user.id, leader: false)

    uniqueid = 'new_group_member' + current_user.id.to_s

    group_leaders = GroupMember.where(groupid: params[:groupid], leader: true).all
    group = Group.where(id: params[:groupid]).first.name

    group_leaders.each do |leader|
      data = JSON.generate({
        user: current_user.name,
        groupid: params[:groupid],
        group: group,
        type: 'new_group_member',
        uniqueid: uniqueid
      })

      Notification.create(userid: leader.userid, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: leader.userid).order("created_at ASC").all
      Pusher['private-' + leader.userid.to_s].trigger('new_notification', {notifications: notifications})

      NotificationMailer.notification_email(leader.userid, data).deliver
    end

    respond_to do |format|
      format.html { redirect_to group_path(params[:groupid]), notice: 'You have joined this group.' }
      format.json { render :show, status: :created, location: Group.find(params[:groupid]) }
    end
  end

  def leave
    if params[:memberid].blank?
      memberid = current_user.id
    else
      memberid = params[:memberid]
      membername = User.where(id: memberid).first.name
    end

    group_name = Group.where(id: params[:groupid]).first.name

    # Cannot leave When you are the only leader
    is_leader = GroupMember.where(userid: memberid, groupid: params[:groupid], leader: true).count
    are_leaders = GroupMember.where(groupid: params[:groupid], leader: true).count
    if is_leader == 1 && are_leaders == is_leader
      respond_to do |format|
        format.html { redirect_to groups_path, alert: 'You cannot leave the group, you are the only leader.' }
        format.json { head :no_content }
      end
    else
      # Remove corresponding meetings
      meeting_members = MeetingMember.where(userid: memberid).all
      meeting_members.each do |member|
        if Meeting.where(id: member.meetingid, groupid: params[:groupid]).exists?
          member.destroy
        end
      end

      group_member = GroupMember.find_by(userid: memberid, groupid: params[:groupid])
      group_member.destroy

      if memberid == current_user.id
        respond_to do |format|
          format.html { redirect_to groups_path, notice: 'You have left ' + group_name }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to groups_path, notice: 'You have removed ' + membername + ' from ' + group_name }
          format.json { head :no_content }
        end
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    # Destroy group members
    GroupMember.where(groupid: @group.id).destroy_all

    # Destroy meetings and its members
    Meeting.where(groupid: @group.id).all.each do |meeting|
      MeetingMember.where(meetingid: meeting.id).destroy_all
      meeting.destroy
    end

    # Delete notifications for this group
    Notification.where("uniqueid ilike ?", "%new_group%").all.each do |notification|
      if JSON.parse(notification.data)["groupid"].to_i == @group.id.to_i
        notification.destroy
      end
    end

    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :description)
  end

  def if_not_signed_in
    if !user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.json { head :no_content }
      end
    end
  end
end
