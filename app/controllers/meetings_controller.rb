# frozen_string_literal: true

# rubocop:disable ClassLength
class MeetingsController < ApplicationController
  include CommentsHelper

  before_action :set_meeting, only: %i[show edit update destroy]
  before_action :define_members, only: %i[show]

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    if @is_member.present?
      @no_hide_page = true
      @comment = Comment.new
      @comments = Comment.meeting_comments(@meeting)
    elsif !@is_group_member
      redirect_to_path(groups_path)
    end
  end

  def comment
    params[:visibility] = 'all'
    comment_for('meeting')
  end

  # rubocop:disable MethodLength
  def delete_comment
    comment = Comment.find_by(id: params[:commentid])
    is_my_comment = comment.present? && comment.comment_by == current_user.id

    if comment.present?
      meeting_id = comment.commentable_id
      meeting = Meeting.find_by(id: meeting_id)
      is_my_meeting = MeetingMember.find_by(
        id: current_user.id, leader: true
      )
      is_member = meeting.members.find_by(id: current_user).present?
    end

    if comment.present? && ((is_my_comment&& is_member) || is_my_meeting)
      remove_notification
    end
    head :ok
  end

  # GET /meetings/new
  def new
    leader?(Group.find_by(id: params[:group_id]))
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
    leader?(@meeting.group)
    @meeting_members = @meeting.members
  end

  # POST /meetings
  # POST /meetings.json
  # rubocop:disable MethodLength
  def create
    @meeting = Meeting.new(meeting_params)
    leader?(Group.find_by(id: meeting_params[:group_id]))
    respond_to do |format|
      if @meeting.save
        meeting_member = MeetingMember.new(
          id: current_user.id,
          leader: true
        )
        if meeting_member.save
          # Notify group members that you created a new meeting
          group_members = @meeting.group.members
          notify_members(@meeting, group_members, 'new_meeting')
          format.html { redirect_to group_path(group_id) }
          format.json { render :show, status: :created, location: group_id }
        end
      end
      format.html { render :new }
      format.json do
        render json: @meeting.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    if @meeting.update(meeting_params)
      @meeting_members = @meeting.members
      notify_members(@meeting, @meeting_members, 'update_meeting')

      respond_to do |format|
        format.html { redirect_to meeting_path(@meeting.slug) }
        format.json do
          render json: @meeting.errors, status: :unprocessable_entity
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json do
          render json: @meeting.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # rubocop:disable MethodLength
  def join
    group_id = Meeting.where(id: params[:meeting_id]).first.group_id
    meeting_member = MeetingMember.where(
      meeting_id: params[:meeting_id],
      user_id: current_user.id
    )

    if meeting_member.exists?
      respond_to do |format|
        format.html { redirect_to group_path(group_id) }
        format.json { render :show, location: group_path(group_id) }
      end
    else
      @meeting_member = MeetingMember.create!(
        meeting_id: params[:meeting_id],
        user_id: current_user.id,
        leader: false
      )

      # Notify meeting leaders
      meeting_leaders = MeetingMember.where(
        meeting_id: params[:meeting_id],
        leader: true
      ).all
      meeting = Meeting.find_by(id: params[:meeting_id])
      notify_members(meeting, meeting_leaders, 'join_meeting')

      respond_to do |format|
        format.html do
          redirect_to(meeting_path(params[:meeting_id]),
                      notice: t('meetings.join_success'))
        end
        format.json do
          render :show, status: :created, location: group_path(group_id)
        end
      end
    end
  end

  # rubocop:disable MethodLength
  def leave
    meeting_name = Meeting.where(id: params[:meeting_id]).first.name
    group_id = Meeting.where(id: params[:meeting_id]).first.group_id

    # Cannot leave When you are the only leader
    is_leader = MeetingMember.where(
      user_id: current_user.id,
      meeting_id: params[:meeting_id],
      leader: true
    ).count
    are_leaders = MeetingMember.where(
      meeting_id: params[:meeting_id],
      leader: true
    ).count
    if is_leader == 1 && are_leaders == is_leader
      respond_to do |format|
        format.html do
          redirect_to(group_path(group_id), alert: t('meetings.leave.error'))
        end
        format.json { head :no_content }
      end
    else
      # Remove user from meeting
      meeting_member = MeetingMember.find_by(
        user_id: current_user.id,
        meeting_id: params[:meeting_id]
      )
      meeting_member.destroy

      respond_to do |format|
        format.html do
          redirect_to(
            group_path(group_id),
            notice: t(
              'meetings.leave.success',
              meeting: meeting_name
            )
          )
        end
        format.json { head :no_content }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  # rubocop:disable MethodLength
  def destroy
    leader?(@meeting.group)
    # Notify group members that the meeting has been deleted
    group_members = GroupMember.where(group_id: @meeting.group_id).all
    notifications_for_meeting_members(@meeting, group_members, 'remove_meeting')
    # Remove corresponding meeting members
    @meeting_members = MeetingMember.where(meeting_id: @meeting.id).all
    @meeting_members.each(&:destroy)
    group_id = @meeting.group_id
    @meeting.destroy
    redirect_to_path(group_path(group_id))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.friendly.find(params[:id])
  rescue StandardError
    redirect_to_path(groups_path)
  end

  # Checks if user is a meeting leader, if not redirect to group_path
  def leader?(group)
    return if GroupMember.find_by(
      user_id: current_user.id, group_id: group.id, leader: true
    ).present?

    redirect_to_path(group_path(group.id))
  end

  def meeting_params
    params.require(:meeting).permit(:name, :description, :location, :date,
                                    :time, :maxmembers, :group_id)
  end

  def define_members
    @meeting = Meeting.friendly.find(params[:id])
    @is_member = @meeting.members.find_by(id: current_user.id)
    @is_group_member = @meeting.group.members.find_by(id: current_user.id)
    @is_leader = MeetingMember.find_by(
      user_id: current_user.id, meeting_id: @meeting.id, leader: true
    )
  end

  def notify_members(meeting, members, type)
    MeetingNotificationsService.handle_members(
      current_user: current_user,
      meeting: meeting,
      type: type,
      members: members
    )
  end

  def remove_notification
    CommentNotificationsService.remove(
      comment_id: params[:commentid],
      model_name: 'meeting'
    )
  end
end
