# frozen_string_literal: true

# rubocop:disable ClassLength
class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show edit update destroy]

  # GET /meetings/1
  # GET /meetings/1.json
  # rubocop:disable MethodLength
  def show
    @meeting = Meeting.friendly.find(params[:id])
    @is_member = MeetingMember.where(
      meeting_id: @meeting.id,
      user_id: current_user.id
    ).exists?

    @is_leader = MeetingMember.where(
      meeting_id: @meeting.id,
      user_id: current_user.id,
      leader: true
    ).exists?

    if @is_leader
      @page_edit = edit_meeting_path(@meeting)
      @page_tooltip = t('meetings.edit_meeting')
    end

    @no_hide_page = false
    if hide_page(@meeting)
      redirect_to_path(group_path(@meeting.group_id))
    else
      @comment = Comment.new
      @comments = Comment.where(
        commentable_id: @meeting.id,
        commentable_type: 'meeting'
      ).all.order('created_at DESC')

      @no_hide_page = true
    end
  end
  # rubocop:enable MethodLength

  def comment
    params[:visibility] = 'all'
    comment_for('meeting')
  end

  # rubocop:disable MethodLength
  def delete_comment
    comment_exists = Comment.where(id: params[:commentid]).exists?
    is_my_comment = Comment.where(
      id: params[:commentid],
      comment_by: current_user.id
    ).exists?

    if comment_exists
      meeting_id = Comment.where(id: params[:commentid]).first.commentable_id
      is_my_meeting = MeetingMember.where(
        meeting_id: meeting_id,
        user_id: current_user.id,
        leader: true
      ).exists?
      is_member = MeetingMember.where(
        meeting_id: meeting_id,
        user_id: current_user.id
      ).exists?
    else
      is_my_meeting = false
      is_member = false
    end

    if comment_exists && ((is_my_comment && is_member) || is_my_meeting)
      CommentNotificationsService.remove(comment_id: params[:commentid],
                                         model_name: 'meeting')
    end

    head :ok
  end
  # rubocop:enable MethodLength

  # GET /meetings/new
  def new
    @group_id = params[:group_id]
    not_a_leader(@group_id)

    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
    @group_id = @meeting.group_id
    not_a_leader(@group_id)
    @meeting_members = MeetingMember.where(meeting_id: @meeting.id).all
  end

  # POST /meetings
  # POST /meetings.json
  # rubocop:disable MethodLength
  def create
    @meeting = Meeting.new(meeting_params)
    group_id = meeting_params[:group_id]
    not_a_leader(group_id)
    # rubocop:disable BlockLength
    respond_to do |format|
      if @meeting.save
        meeting_member = MeetingMember.new(
          meeting_id: @meeting.id,
          user_id: current_user.id,
          leader: true
        )

        if meeting_member.save
          # Notify group members that you created a new meeting
          group_members = GroupMember.where(group_id: @meeting.group_id).all
          MeetingNotificationsService.handle_members(current_user: current_user,
                                                     meeting: @meeting,
                                                     type: 'new_meeting',
                                                     members: group_members)
          format.html { redirect_to group_path(group_id) }
          format.json { render :show, status: :created, location: group_id }
        end
      end
      # rubocop:enable BlockLength

      format.html { render :new }
      format.json do
        render json: @meeting.errors, status: :unprocessable_entity
      end
    end
  end
  # rubocop:enable MethodLength

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  # rubocop:disable MethodLength
  def update
    if @meeting.update(meeting_params)
      meeting_members = MeetingMember.where(meeting_id: @meeting.id).all
      meeting_members.each do |member|
        meeting_member_id = MeetingMember.where(
          meeting_id: @meeting.id,
          user_id: member.user_id
        ).first.id
      end
      @meeting_members = MeetingMember.where(meeting_id: @meeting.id).all
      MeetingNotificationsService.handle_members(current_user: current_user,
                                                 meeting: @meeting,
                                                 type: 'update_meeting',
                                                 members: @meeting_members)
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
  # rubocop:enable MethodLength

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
      meeting_id = Meeting.where(id: params[:meeting_id]).first.id
      meeting = Meeting.where(id: params[:meeting_id]).first.name

      MeetingNotificationsService.handle_members(current_user: current_user,
                                                 meeting: meeting,
                                                 type: 'join_meeting',
                                                 members: meeting_leaders)

      respond_to do |format|
        format.html do
          redirect_to(meeting_path(meeting_id),
                      notice: t('meetings.join_success'))
        end
        format.json do
          render :show, status: :created, location: group_path(group_id)
        end
      end
    end
  end
  # rubocop:enable MethodLength

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
  # rubocop:enable MethodLength

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  # rubocop:disable MethodLength
  def destroy
    not_a_leader(@meeting.group_id)
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
  # rubocop:enable MethodLength

  private

  # Use callbacks to share common setup or constraints between actions.
  # rubocop:disable RescueStandardError
  def set_meeting
    @meeting = Meeting.friendly.find(params[:id])
  rescue
    redirect_to_path(groups_path)
  end
  # rubocop:enable RescueStandardError

  # Checks if user is a meeting leader, if not redirect to group_path
  def not_a_leader(group_id)
    group_member = GroupMember.where(
      group_id: group_id,
      user_id: current_user.id,
      leader: true
    )
    return if group_member.exists?
    redirect_to_path(group_path(group_id))
  end

  def meeting_params
    params.require(:meeting).permit(:name, :description, :location, :date,
                                    :time, :maxmembers, :group_id)
  end

  def hide_page(meeting)
    meeting_obj = Meeting.where(id: meeting.id)
    meeting_member = MeetingMember.where(
      meeting_id: meeting.id,
      user_id: current_user.id
    )
    !(meeting_obj.exists? && meeting_member.exists?)
  end
end
# rubocop:enable ClassLength
