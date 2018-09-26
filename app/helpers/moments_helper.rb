# frozen_string_literal: true

# rubocop:disable ModuleLength
module MomentsHelper
  include MoodsHelper
  include CategoriesHelper
  include StrategiesHelper
  include FormHelper

  def new_moment_props
    new_form_props(moment_form_inputs, moments_path)
  end

  def edit_moment_props
    edit_form_props(moment_form_inputs, moment_path(@moment))
  end

  private

  # rubocop:disable MethodLength
  def moment_form_inputs
    [
      {
        id: 'moment_name',
        type: 'text',
        name: 'moment[name]',
        label: t('common.name'),
        value: @moment.name || nil,
        required: true,
        dark: true
      },
      {
        id: 'moment_why',
        type: 'textarea',
        name: 'moment[why]',
        label: t('moments.form.why'),
        value: @moment.why || nil,
        required: true,
        dark: true
      },
      {
        id: 'moment_fix',
        type: 'textarea',
        name: 'moment[fix]',
        label: t('moments.form.fix'),
        value: @moment.fix || nil,
        dark: true
      },
      {
        id: 'moment_category',
        type: 'quickCreate',
        name: 'moment[category][]',
        label: t('categories.plural'),
        placeholder: t('common.form.press_enter'),
        checkboxes: checkboxes_for(@categories),
        formProps: quick_create_category_props
      },
      {
        id: 'moment_mood',
        type: 'quickCreate',
        name: 'moment[mood][]',
        label: t('moods.plural'),
        placeholder: t('common.form.press_enter'),
        checkboxes: checkboxes_for(@moods),
        formProps: quick_create_mood_props
      },
      {
        id: 'moment_strategy',
        type: 'quickCreate',
        name: 'moment[strategy][]',
        label: t('strategies.plural'),
        placeholder: t('common.form.press_enter'),
        checkboxes: checkboxes_for(@strategies),
        formProps: quick_create_strategy_props
      },
      moments_viewers_input,
      {
        id: 'moment_comment',
        type: 'checkbox',
        name: 'moment[comment]',
        label: t('comment.allow_comments'),
        value: true,
        uncheckedValue: false,
        checked: @moment.comment,
        info: t('comment.hint'),
        dark: true
      },
      {
        id: 'moment_publishing',
        type: 'checkbox',
        label: t('moments.form.draft_question'),
        dark: true,
        name: 'publishing',
        value: '0',
        uncheckedValue: '1',
        checked: !@moment.published?
      }
    ]
  end
  # rubocop:enable MethodLength

  # rubocop:disable MethodLength
  def moments_stats
    total_count = current_user.moments.all.count
    monthly_count = current_user.moments.where(
      created_at: Time.current.beginning_of_month..Time.current
    ).count

    return '' if total_count <= 1

    result = '<div class="center" id="stats">'
    result += if total_count == 1
                t('stats.total_moment', count: total_count.to_s)
              else
                t('stats.total_moments', count: total_count.to_s)
              end

    if total_count != monthly_count
      result += ' '
      result += if monthly_count == 1
                  t('stats.monthly_moment', count: monthly_count.to_s)
                else
                  t('stats.monthly_moments', count: monthly_count.to_s)
                end
    end

    result + '</div>'
  end
  # rubocop:enable MethodLength

  # rubocop:disable MethodLength
  def moments_viewers_input
    input = {}
    if @viewers.present?
      checkboxes = []
      @viewers.each do |item|
        checkboxes.push(
          id: "moment_viewers_#{item.id}",
          value: item.id,
          checked: @moment.viewers.include?(item.id),
          label: User.find(item.id).name
        )
      end
      input = {
        id: 'moment_viewers',
        name: 'moment[viewers][]',
        type: 'tag',
        checkboxes: checkboxes,
        label: t('shared.viewers.plural'),
        dark: true,
        accordion: true,
        placeholder: t('moments.form.viewers_hint')
      }
    end
    input
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
end
# rubocop:enable ModuleLength
