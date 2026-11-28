# frozen_string_literal: true

module CommentsHelper
  include ResourceRouting

  def generate_comments(comments)
    viewable_comments = comments.select do |comment|
      CommentViewersService.viewable?(comment, current_user)
    end
    users_by_id = User.where(id: viewable_comments.map(&:comment_by)).index_by(&:id)
    viewable_comments.map { |comment| comment_hash(comment, users_by_id[comment.comment_by]) }
  end

  def show_with_comments(subject)
    model_name = subject.class.name.downcase
    if current_user.id != subject.user_id && hide_page?(subject)
      return redirect_to_path(
        resource_index_path(model_name, ResourceRouting::COMMENTABLE_DATA_TYPES)
      )
    end

    @page_author = page_author(subject)
    return unless subject.comments

    @comments = generate_comments(subject.comments.order(created_at: :desc))
  end

  private

  def hide_page?(subject)
    subject.user.paused? \
    || (!current_user.mutual_allies?(subject.user) \
    && !subject.viewer?(current_user)) \
    || !subject.published?
  end

  def created_at(value)
    t('created', created_at: TimeAgo.formatted_ago(value))
  end

  def comment_hash(comment, user)
    {
      currentUserUid: current_user.uid,
      commentByUid: user.uid,
      commentByName: user.name,
      commentByAvatar: user.avatar.url,
      commentByAdmin: user.admin?,
      comment: sanitize(comment.comment),
      viewers: CommentViewersService.viewers(comment, current_user),
      createdAt: created_at(comment.created_at),
      deleteAction: delete_action(comment)
    }.merge(id: comment.id, **paused_author_overrides(user))
  end

  def paused_author_overrides(user)
    return {} unless user.paused?

    {
      commentByUid: nil,
      commentByName: t('paused_accounts.comment_author'),
      commentByAvatar: nil,
      commentByAdmin: false,
      viewers: nil
    }
  end

  def page_author(subject)
    return User.find(current_user.id) unless current_user.id != subject.user_id

    User.find(subject.user_id)
  end

  def delete_action(comment)
    return unless CommentViewersService.deletable?(comment, current_user)

    delete_comments_path(comment_id: comment.id)
  end
end
