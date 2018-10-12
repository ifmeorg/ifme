# frozen_string_literal: true

module CommentsHelper
  def generate_comments(comments)
    result_comments = []
    comments = comments.select { |c| User.where(id: c.comment_by).exists? }
    comments.each do |comment|
      next unless CommentViewersService.viewable(comment, current_user)

      user = User.find(comment.comment_by)
      result_comments.push(comment_hash(comment, user))
    end
    result_comments
  end

  def show_with_comments(subject)
    model_name = record_model_name(subject)
    if current_user.id != subject.user_id && hide_page?(subject)
      return redirect_to_path(send("#{model_name.pluralize}_path"))
    end

    set_show_with_comments_variables(subject, model_name)
  end

  private

  def created_at(value)
    t('created', created_at: TimeAgo.formatted_ago(value))
  end

  def comment_hash(comment, user)
    {
      id: comment.id,
      commentByUid: user.uid,
      commentByName: user.name,
      commentByAvatar: user.avatar.url,
      comment: sanitize(comment.comment),
      viewers: CommentViewersService.viewers(comment, current_user),
      createdAt: created_at(comment.created_at),
      deleteAction: delete_action(comment)
    }
  end

  def page_author(subject)
    return User.find(current_user.id) unless current_user.id != subject.user_id

    User.find(subject.user_id)
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

  def delete_action(comment)
    return unless CommentViewersService.deletable(comment, current_user)

    delete_comment_index_path(comment_id: comment.id)
  end
end
