# frozen_string_literal: true

module CommentsHelper
  # rubocop:disable MethodLength
  def generate_comment(data, data_type)
    profile = User.find(data.comment_by)
    comment_info = link_to(profile.name, profile_index_path(uid: profile.uid))
    if current_user != profile && !current_user.mutual_allies?(profile)
      comment_info += " #{t('shared.comments.not_allies')}"
    end
    comment_info += " - #{TimeAgo.formatted_ago(data.created_at)}"
    comment_text = sanitize(data.comment)
    if data_type == 'moment'
      visibility = CommentVisibility.build(data,
                                           Moment.find(data.commentable_id),
                                           current_user)
    elsif data_type == 'strategy'
      visibility = CommentVisibility.build(data,
                                           Strategy.find(data.commentable_id),
                                           current_user)
    end
    if comment_deletable?(data, data_type)
      delete_comment = '<div class="delete_comment">'
      delete_comment += link_to sanitize('<i class="fa fa-times"></i>'),
                                '',
                                id: "delete_comment_#{data.id}",
                                class: 'delete_comment_button'
      delete_comment += '</div>'
    end
    {
      commentid: data.id,
      comment_info: comment_info,
      comment_text: comment_text,
      visibility: visibility,
      delete_comment: delete_comment,
      no_save: false
    }
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
      @comments = Comment.where(
        commentable_id: subject.id,
        commentable_type: model_name
      ).order(created_at: :desc)
    end
    # rubocop:enable GuardClause
  end
  # rubocop:enable MethodLength

  def comment_deletable?(data, data_type)
    data.comment_by == current_user.id ||
      user_created_data?(data.commentable_id, data_type)
  end

  def comment_for(model_name)
    @comment = Comment.create_from!(params)
    @comment.notify_of_creation!(current_user)

    respond_with_json(
      generate_comment(@comment, model_name)
    )
  rescue ActiveRecord::RecordInvalid
    respond_not_saved
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
end
