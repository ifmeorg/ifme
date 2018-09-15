# frozen_string_literal: true

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

  def moments_viewers_input
    input = {}
    if !@viewers.nil? && @viewers.length > 0
      checkboxes = []
      @viewers.each do |item|
        checkboxes.push({
          id: "moment_viewers_#{item.id}",
          name: 'moment[viewers][]',
          value: item.id,
          checked: @moment.viewers.include?(item.id),
          label: User.find(item.id).name
        })
      end
      input = {
        id: 'moment_viewers',
        name: 'moment[viewers]',
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

  def checkboxes_for(data)
    checkboxes = []
    data.each do |item|
      checkboxes.push({
        id: item.slug,
        label: item.name,
        value: item.id,
        checked: data_for_moment(data).include?(item.id)
      })
    end
    checkboxes
  end

  def data_for_moment(data)
    if data == @categories
      @moment.category
    elsif data == @moods
      @moment.mood
    end
    @moment.strategy
  end
end
