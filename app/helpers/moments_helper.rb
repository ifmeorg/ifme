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

  # rubocop:disable MethodLength
  def moments_stats
    total_count = current_user.moments.all.count
    monthly_count = current_user.moments.where(
      created_at: Time.current.beginning_of_month..Time.current
    ).count
    return '' if total_count <= 1

    result = '<div class="center stats">'
    result += total_moment(total_count)
    if total_count != monthly_count
      result += " #{monthly_moment(monthly_count)}"
    end
    result + '</div>'
  end
  # rubocop:enable MethodLength

  private

  # rubocop:disable MethodLength
  def moment_form_inputs(moment, viewers)
    [
      {
        id: 'moment_name',
        type: 'text',
        name: 'moment[name]',
        label: t('common.name'),
        value: moment.name || nil,
        required: true,
        dark: true
      },
      {
        id: 'moment_why',
        type: 'textarea',
        name: 'moment[why]',
        label: t('moments.form.why'),
        value: moment.why || nil,
        required: true,
        dark: true
      },
      {
        id: 'moment_fix',
        type: 'textarea',
        name: 'moment[fix]',
        label: t('moments.form.fix'),
        value: moment.fix || nil,
        dark: true
      },
      {
        id: 'moment_category',
        type: 'quickCreate',
        name: 'moment[category][]',
        label: t('categories.plural'),
        placeholder: t('common.form.search_by_keywords'),
        checkboxes: checkboxes_for(@categories),
        formProps: quick_create_category_props(@category)
      },
      {
        id: 'moment_mood',
        type: 'quickCreate',
        name: 'moment[mood][]',
        label: t('moods.plural'),
        placeholder: t('common.form.search_by_keywords'),
        checkboxes: checkboxes_for(@moods),
        formProps: quick_create_mood_props
      },
      {
        id: 'moment_strategy',
        type: 'quickCreate',
        name: 'moment[strategy][]',
        label: t('strategies.plural'),
        placeholder: t('common.form.search_by_keywords'),
        checkboxes: checkboxes_for(@strategies),
        formProps: quick_create_strategy_props
      },
      get_viewers_input(viewers, 'moment', 'moments', moment),
      {
        id: 'moment_comment',
        type: 'switch',
        name: 'moment[comment]',
        label: t('comment.allow_comments'),
        value: true,
        uncheckedValue: false,
        checked: moment.comment,
        info: t('comment.hint'),
        dark: true
      },
      {
        id: 'moment_publishing',
        type: 'switch',
        label: t('moments.form.draft_question'),
        dark: true,
        name: 'publishing',
        value: '0',
        uncheckedValue: '1',
        checked: !moment.published?
      }
    ]
  end
  # rubocop:enable MethodLength

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

  def total_moment(total_count)
    unless total_count == 1
      return t(
        'stats.total_moments', count: total_count
      )
    end

    t('stats.total_moment', count: total_count)
  end

  def monthly_moment(monthly_count)
    unless monthly_count == 1
      return t(
        'stats.monthly_moments', count: monthly_count
      )
    end

    t('stats.monthly_moment', count: monthly_count)
  end
end
# rubocop:enable ModuleLength
