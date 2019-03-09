# frozen_string_literal: true
module MomentsHelper
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

  def user_actions(element, vars_to_present_type)
    signed_in = element.user_id == current_user&.id
    {
      viewers: signed_in ? get_viewer_list(element.viewers, nil) : nil,
      edit: signed_in ? get_user_action('edit', vars_to_present_type) : nil,
      delete: signed_in ? get_user_action('delete', vars_to_present_type) : nil
    }
  end

  def present_moment_or_strategy(element)
    vars_to_present_type = setup_moment_or_strategy(element)
    { name: element.name,
      link: vars_to_present_type[:url_helper],
      date: TimeAgo.created_or_edited(element),
      actions: moment_or_strategy_actions(element, vars_to_present_type),
      draft: !element.published? ? t('draft') : nil,
      categories: element.category_names,
      moods: vars_to_present_type[:moods],
      storyBy: story_by(element),
      storyType: vars_to_present_type[:story_type] }
  end

  private

  def moment_or_strategy_actions(element, vars_to_present_type)
    actions = user_actions(element, vars_to_present_type)
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

  def get_user_action(action, vars_to_present_type)
    {
      link: vars_to_present_type[action == 'edit' ? :link : :url_helper],
      name: t("common.actions.#{action}"),
      dataMethod: action == 'edit' ? nil : 'delete',
      dataConfirm: action == 'edit' ? nil : t('common.actions.confirm')
    }
  end

  def setup_moment_or_strategy(element)
    is_moment = element.class.name == 'Moment'
    {
      url_helper: is_moment ? moment_path(element) : strategy_path(element),
      link: is_moment ? edit_moment_path(element) : edit_strategy_path(element),
      moods: is_moment ? element.mood_names : nil,
      story_type: t("#{is_moment ? 'moments' : 'strategies'}.singular")
    }
  end
end
