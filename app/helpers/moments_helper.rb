# frozen_string_literal: true
module MomentsHelper
  include ViewersHelper

  def moments_data_json
    {
      data: moments_or_strategy_props(@moments),
      lastPage: @moments.last_page?
    }
  end

  def moments_data_html
    return unless current_user

    # +1 day buffer to ensure we include today as well
    end_date = Date.current + 1.day
    start_date = end_date - 1.week
    range = start_date..end_date
    @react_moments = current_user.moments
                                 .group_by_period('day',
                                                  :created_at,
                                                  range: range)
                                 .count
  end

  def moments_or_strategy_props(elements)
    elements.map { |element| present_moment_or_strategy(element) }
  end

  def secret_share_props(moment)
    { inputs: [{
      id: 'secretShare',
      type: 'text',
      name: 'secretShare',
      label: t('moments.secret_share.singular'),
      readOnly: true,
      value: secret_share_url(moment.secret_share_identifier) || nil,
      dark: true,
      copyOnClick: t('moments.secret_share.link_copied')
    }], action:  moment_path(moment) }
  end

  def user_actions(element, present_object, signed_in)
    return { viewers: nil, edit: nil, delete: nil } unless signed_in

    { viewers: get_viewer_list(element.viewers, nil),
      edit: get_user_action('edit', present_object),
      delete: get_user_action('delete', present_object) }
  end

  def present_moment_or_strategy(element)
    present_object = get_present_object(element)
    { name: element.name,
      link: present_object[:url_helper],
      date: TimeAgo.created_or_edited(element),
      actions: moment_or_strategy_actions(element, present_object),
      draft: !element.published? ? t('draft') : nil,
      categories: element.category_names,
      moods: present_object[:moods],
      storyBy: story_by(element),
      storyType: present_object[:story_type] }
  end

  private

  def moment_or_strategy_actions(element, present_object)
    actions = user_actions(element,
                           present_object,
                           element.user_id == current_user&.id)
    {
      edit: actions[:edit],
      delete: actions[:delete],
      viewers: actions[:viewers]
    }
  end

  def story_by(element)
    {
      author: link_to(
        User.find(element.user_id).name,
        profile_index_path(uid: User.find_by(id: element.user_id).uid)
      ),
      avatar: ProfilePicture.normalize_url(
        User.find(element.user_id).avatar.url
      )
    }
  end

  def get_user_action(action, present_object)
    action_object = {
      link: present_object[action == 'edit' ? :link : :url_helper],
      name: t("common.actions.#{action}")
    }
    return action_object if action == 'edit'

    action_object.merge(dataMethod: 'delete',
                        dataConfirm: t('common.actions.confirm'))
  end

  def get_present_object(element)
    model_name = element.class.name.downcase
    is_moment = model_name == 'moment'
    {
      url_helper: is_moment ? moment_path(element) : strategy_path(element),
      link: is_moment ? edit_moment_path(element) : edit_strategy_path(element),
      story_type: t("#{model_name.pluralize}.singular"),
      moods: element&.mood_names
    }
  end
end
