# frozen_string_literal: true

module StrategiesHelper
  include CategoriesHelper
  include FormHelper

  def new_strategy_props
    new_form_props(strategy_form_inputs, strategies_path)
  end

  def quick_create_strategy_props
    quick_create_form_props(quick_create_strategy_form_inputs, quick_create_strategies_path)
  end

  def edit_strategy_props
    edit_form_props(strategy_form_inputs, strategy_path(@strategy))
  end

  private

  def strategy_form_inputs
    [
      {
        id: 'strategy_name',
        type: 'text',
        name: 'strategy[name]',
        label: t('common.name'),
        value: @strategy.name || nil,
        placeholder: t('strategies.form.name_hint'),
        required: true,
        dark: true,
      },
      {
        id: 'strategy_description',
        type: 'textarea',
        name: 'strategy[description]',
        label: t('strategies.form.describe'),
        value: @strategy.description || nil,
        required: true,
        dark: true
      },
      {
        id: 'strategy_category',
        type: 'quickCreate',
        name: 'strategy[category][]',
        label: t('categories.plural'),
        placeholder: t('common.form.press_enter'),
        checkboxes: category_checkboxes,
        formProps: quick_create_category_props,
      },
      strategy_viewers_input,
      {
        id: 'strategy_comment',
        type: 'checkbox',
        name: 'strategy[comment]',
        label: t('comment.allow_comments'),
        value: true,
        uncheckedValue: false,
        checked: @strategy.comment,
        info: t('comment.hint'),
        dark: true
      },
      {
        id: 'strategy_perform_strategy_reminder_attributes_active',
        type: 'checkbox',
        name: 'strategy[perform_strategy_reminder_attributes][active]',
        label: t('common.daily_reminder'),
        info: t('strategies.form.daily_reminder_hint'),
        value: true,
        uncheckedValue: false,
        checked: @strategy.try(:perform_strategy_reminder).try(:active),
        dark: true
      },
      {
        id: 'strategy_publishing',
        type: 'checkbox',
        label: t('strategies.form.draft_question'),
        dark: true,
        name: 'publishing',
        value: '0',
        uncheckedValue: '1',
        checked: !@strategy.published?
      },
      {
        id: 'strategy_perform_strategy_reminder_attributes_id',
        name: 'strategy[perform_strategy_reminder_attributes][id]',
        type: 'hidden',
        value: @strategy.try(:perform_strategy_reminder).try(:id)
      }
    ]
  end

  def quick_create_strategy_form_inputs
    [
      strategy_form_inputs[0],
      strategy_form_inputs[1],
    ]
  end

  def category_checkboxes
    checkboxes = []
    @categories.each do |item|
      checkboxes.push({
        id: item.slug,
        label: item.name,
        value: item.id,
        checked: @strategy.category.include?(item.id)
      })
    end
    checkboxes
  end

  def strategy_viewers_input
    input = {}
    if !@viewers.nil? && @viewers.length > 0
      checkboxes = []
      @viewers.each do |item|
        checkboxes.push({
          id: "strategy_viewers_#{item.id}",
          name: 'strategy[viewers][]',
          value: item.id,
          checked: @strategy.viewers.include?(item.id),
          label: User.find(item.id).name
        })
      end
      input = {
        id: 'strategy_viewers',
        name: 'strategy[viewers]',
        type: 'tag',
        checkboxes: checkboxes,
        label: t('shared.viewers.plural'),
        dark: true,
        accordion: true,
        placeholder: t('strategies.form.viewers_hint')
      }
    end
    input
  end
end