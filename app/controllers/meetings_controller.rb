class MeetingsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @page_title = "New Meeting"
    @groupid = params[:groupid]
  end

  # GET /meetings/1/edit
  def edit
    @groupid = @meeting.groupid
    @page_title = "Edit " + @meeting.name
    @meeting_members = MeetingMember.where(meetingid: @meeting.id).all
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    groupid = meeting_params[:groupid]
    @page_title = "New Meeting"
    respond_to do |format|
      if @meeting.save
        meeting_member = MeetingMember.new(meetingid: @meeting.id, userid: current_user.id, leader: true)
        if meeting_member.save
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
            break
          elsif params[:meeting][:leader].include? member.userid.to_s
            MeetingMember.update(meeting_member_id, meetingid: @meeting.id, userid: member.userid, leader: true)
          else
            MeetingMember.update(meeting_member_id, meetingid: @meeting.id, userid: member.userid, leader: false)
          end
        end
        if !error
          format.html { redirect_to meeting_path(@meeting) }
          format.json { render :show, status: :ok, location: @meeting }
        else
          @meeting_members = MeetingMember.where(meetingid: @meeting.id).all
          format.html { render :edit }
          format.json { render json: @meeting.errors, status: :unprocessable_entity }
        end
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
