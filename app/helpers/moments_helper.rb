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
