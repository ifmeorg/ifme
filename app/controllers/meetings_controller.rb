class MeetingsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings/new
  def new
    @groupid = params[:groupid]
    not_a_leader(@groupid)

    @meeting = Meeting.new
    @page_title = "New Meeting"
    
  end

  # GET /meetings/1/edit
  def edit
    @groupid = @meeting.groupid
    not_a_leader(@groupid)

    @page_title = "Edit " + @meeting.name
    @meeting_members = MeetingMember.where(meetingid: @meeting.id).all
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    groupid = meeting_params[:groupid]
    not_a_leader(groupid)
    @page_title = "New Meeting"
    respond_to do |format|
      if @meeting.save
        meeting_member = MeetingMember.new(meetingid: @meeting.id, userid: current_user.id, leader: true)

        if meeting_member.save
          # Notify group members that you created a new meeting
          group_members = GroupMember.where(groupid: @meeting.groupid).all
          group = Group.where(id: @meeting.groupid).first.name

          uniqueid = 'new_meeting_' + current_user.id.to_s

          group_members.each do |member|
            if member.userid != current_user.id
              data = JSON.generate({
              user: current_user.name, 
              groupid: @meeting.groupid,
              group: group,
              meeting: @meeting.name,
              type: 'new_meeting',
              uniqueid: uniqueid
              })

              Notification.create(userid: member.userid, uniqueid: uniqueid, data: data)
              notifications = Notification.where(userid: member.userid).order("created_at ASC").all
              Pusher['private-' + member.userid.to_s].trigger('new_notification', {notifications: notifications})
            end
          end

          format.html { redirect_to group_path(groupid) }
          format.json { render :show, status: :created, location: groupid }
        end
      end

      format.html { render :new }
      format.json { render json: @meeting.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    @page_title = "Edit " + @meeting.name
    respond_to do |format|
      if @meeting.update(meeting_params)
        error = false
        meeting_members = MeetingMember.where(meetingid: @meeting.id).all
        meeting_members.each do |member|
          meeting_member_id = MeetingMember.where(meetingid: @meeting.id, userid: member.userid).first.id
          if params[:meeting][:leader].nil?
            error = true
            format.html { redirect_to group_path(@meeting.groupid) }
            format.json { render :show, status: :ok, location: @meeting }
          elsif params[:meeting][:leader].include? member.userid.to_s
            MeetingMember.update(meeting_member_id, meetingid: @meeting.id, userid: member.userid, leader: true)
          else
            MeetingMember.update(meeting_member_id, meetingid: @meeting.id, userid: member.userid, leader: false)
          end
        end

        # Notify group members that the meeting has been updated
        group = Group.where(id: @meeting.groupid).first.name

        uniqueid = 'update_meeting_' + current_user.id.to_s

        meeting_members.each do |member|
          if member.userid != current_user.id
            data = JSON.generate({
            user: current_user.name, 
            groupid: @meeting.groupid,
            group: group,
            meeting: @meeting.name,
            type: 'update_meeting',
            uniqueid: uniqueid
            })

            Notification.create(userid: member.userid, uniqueid: uniqueid, data: data)
            notifications = Notification.where(userid: member.userid).order("created_at ASC").all
            Pusher['private-' + member.userid.to_s].trigger('new_notification', {notifications: notifications})
          end
        end

        @meeting_members = MeetingMember.where(meetingid: @meeting.id).all
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @meeting_member = MeetingMember.create!(meetingid: params[:meetingid], userid: current_user.id, leader: false)

    groupid = Meeting.where(id: params[:meetingid]).first.groupid

    respond_to do |format|
        format.html { redirect_to group_path(groupid), notice: 'You have joined this meeting.' }
        format.json { render :show, status: :created, location: group_path(groupid) }
    end
  end

  def leave
    meeting_name = Meeting.where(id: params[:meetingid]).first.name
    groupid = Meeting.where(id: params[:meetingid]).first.groupid

    # Cannot leave When you are the only leader
    is_leader = MeetingMember.where(userid: current_user.id, meetingid: params[:meetingid], leader: true).count
    are_leaders = MeetingMember.where(meetingid: params[:meetingid], leader: true).count
    if (is_leader == 1 && are_leaders == is_leader)
      respond_to do |format|
        format.html { redirect_to group_path(groupid), alert: 'You cannot leave the meeting, you are the only leader.' }
        format.json { head :no_content }
      end
    else
      # Remove user from meeting
      meeting_member = MeetingMember.find_by(userid: current_user.id, meetingid: params[:meetingid])
      meeting_member.destroy

      respond_to do |format|
        format.html { redirect_to group_path(groupid), notice: 'You have left ' + meeting_name }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    not_a_leader(@meeting.groupid)
    # Notify group members that the meeting has been deleted
    group_members = GroupMember.where(groupid: @meeting.groupid).all
    group = Group.where(id: @meeting.groupid).first.name

    uniqueid = 'remove_meeting_' + current_user.id.to_s

    group_members.each do |member|
      if member.userid != current_user.id
        data = JSON.generate({
        user: current_user.name, 
        groupid: @meeting.groupid,
        group: group,
        meeting: @meeting.name,
        type: 'remove_meeting',
        uniqueid: uniqueid
        })

        Notification.create(userid: member.userid, uniqueid: uniqueid, data: data)
        notifications = Notification.where(userid: member.userid).order("created_at ASC").all
        Pusher['private-' + member.userid.to_s].trigger('new_notification', {notifications: notifications})
      end
    end

    # Remove corresponding meeting members
    @meeting_members = MeetingMember.where(meetingid: @meeting.id).all

    @meeting_members.each do |item|
      item.destroy
    end

    groupid = @meeting.groupid
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to group_path(groupid) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      begin
        @meeting = Meeting.find(params[:id])
      rescue
        if @meeting.blank?
          respond_to do |format|
            format.html { redirect_to groups_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Checks if user is a meeting leader, if not redirect to group_path
    def not_a_leader(groupid)
      if !GroupMember.where(groupid: groupid, userid: current_user.id, leader: true).exists?
        respond_to do |format|
          format.html { redirect_to group_path(groupid) }
          format.json { head :no_content }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :description, :location, :date, :time, :maxmembers, :groupid)
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
