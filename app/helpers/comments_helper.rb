# frozen_string_literal: true

module CommentsHelper
  include CommentsFormHelper

  def generate_comments(comments)
    result_comments = []
    comments = comments.select { |c| User.where(id: c.comment_by).exists? }
    comments.each do |comment|
      data = get_data(comment)
      next unless
        CommentViewers.current_user_viewable(comment, data, current_user)

      user = User.find(comment.comment_by)
      result_comments.push(comment_hash(comment, data, user))
    end
    result_comments
  end

  def show_with_comments(subject)
    model_name = record_model_name(subject)
    if current_user.id != subject.user_id && hide_page?(subject)
      path = send("#{model_name.pluralize}_path")
      return redirect_to_path(path)
    end
    set_show_with_comments_variables(subject, model_name)
  end

  def create_comment
    comment = Comment.create_from!(params[:comment])
    comment.notify_of_creation!(current_user)
    render json: success_response(comment.id), status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :bad_request
  end

  private

  def success_response(comment_id)
    {
      comment: generate_comments(Comment.where(id: comment_id)).first
    }
  end

  def created_at(value)
    t('created', created_at: TimeAgo.formatted_ago(value))
  end

  def comment_hash(comment, data, user)
    {
      id: comment.id,
      commentByUid: user.uid,
      commentByName: user.name,
      commentByAvatar: user.avatar.url,
      comment: sanitize(comment.comment),
      viewers: CommentViewers.build(comment, data, current_user),
      createdAt: created_at(comment.created_at),
      deletable: comment_deletable?(comment, comment.commentable_type)
    }
  end

  def page_author(subject)
    User.find(subject.user_id) if current_user.id != subject.user_id
    User.find(current_user.id)
  end

  def comment_action(model_name)
    comment_moments_path if model_name == 'moment'
    comment_strategies_path
  end

  def set_show_with_comments_variables(subject, model_name)
    @page_author = page_author(subject)
    @no_hide_page = true
    return unless subject.comment

    @comments = generate_comments(Comment.where(
      commentable_id: subject.id,
      commentable_type: model_name
    ).order(created_at: :desc))
  end

  def comment_deletable?(data, data_type)
    data.comment_by == current_user.id ||
      user_created_data?(data.commentable_id, data_type)
  end

  def user_created_data?(id, data_type)
    if data_type == 'meeting'
      MeetingMember.where(meeting_id: id, leader: true,
                          user_id: current_user.id).exists?
    end
    model = data_type.classify.constantize
    model.where(id: id, user_id: current_user.id).exists?
  end

  def get_data(comment)
    model = comment.commentable_type.classify.constantize
    model.find(comment.commentable_id)
  end
end
