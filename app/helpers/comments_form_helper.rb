# frozen_string_literal: true

module CommentsFormHelper
  include FormHelper

  def comments_form_props(commentable_data, commentable_type)
    inputs = [
      basic_props('commentable_type', 'hidden', commentable_type),
      basic_props('comment_by', 'hidden', current_user.id),
      basic_props('commentable_id', 'hidden', commentable_data.id),
      basic_props('comment', 'textarea')
    ].concat(visibility_or_viewers_input(commentable_data, commentable_type))
    quick_create_form_props(inputs, get_action(commentable_type))
  end

  private

  def get_action(commentable_type)
    case commentable_type
    when 'moment'
      comment_moments_path
    when 'strategy'
      comment_strategies_path
    else
      comment_meetings_path
    end
  end

  def user_created_data?(id, data_type)
    if data_type == 'meeting'
      MeetingMember.where(meeting_id: id, leader: true,
                          user_id: current_user.id).exists?
    end
    model = data_type.classify.constantize
    model.where(id: id, user_id: current_user.id).exists?
  end

  def basic_props(field, input_type, value = nil)
    {
      id: "comment_#{field}",
      name: "comment[#{field}]",
      type: input_type,
      dark: true,
      value: value
    }
  end

  def comment_visibility_option(value, label)
    {
      id: "comment_visibility_#{value}",
      label: label,
      value: value
    }
  end

  def comment_visibility_options(owner)
    [
      comment_visibility_option(
        'all',
        t('shared.comments.share_everyone')
      ),
      comment_visibility_option(
        'private',
        t('shared.comments.share_with', name: owner.name)
      )
    ]
  end

  def visibility_input_not_owner(owner)
    {
      options: comment_visibility_options(owner)
    }.merge(basic_props('visibility', 'select', 'all'))
  end

  def comment_viewers_option(field, label, value = nil)
    {
      id: "comment_viewers_#{field}",
      label: label,
      value: value
    }
  end

  def viewers_options(viewers)
    options = []
    viewers.each do |viewer_id|
      label = t('shared.comments.share_with', name: User.find(viewer_id).name)
      options.push(comment_viewers_option(viewer_id, label, viewer_id))
    end
    options
  end

  def viewers_input_data_viewers(viewers)
    {
      options: [
        comment_viewers_option('everyone', t('shared.comments.share_everyone'))
      ].concat(viewers_options(viewers))
    }.merge(basic_props('viewers', 'select', 'all'))
  end

  def input_for_moment_or_strategy(commentable_data)
    owner = User.find(commentable_data.user_id)
    return [visibility_input_not_owner(owner)] if owner.id != current_user.id

    return unless commentable_data.viewers.present? &&
                  commentable_data.viewers.any?

    [
      basic_props('visibility', 'hidden', 'all'),
      viewers_input_data_viewers(commentable_data.viewers)
    ]
  end

  def visibility_or_viewers_input(commentable_data, commentable_type)
    if %w[moment strategy].include?(commentable_type)
      return input_for_moment_or_strategy(commentable_data)
    end

    [basic_props('visibility', 'hidden', 'all')]
  end
end
