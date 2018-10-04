# frozen_string_literal: true

# rubocop:disable ClassLength
class MeetingsController < ApplicationController
  include CommentsHelper

  before_action :set_meeting, only: %i[show edit update destroy]

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.friendly.find(params[:id])
    @is_member = @meeting.member?(current_user)
    @is_leader = @meeting.led_by?(current_user)
    if @is_member
      @no_hide_page = true
      @comment = Comment.new
      @comments = @meeting.comments
    elsif !@meeting.group.member?(current_user)
      redirect_to_path(groups_path)
    end
  end

  def comment
    params[:visibility] = 'all'
    comment_for('meeting')
  end

  def delete_comment
    comment = Comment.find_by(id: params[:commentid])

    if comment.present?
      meeting_id = comment.commentable_id
      meeting = Meeting.find_by(id: meeting_id)
      remove_notification(comment, meeting)
    end
    head :ok
  end

  # GET /meetings/new
  def new
    @group = Group.find_by(id: params[:group_id])
    redirect_unless_leader_for(@group)
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
    redirect_unless_leader_for(@meeting.group)
    @meeting_members = @meeting.members
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    @group = Group.find_by(id: meeting_params[:group_id])
    redirect_unless_leader_for(@group)
    respond_to do |format|
      if @meeting.save
        meeting_member = @meeting.meeting_members.new(
          user_id: current_user.id, leader: true
        )
        if meeting_member.save
          # Notify group members that you created a new meeting
          send_notification(@meeting, @meeting.group.members, 'new_meeting')
          format.html { redirect_to group_path(@group.id) }
          format.json { render :show, status: :created, location: @group.id }
        end
      end
      format.html { render :new }
      format.json { render_json(@meeting.errors, 'unprocessable_entity') }
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    if @meeting.update(meeting_params)
      send_notification(@meeting, @meeting.members, 'update_meeting')

      respond_to do |format|
        format.html { redirect_to meeting_path(@meeting.slug) }
        format.json { render_json(@meeting.errors, 'unprocessable_entity') }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render_json(@meeting.errors, 'unprocessable_entity') }
      end
    end
  end

  def join
    meeting = Meeting.find(params[:meeting_id])
    if meeting.member?(current_user)
      respond_to do |format|
        format.html { redirect_to group_path(meeting.group_id) }
        format.json { render :show, location: group_path(meeting.group_id) }
      end
    else
      @meeting_member = meeting.meeting_members.create!(
        user_id: current_user.id,
        leader: false
      )
      send_notification(meeting, meeting.leaders, 'join_meeting')

      respond_to do |format|
        format.html do
          redirect_to(meeting_path(meeting.id),
                      notice: t('meetings.join_success'))
        end
        format.json do
          render :show, status: :created, location: group_path(meeting.group_id)
        end
      end
    end
  end

  def leave
    meeting = Meeting.find(params[:meeting_id])

    # Cannot leave When you are the only leader
    if meeting.led_by?(current_user) && meeting.leaders.count == 1
      respond_to do |format|
        format.html do
          redirect_to(group_path(meeting.group_id),
                      alert: t('meetings.leave.error'))
        end
        format.json { head :no_content }
      end
    else
      # Remove user from meeting
      meeting.meeting_members.find_by(user_id: current_user.id).destroy

      respond_to do |format|
        format.html do
          redirect_to(
            group_path(meeting.group_id),
            notice: t('meetings.leave.success', meeting: meeting.name)
          )
        end
        format.json { head :no_content }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    redirect_unless_leader_for(@meeting.group)
    # Notify group members that the meeting has been deleted
    send_notification(@meeting, group.members, 'remove_meeting')
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

  def remove_notification!
    CommentNotificationsService.remove(
      comment_id: params[:commentid],
      model_name: 'meeting'
    )
  end

  def remove_notification(comment, meeting)
    remove_notification! if (my_comment?(comment) && \
                            meeting.member?(current_user)) || \
                            meeting.led_by?(current_user)
  end

  def my_comment?(comment)
    comment.present? && (comment.comment_by == current_user.id)
  end

  def render_json(message, status)
    render json: message, status: status.to_sym
  end
end
