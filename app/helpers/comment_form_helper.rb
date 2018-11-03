# frozen_string_literal: true

module CommentFormHelper
  include FormHelper

  def comment_form_props(commentable, commentable_type)
    inputs = [
      basic_props('commentable_type', 'hidden', commentable_type),
      basic_props('comment_by', 'hidden', current_user.id),
      basic_props('commentable_id', 'hidden', commentable.id),
      basic_props('comment', 'textarea')
    ].concat(visibility_or_viewers_input(commentable, commentable_type))
    quick_create_form_props(inputs, comment_index_path)
  end

  private

  def basic_props_overrides(props, input_type)
    props = props.merge(dark: true) if input_type != 'hidden'
    if input_type == 'textarea'
      props = props.merge(required: true, label: t('comment.singular'))
    end
    props
  end

  def basic_props(field, input_type, value = nil)
    props = {
      id: "comment_#{field}",
      name: "comment[#{field}]",
      type: input_type,
      value: value
    }
    basic_props_overrides(props, input_type)
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
      user = User.find_by(id: viewer_id)
      next if user.banned

      label = t('shared.comments.share_with', name: user.name)
      options.push(comment_viewers_option(viewer_id, label, viewer_id))
    end
    options
  end

  def viewers_input_data_viewers(viewers)
    {
      options: [
        comment_viewers_option(
          'everyone', t('shared.comments.share_everyone'), ''
        )
      ].concat(viewers_options(viewers))
    }.merge(basic_props('viewers', 'select', ''))
  end

  def input_for_moment_or_strategy(commentable)
    owner = User.find(commentable.user_id)
    return [visibility_input_not_owner(owner)] if owner.id != current_user.id
    return [] unless commentable.viewers.present? &&
                     commentable.viewers.any?

    [viewers_input_data_viewers(commentable.viewers)]
  end

  def visibility_or_viewers_input(commentable, commentable_type)
    return [] unless %w[moment strategy].include?(commentable_type)

    input_for_moment_or_strategy(commentable)
  end
end
