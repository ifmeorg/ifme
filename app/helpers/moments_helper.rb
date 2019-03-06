# frozen_string_literal: true

# rubocop:disable ModuleLength
module MomentsHelper
  include MoodsHelper
  include CategoriesHelper
  include StrategiesHelper
  include FormHelper

  def new_moment_props(moment, viewers)
    new_form_props(
      moment_form_inputs(moment, viewers),
      moments_path
    )
  end

  def edit_moment_props(moment, viewers)
    edit_form_props(
      moment_form_inputs(moment, viewers),
      moment_path(moment)
    )
  end

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

  def moments_stats
    return '' if moment_count[:total] < 1

    result = '<div class="center stats">'
    result += total_moment
    if moment_count[:total] != moment_count[:monthly]
      result += " #{monthly_moment}"
    end
    result + '</div>'
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

  # rubocop:disable MethodLength

  def setup_moment_or_strategy(element)
    if element.class.name == 'Moment'
      return {
        url_helper: moment_path(element),
        link: edit_moment_path(element),
        moods: element.mood_names,
        story_type: t('moments.singular')
      }
    end
    {
      url_helper: strategy_path(element),
      link: edit_strategy_path(element),
      moods: nil,
      story_type: t('strategies.singular')
    }
  end

  def user_actions(element, variables_to_present_type)
    if element.user_id == current_user&.id
      return {
        viewers: get_viewer_list(element.viewers, nil),
        edit:
          {
            link: variables_to_present_type[:link],
            name: t('common.actions.edit')
          },
        delete:
          {
            name: t('common.actions.delete'),
            link: variables_to_present_type[:url_helper],
            dataMethod: 'delete',
            dataConfirm: t('common.actions.confirm')
          }
      }
    end
    {
      viewers: nil,
      edit: nil,
      delete: nil
    }
  end

  def present_moment_or_strategy(element)
    avatar = ProfilePicture.normalize_url(User.find(element.user_id).avatar.url)
    variables_to_present_type = setup_moment_or_strategy(element)
    user_actions = user_actions(element, variables_to_present_type)
    {
      name: element.name,
      link: variables_to_present_type[:url_helper],
      date: TimeAgo.created_or_edited(element),
      actions: {
        edit: user_actions[:edit],
        delete: user_actions[:delete],
        viewers: user_actions[:viewers]
      },
      draft: !element.published? ? t('draft') : nil,
      categories: element.category_names,
      moods: variables_to_present_type[:moods],
      storyBy: {
        author: link_to(
          User.find(element.user_id).name,
          profile_index_path(uid: User.find_by(id: element.user_id).uid)
        ),
        avatar: avatar
      },
      storyType: variables_to_present_type[:story_type]
    }
  end

  # rubocop:enable MethodLength

  private

  def moment_name
    {
      id: 'moment_name',
      type: 'text',
      name: 'moment[name]',
      label: t('common.name'),
      value: @moment.name || nil,
      required: true,
      dark: true
    }
  end

  def moment_why
    {
      id: 'moment_why',
      type: 'textarea',
      name: 'moment[why]',
      label: t('moments.form.why'),
      value: @moment.why || nil,
      required: true,
      dark: true
    }
  end

  def moment_fix
    {
      id: 'moment_fix',
      type: 'textarea',
      name: 'moment[fix]',
      label: t('moments.form.fix'),
      value: @moment.fix || nil,
      dark: true
    }
  end

  def moment_category
    {
      id: 'moment_category',
      type: 'quickCreate',
      name: 'moment[category][]',
      label: t('categories.plural'),
      placeholder: t('common.form.search_by_keywords'),
      checkboxes: checkboxes_for(@categories),
      formProps: quick_create_category_props(@category)
    }
  end

  def moment_mood
    {
      id: 'moment_mood',
      type: 'quickCreate',
      name: 'moment[mood][]',
      label: t('moods.plural'),
      placeholder: t('common.form.search_by_keywords'),
      checkboxes: checkboxes_for(@moods),
      formProps: quick_create_mood_props
    }
  end

  def moment_strategy
    {
      id: 'moment_strategy',
      type: 'quickCreate',
      name: 'moment[strategy][]',
      label: t('strategies.plural'),
      placeholder: t('common.form.search_by_keywords'),
      checkboxes: checkboxes_for(@strategies),
      formProps: quick_create_strategy_props
    }
  end

  # rubocop:disable MethodLength
  def moment_comment
    {
      id: 'moment_comment',
      type: 'switch',
      name: 'moment[comment]',
      label: t('comment.allow_comments'),
      value: true,
      uncheckedValue: false,
      checked: @moment.comment,
      info: t('comment.hint'),
      dark: true
    }
  end
  # rubocop:enable MethodLength

  def moment_publishing
    {
      id: 'moment_publishing',
      type: 'switch',
      label: t('moments.form.draft_question'),
      dark: true,
      name: 'publishing',
      value: '0',
      uncheckedValue: '1',
      checked: !@moment.published?
    }
  end

  def moment_form_inputs(moment, viewers)
    [
      moment_name, moment_why, moment_fix, moment_category, moment_mood,
      moment_strategy, get_viewers_input(viewers, 'moment', 'moments', moment),
      moment_comment, moment_publishing
    ]
  end

  def checkboxes_for(data)
    checkboxes = []
    data.each do |item|
      checkboxes.push(
        id: item.slug,
        label: item.name,
        value: item.id,
        checked: data_for(item)&.include?(item.id)
      )
    end
    checkboxes
  end

  def data_for(item)
    case item.class.name
    when 'Category'
      @moment.category
    when 'Mood'
      @moment.mood
    when 'Strategy'
      @moment.strategy
    end
  end

  def moment_count
    {
      total: current_user.moments.all.count,
      monthly: current_user.moments.where(
        created_at: Time.current.beginning_of_month..Time.current
      ).count
    }
  end

  def total_moment
    moment_key = moment_count[:total] == 1 ? 'moment' : 'moments'
    t("stats.total_#{moment_key}", count: moment_count[:total])
  end

  def monthly_moment
    moment_key = moment_count[:monthly] == 1 ? 'moment' : 'moments'
    t("stats.monthly_#{moment_key}", count: moment_count[:monthly])
  end
end
# rubocop:enable ModuleLength
