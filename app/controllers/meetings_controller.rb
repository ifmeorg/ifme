# frozen_string_literal: true
class MeetingsController < ApplicationController
  include MeetingsHelper
  include MeetingFormHelper
  before_action :set_meeting, only: %i[show edit update destroy]

  # GET /meetings/1
  def show
    if @meeting.member?(current_user)
      @comments = generate_comments(@meeting.comments.order(created_at: :desc))
    elsif !@meeting.group.member?(current_user)
      redirect_to_path(groups_path)
    end
  end

  # GET /meetings/new
  def new
    @group = Group.find_by(id: params[:group_id])
    redirect_unless_leader_for(@group) && return
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
    redirect_unless_leader_for(@meeting.group) && return
    @meeting_members = @meeting.members
  end

  # POST /meetings
  # rubocop:disable MethodLength
  def create
    @meeting = Meeting.new(meeting_params)
    @group = Group.find_by(id: meeting_params[:group_id])
    redirect_unless_leader_for(@group) && return

    if @meeting.save
      meeting_member = @meeting.meeting_members.new(
        user_id: current_user.id, leader: true
      )
      if meeting_member.save
        # Notify group members that you created a new meeting
        send_notification(@meeting, @meeting.group.members, 'new_meeting')
        redirect_to group_path(@group.id)
      end
    else
      render :new
    end
  end
  # rubocop:enable MethodLength

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      send_notification(@meeting, @meeting.members, 'update_meeting')
      redirect_to meeting_path(@meeting.slug)
    else
      render :edit
    end
  end

  def join
    meeting = Meeting.find(params[:meeting_id])
    if meeting.member?(current_user)
      redirect_to group_path(meeting.group_id)
    else
      @meeting_member = meeting.meeting_members.create!(
        user_id: current_user.id, leader: false
      )
      send_notification(meeting, meeting.leaders, 'join_meeting')

      redirect_to(meeting_path(meeting.id), notice: t('meetings.join_success'))
    end
  end

  def leave
    meeting = Meeting.find(params[:meeting_id])

    # Cannot leave When you are the only leader
    if meeting.led_by?(current_user) && meeting.leaders.count == 1
      redirect_to(group_path(meeting.group_id),
                  alert: t('meetings.leave.error'))
    else
      # Remove user from meeting
      meeting.meeting_members.find_by(user_id: current_user.id).destroy
      redirect_to(group_path(meeting.group_id),
                  notice: t('meetings.leave.success', meeting: meeting.name))
    end
  end

  # DELETE /meetings/1
  def destroy
    redirect_unless_leader_for(@meeting.group) && return
    # Notify group members that the meeting has been deleted
    send_notification(@meeting, @meeting.group.members, 'remove_meeting')
    # Remove corresponding meeting members
    @meeting.meeting_members.destroy_all
    @meeting.destroy
    redirect_to_path(group_path(@meeting.group_id))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(groups_path)
  end

  # Checks if user is a meeting leader, if not redirect to group_path
  def redirect_unless_leader_for(group)
    redirect_to_path(group_path(group.id)) unless group.led_by?(current_user)
  end

  def meeting_params
    params.require(:meeting).permit(:name, :description, :location, :date,
                                    :time, :maxmembers, :group_id)
  end

  def send_notification(meeting, members, type)
    MeetingNotificationsService.handle_members(
      current_user: current_user,
      meeting: meeting,
      type: type,
      members: members
    )
  end
end
