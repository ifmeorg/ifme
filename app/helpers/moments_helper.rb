# frozen_string_literal: true
module MomentsHelper
  include ViewersHelper
  include VisibleHelper

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
      copyOnClick: t('moments.secret_share.link_copied'),
      info: t('moments.secret_share.info')
    }], action:  moment_path(moment) }
  end

  def user_actions(element, present_object, signed_in)
    actions = {
      viewers: nil, edit: nil, delete: nil, share_link_info: nil
    }
    return actions unless signed_in

    model_name = element.class.name.downcase
    is_strategy = model_name == 'strategy'

    { viewers: get_viewer_list(element.viewers, nil),
      edit: get_user_action('edit', present_object),
      delete: get_user_action('delete', present_object),
      share_link_info: get_share_link_info(is_strategy, element),
      visible: is_strategy && get_visible(element.visible) }
  end

  def present_moment_or_strategy(element)
    present_object = get_present_object(element)
    { name: element.name,
      link: present_object[:url_helper],
      date: TimeAgo.created_or_edited(element),
      actions: element_actions(element, present_object),
      draft: !element.published? ? t('draft') : nil,
      categories: element.category_names_and_slugs,
      moods: present_object[:moods],
      storyBy: story_by(element),
      storyType: present_object[:story_type] }
  end

  def get_resources_data(moment, current_user)
    unless moment.shared?
      r = ResourceRecommendations.new(
        moment: moment, current_user: current_user
      )
      tags = r.matched_tags.uniq.map do |t|
        "filter[]=#{t}&"
      end
    end
    { tags: tags ? tags.join : '',
      show_crisis_prevention: r.nil? ? false : r.show_crisis_prevention }
  end

  private

  def element_actions(element, present_object)
    actions = user_actions(element,
                           present_object,
                           element.user_id == current_user&.id)
    {
      edit: actions[:edit],
      delete: actions[:delete],
      viewers: actions[:viewers],
      not_visible: (!element.is_a?(Moment) &&
      !element.visible) &&
        actions[:visible],
      visible: (element.is_a?(Moment) || element.visible) && actions[:visible],
      share_link_info: actions[:share_link_info]
    }.delete_if { |_, value| value == false }
  end

  def story_by(element)
    {
      author: link_to(
        element.user.name,
        profile_index_path(uid: element.user.uid)
      ),
      avatar: ProfilePicture.normalize_url(element.user.avatar.url)
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
      moods: element&.mood_names_and_slugs
    }
  end

  def get_share_link_info(is_strategy, element)
    return if is_strategy || element.secret_share_identifier.blank?

    t('moments.secret_share.link_info')
  end
end
