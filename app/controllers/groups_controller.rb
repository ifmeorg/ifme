class GroupsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.groups
                          .includes(:group_members)
                          .order("groups.created_at DESC")
    @page_title = "Groups"
    @page_tooltip = "New group"
    @page_new = new_group_path
    @available_groups = current_user.available_groups("groups.created_at DESC")
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @page_title = @group.name

    if @group.members.include? current_user
      @meetings = @group.meetings.includes(:leaders)
    end

    if @group.led_by?(current_user)
      @page_new = new_meeting_path(group_id: @group.id)
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
    @group_members = GroupMember.where(group_id: @group.id).all
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @page_title = "New Group"
    respond_to do |format|
      if @group.save
        group_member = GroupMember.new(group_id: @group.id, user_id: current_user.id, leader: true)

        # Notify allies that you created a new group
        accepted_allies = current_user.allies_by_status(:accepted)

        uniqueid = 'new_group_' + current_user.id.to_s

        accepted_allies.each do |ally|
          data = JSON.generate({
            user: current_user.name,
            group_id: @group.id,
            group: @group.name,
            type: 'new_group',
            uniqueid: uniqueid
          })

          Notification.create(user_id: ally.id, uniqueid: uniqueid, data: data)
          notifications = Notification.where(user_id: ally.id).order("created_at ASC").all
          Pusher['private-' + ally.id.to_s].trigger('new_notification', {notifications: notifications})

          NotificationMailer.notification_email(ally.id, data).deliver_now
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
        group_members = GroupMember.where(group_id: @group.id).all
        group_members.each do |member|
          group_member_id = GroupMember.where(group_id: @group.id, user_id: member.user_id).first.id
          if params[:group][:leader].include? member.user_id.to_s
            GroupMember.update(group_member_id, group_id: @group.id, user_id: member.user_id, leader: true)
            pusher_type = 'add_group_leader'
          else
            GroupMember.update(group_member_id, group_id: @group.id, user_id: member.user_id, leader: false)
            pusher_type = 'remove_group_leader'
          end

          # Notify leaders that a leader has been added or removed
          uniqueid = pusher_type + '_' + current_user.id.to_s
          group_leaders = GroupMember.where(group_id: @group.id, leader: true).all
          group = Group.where(id: @group.id).first.name

          group_leaders.each do |leader|
            if leader.user_id != current_user.id
              user = User.where(id: member.user_id).first.name
              data = JSON.generate({
                user: user,
                group_id: @group.id,
                group: group,
                type: pusher_type,
                uniqueid: uniqueid
              })

              Notification.create(user_id: leader.user_id, uniqueid: uniqueid, data: data)
              notifications = Notification.where(user_id: leader.user_id).order("created_at ASC").all
              Pusher['private-' + leader.user_id.to_s].trigger('new_notification', {notifications: notifications})

              NotificationMailer.notification_email(leader.user_id, data).deliver_now
            end
          end
        end
        format.html { redirect_to groups_path }
        format.json { head :no_content }
      else
        @group_members = GroupMember.where(group_id: @group.id).all
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @group_member = GroupMember.create!(group_id: params[:group_id], user_id: current_user.id, leader: false)

    uniqueid = 'new_group_member' + current_user.id.to_s

    group_leaders = GroupMember.where(group_id: params[:group_id], leader: true).all
    group = Group.where(id: params[:group_id]).first.name

    group_leaders.each do |leader|
      data = JSON.generate({
        user: current_user.name,
        group_id: params[:group_id],
        group: group,
        type: 'new_group_member',
        uniqueid: uniqueid
      })

      Notification.create(user_id: leader.user_id, uniqueid: uniqueid, data: data)
      notifications = Notification.where(user_id: leader.user_id).order("created_at ASC").all
      Pusher['private-' + leader.user_id.to_s].trigger('new_notification', {notifications: notifications})

      NotificationMailer.notification_email(leader.user_id, data).deliver_now
    end

    respond_to do |format|
      format.html { redirect_to group_path(params[:group_id]), notice: 'You have joined this group.' }
      format.json { render :show, status: :created, location: Group.find(params[:group_id]) }
    end
  end

  def leave
    if params[:memberid].blank?
      memberid = current_user.id
    else
      memberid = params[:memberid]
      membername = User.where(id: memberid).first.name
    end

    group_name = Group.where(id: params[:group_id]).first.name

    # Cannot leave When you are the only leader
    is_leader = GroupMember.where(user_id: memberid, group_id: params[:group_id], leader: true).count
    are_leaders = GroupMember.where(group_id: params[:group_id], leader: true).count
    if is_leader == 1 && are_leaders == is_leader
      respond_to do |format|
        format.html { redirect_to groups_path, alert: 'You cannot leave the group, you are the only leader.' }
        format.json { head :no_content }
      end
    else
      group_member = GroupMember.find_by(user_id: memberid, group_id: params[:group_id])
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
    GroupMember.where(group_id: @group.id).destroy_all

    # Destroy meetings and its members
    Meeting.where(group_id: @group.id).all.each do |meeting|
      MeetingMember.where(meetingid: meeting.id).destroy_all
      meeting.destroy
    end

    # Delete notifications for this group
    Notification.where("uniqueid ilike ?", "%new_group%").all.each do |notification|
      if JSON.parse(notification.data)["group_id"].to_i == @group.id.to_i
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
