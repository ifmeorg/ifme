# frozen_string_literal: true
class CommentController < ApplicationController
  def create
    comment_create(params[:comment])
  end

  def delete
    comment_delete(Comment.where(id: params[:comment_id]).first)
  end

  private

  def comment_create(comment)
    comment_id = CommentService.create(comment, current_user)
    response = {
      comment: generate_comments(Comment.where(id: comment_id)).first
    }
    render json: response, status: :ok
  rescue ActiveRecord::RecordInvalid
    bad_request_response
  end

  def comment_delete(comment)
    return bad_request_response if comment.nil?

    if %w[moment strategy].include?(comment.commentable_type)
      comment_delete_moment_or_strategy(comment)
    elsif comment.commentable_type == 'meeting'
      comment_delete_meeting(comment)
    else
      bad_request_response
    end
  end

  def bad_request_response
    render json: {}, status: :bad_request
  end

  def remove_meeting_notification!
    CommentNotificationsService.remove(
      comment_id: params[:comment_id],
      model_name: 'meeting'
    )
  end

  def remove_meeting_notification(comment, meeting)
    my_comment = comment.present? && (comment.comment_by == current_user.id)
    return unless (my_comment && meeting.member?(current_user)) ||
                  meeting.led_by?(current_user)

    remove_meeting_notification!
  end

  def comment_delete_moment_or_strategy(comment)
    comment_id = CommentService.delete(comment, current_user)
    render json: { id: comment_id }, status: :ok
  rescue ArgumentError
    bad_request_response
  end

  def comment_delete_meeting(comment)
    if comment.present?
      meeting_id = comment.commentable_id
      meeting = Meeting.find_by(id: meeting_id)
      remove_meeting_notification(comment, meeting)
      render json: { id: comment.id }, status: :ok
    else
      bad_request_response
    end
  end
end
