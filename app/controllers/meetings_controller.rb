class MeetingsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    @is_member = MeetingMember.where(meetingid: @meeting.id, user_id: current_user.id).exists?
    @page_title = @meeting.name

    @is_leader = MeetingMember.where(meetingid: @meeting.id, user_id: current_user.id, leader: true).exists?

    if @is_leader
      @page_edit = edit_meeting_path(@meeting)
      @page_tooltip = "Edit meeting"
    end

    @no_hide_page = false
    if hide_page(@meeting)
      respond_to do |format|
        format.html { redirect_to group_path(@meeting.group_id) }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      @comments = Comment.where(:commented_on => @meeting.id, :comment_type => "meeting").all.order("created_at DESC")
      @no_hide_page = true
    end
  end

  def comment
    @comment = Comment.new(:comment_type => params[:comment_type], :commented_on => params[:commented_on], :user_id => params[:user_id], :comment => params[:comment], :visibility => 'all')

    if !@comment.save
      result = { no_save: true }
      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end

    # Notify MeetingMembers except for commenter that there is a new comment
    MeetingMember.where(meetingid: @comment.commented_on).all.each do |member|
      if member.user_id != current_user.id
        meeting_name = Meeting.where(id: @comment.commented_on).first.name
        cutoff = false
        if @comment.comment.length > 80
          cutoff = true
        end
        uniqueid = 'comment_on_meeting' + '_' + @comment.id.to_s

        data = JSON.generate({
          user: current_user.name,
          meetingid: @comment.commented_on,
          meeting: meeting_name,
          commentid: @comment.id,
          comment: @comment.comment[0..80],
          cutoff: cutoff,
          type: 'comment_on_meeting',
          uniqueid: uniqueid
          })

        Notification.create(user_id: member.user_id, uniqueid: uniqueid, data: data)
        notifications = Notification.where(user_id: member.user_id).order("created_at ASC").all
        Pusher['private-' + member.user_id.to_s].trigger('new_notification', {notifications: notifications})

        NotificationMailer.notification_email(member.user_id, data).deliver_now
      end
    end

    if @comment.save
      result = generate_comment(@comment, 'meeting')
      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end
  end

  def delete_comment
    comment_exists = Comment.where(id: params[:commentid]).exists?
    is_my_comment = Comment.where(id: params[:commentid], user_id: current_user.id).exists?

    if comment_exists
      meetingid = Comment.where(id: params[:commentid]).first.commented_on
      is_my_meeting = MeetingMember.where(meetingid: meetingid, user_id: current_user.id, leader: true).exists?
      is_member = MeetingMember.where(meetingid: meetingid, user_id: current_user.id).exists?
    else
      is_my_meeting = false
      is_member = false
    end

    if comment_exists && ((is_my_comment && is_member) || is_my_meeting)
      Comment.find(params[:commentid]).destroy

      # Delete corresponding notifcations
      public_uniqueid = 'comment_on_meeting_' + params[:commentid].to_s
      Notification.where(uniqueid: public_uniqueid).destroy_all
    end

    render :nothing => true
  end

  # GET /meetings/new
  def new
    @group_id = params[:group_id]
    not_a_leader(@group_id)

    @meeting = Meeting.new
    @page_title = "New Meeting"

  end

  # GET /meetings/1/edit
  def edit
    @group_id = @meeting.group_id
    not_a_leader(@group_id)

    @page_title = "Edit " + @meeting.name
    @meeting_members = MeetingMember.where(meetingid: @meeting.id).all
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    group_id = meeting_params[:group_id]
    not_a_leader(group_id)
    @page_title = "New Meeting"
    respond_to do |format|
      if @meeting.save
        meeting_member = MeetingMember.new(meetingid: @meeting.id, user_id: current_user.id, leader: true)

        if meeting_member.save
          # Notify group members that you created a new meeting
          group_members = GroupMember.where(group_id: @meeting.group_id).all
          group = Group.where(id: @meeting.group_id).first.name

          uniqueid = 'new_meeting_' + current_user.id.to_s

          group_members.each do |member|
            if member.user_id != current_user.id
              data = JSON.generate({
              user: current_user.name,
              meetingid: @meeting.id,
              group: group,
              meeting: @meeting.name,
              type: 'new_meeting',
              uniqueid: uniqueid
              })

              Notification.create(user_id: member.user_id, uniqueid: uniqueid, data: data)
              notifications = Notification.where(user_id: member.user_id).order("created_at ASC").all
              Pusher['private-' + member.user_id.to_s].trigger('new_notification', {notifications: notifications})

              NotificationMailer.notification_email(member.user_id, data).deliver_now
            end
          end

          format.html { redirect_to group_path(group_id) }
          format.json { render :show, status: :created, location: group_id }
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
          meeting_member_id = MeetingMember.where(meetingid: @meeting.id, user_id: member.user_id).first.id
          if params[:meeting][:leader].nil?
            error = true
            format.html { redirect_to group_path(@meeting.group_id) }
            format.json { render :show, status: :ok, location: @meeting }
          elsif params[:meeting][:leader].include? member.user_id.to_s
            MeetingMember.update(meeting_member_id, meetingid: @meeting.id, user_id: member.user_id, leader: true)
          else
            MeetingMember.update(meeting_member_id, meetingid: @meeting.id, user_id: member.user_id, leader: false)
          end
        end

        # Notify group members that the meeting has been updated
        group = Group.where(id: @meeting.group_id).first.name

        uniqueid = 'update_meeting_' + current_user.id.to_s

        meeting_members.each do |member|
          if member.user_id != current_user.id
            data = JSON.generate({
            user: current_user.name,
            meetingid: @meeting.id,
            group: group,
            meeting: @meeting.name,
            type: 'update_meeting',
            uniqueid: uniqueid
            })

            Notification.create(user_id: member.user_id, uniqueid: uniqueid, data: data)
            notifications = Notification.where(user_id: member.user_id).order("created_at ASC").all
            Pusher['private-' + member.user_id.to_s].trigger('new_notification', {notifications: notifications})

            NotificationMailer.notification_email(member.user_id, data).deliver_now
          end
        end

        @meeting_members = MeetingMember.where(meetingid: @meeting.id).all
        format.html { redirect_to meeting_path(@meeting.id) }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    group_id = Meeting.where(id: params[:meetingid]).first.group_id

    if MeetingMember.where(meetingid: params[:meetingid], user_id: current_user.id).exists?
      respond_to do |format|
          format.html { redirect_to group_path(group_id) }
          format.json { render :show, location: group_path(group_id) }
      end
    else
      @meeting_member = MeetingMember.create!(meetingid: params[:meetingid], user_id: current_user.id, leader: false)

      # Notify meeting leaders
      meeting_leaders = MeetingMember.where(meetingid: params[:meetingid], leader: true).all
      meetingid = Meeting.where(id: params[:meetingid]).first.id
      group = Group.where(id: group_id).first.name
      meeting = Meeting.where(id: params[:meetingid]).first.name

      uniqueid = 'join_meeting_' + current_user.id.to_s

      meeting_leaders.each do |leader|
        if leader.user_id != current_user.id
          data = JSON.generate({
          user: current_user.name,
          meetingid: meetingid,
          group: group,
          meeting: meeting,
          type: 'join_meeting',
          uniqueid: uniqueid
          })

          Notification.create(user_id: leader.user_id, uniqueid: uniqueid, data: data)
          notifications = Notification.where(user_id: leader.user_id).order("created_at ASC").all
          Pusher['private-' + leader.user_id.to_s].trigger('new_notification', {notifications: notifications})

          NotificationMailer.notification_email(leader.user_id, data).deliver_now
        end
      end

      respond_to do |format|
          format.html { redirect_to meeting_path(meetingid), notice: 'You have joined this meeting.' }
          format.json { render :show, status: :created, location: group_path(group_id) }
      end
    end
  end

  def leave
    meeting_name = Meeting.where(id: params[:meetingid]).first.name
    group_id = Meeting.where(id: params[:meetingid]).first.group_id

    # Cannot leave When you are the only leader
    is_leader = MeetingMember.where(user_id: current_user.id, meetingid: params[:meetingid], leader: true).count
    are_leaders = MeetingMember.where(meetingid: params[:meetingid], leader: true).count
    if (is_leader == 1 && are_leaders == is_leader)
      respond_to do |format|
        format.html { redirect_to group_path(group_id), alert: 'You cannot leave the meeting, you are the only leader.' }
        format.json { head :no_content }
      end
    else
      # Remove user from meeting
      meeting_member = MeetingMember.find_by(user_id: current_user.id, meetingid: params[:meetingid])
      meeting_member.destroy

      respond_to do |format|
        format.html { redirect_to group_path(group_id), notice: 'You have left ' + meeting_name }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    not_a_leader(@meeting.group_id)
    # Notify group members that the meeting has been deleted
    group_members = GroupMember.where(group_id: @meeting.group_id).all
    group = Group.where(id: @meeting.group_id).first.name

    uniqueid = 'remove_meeting_' + current_user.id.to_s

    group_members.each do |member|
      if member.user_id != current_user.id
        data = JSON.generate({
        user: current_user.name,
        group_id: @meeting.group_id,
        group: group,
        meeting: @meeting.name,
        type: 'remove_meeting',
        uniqueid: uniqueid
        })

        Notification.create(user_id: member.user_id, uniqueid: uniqueid, data: data)
        notifications = Notification.where(user_id: member.user_id).order("created_at ASC").all
        Pusher['private-' + member.user_id.to_s].trigger('new_notification', {notifications: notifications})

        NotificationMailer.notification_email(member.user_id, data).deliver_now
      end
    end

    # Remove corresponding meeting members
    @meeting_members = MeetingMember.where(meetingid: @meeting.id).all

    @meeting_members.each do |item|
      item.destroy
    end

    group_id = @meeting.group_id
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to group_path(group_id) }
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
    def not_a_leader(group_id)
      if !GroupMember.where(group_id: group_id, user_id: current_user.id, leader: true).exists?
        respond_to do |format|
          format.html { redirect_to group_path(group_id) }
          format.json { head :no_content }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :description, :location, :date, :time, :maxmembers, :group_id)
    end

    def hide_page(meeting)
      if Meeting.where(id: meeting.id).exists? && MeetingMember.where(meetingid: meeting.id, user_id: current_user.id).exists?
        return false
      end
      return true
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
