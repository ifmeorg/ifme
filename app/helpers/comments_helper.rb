# frozen_string_literal: true

module CommentsHelper
  # rubocop:disable MethodLength
  def generate_comments(comments)
    result_comments = []
    comments = comments.select{|c| User.where(id: c.comment_by).exists?}
    comments.each do |comment|
      data = moment_or_strategy_data(comment)
      if CommentVisibility.viewable_to_current_user(comment, data, current_user)
        user = User.find(comment.comment_by)
        comment_hash = {
          id: comment.id,
          commentByUid: user.uid,
          commentByName: user.name,
          commentByAvatar: user.avatar.url,
          comment: sanitize(comment.comment),
          visibility: get_visibility(comment, data),
          createdAt: t(
            'created',
            created_at: TimeAgo.formatted_ago(comment.created_at)
          ),
          deletable: comment_deletable?(comment, comment.commentable_type)
        }
        result_comments.push(comment_hash)
      end
    end
    result_comments
  end
  # rubocop:enable MethodLength

  def show_with_comments(subject)
    model_name = record_model_name(subject)
    if current_user.id != subject.user_id && hide_page?(subject)
      path = send("#{model_name.pluralize}_path")
      return redirect_to_path(path)
    end
    set_show_with_comments_variables(subject, model_name)
  end

  # def comment_for(model_name)
  #   @comment = Comment.create_from!(params)
  #   @comment.notify_of_creation!(current_user)

  #   respond_with_json(
  #     generate_comment(@comment, model_name)
  #   )
  # rescue ActiveRecord::RecordInvalid
  #   respond_not_saved
  # end

  private

  # rubocop:disable MethodLength
  def set_show_with_comments_variables(subject, model_name)
    @page_author = if current_user.id != subject.user_id
                     User.find(subject.user_id)
                   else
                     User.find(current_user.id)
                   end
    @no_hide_page = true
    # rubocop:disable GuardClause
    if subject.comment
      @comment = Comment.new
      @comments = generate_comments(Comment.where(
        commentable_id: subject.id,
        commentable_type: model_name
      ).order(created_at: :desc))
    end
    # rubocop:enable GuardClause
  end
  # rubocop:enable MethodLength

  def comment_deletable?(data, data_type)
    data.comment_by == current_user.id ||
      user_created_data?(data.commentable_id, data_type)
  end

  # rubocop:disable MethodLength
  def user_created_data?(id, data_type)
    case data_type
    when 'moment'
      Moment.where(id: id, user_id: current_user.id).exists?
    when 'strategy'
      Strategy.where(id: id, user_id: current_user.id).exists?
    when 'meeting'
      MeetingMember.where(meeting_id: id, leader: true,
                          user_id: current_user.id).exists?
    else
      false
    end
  end
  # rubocop:enable MethodLength

  def moment_or_strategy_data(comment)
    if comment.commentable_type == 'moment'
      Moment.find(comment.commentable_id)
    elsif comment.commentable_type == 'strategy'
      Strategy.find(comment.commentable_id)
    end
  end

  def get_visibility(comment, data)
    return unless data
    CommentVisibility.build(comment, data, current_user)
  end
end
