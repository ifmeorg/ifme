# frozen_string_literal: true
module CommentActions
  extend ActiveSupport::Concern

  included do
    helper_method :create_comment, :delete_comment
  end

  def comment_create(comment)
    comment_id = CommentService.create(comment, current_user)
    response = {
      comment: generate_comments(Comment.where(id: comment_id)).first
    }
    render json: response, status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :bad_request
  end

  def comment_delete(comment)
    comment_id = CommentService.delete(comment, current_user)
    render json: { id: comment_id }, status: :ok
  rescue ArgumentError
    render json: {}, status: :bad_request
  end
end
