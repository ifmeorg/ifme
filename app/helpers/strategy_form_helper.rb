# frozen_string_literal: true

module StrategyFormHelper
  include CategoriesHelper

  def build_strategy_name(strategy)
    {
      id: 'strategy_name',
      type: 'text',
      name: 'strategy[name]',
      label: t('common.name'),
      value: strategy.name || nil,
      placeholder: t('strategies.form.name_hint'),
      required: true,
      dark: true
    }
  end

  def build_strategy_description(strategy)
    {
      id: 'strategy_description',
      type: 'textarea',
      name: 'strategy[description]',
      label: t('strategies.form.describe'),
      value: strategy.description || nil,
      required: true,
      dark: true
    }
  end

  def build_strategy_category
    {
      id: 'strategy_category',
      type: 'quickCreate',
      name: 'strategy[category][]',
      label: t('categories.plural'),
      placeholder: t('common.form.press_enter'),
      checkboxes: category_checkboxes,
      formProps: quick_create_category_props(@category)
    }
  end

  def build_strategy_reminder(strategy)
    {
      id: 'strategy_perform_strategy_reminder',
      name: 'strategy[perform_strategy_reminder_attributes][active]',
      label: t('common.daily_reminder'),
      info: t('strategies.form.daily_reminder_hint'),
      value: true,
      uncheckedValue: false,
      checked: strategy&.perform_strategy_reminder&.active,
      dark: true
    }
  end

  def build_strategy_reminder_attributes(strategy)
    {
      id: 'strategy_perform_strategy_reminder_attributes_id',
      name: 'strategy[perform_strategy_reminder_attributes][id]',
      type: 'hidden',
      value: strategy&.perform_strategy_reminder&.id
    }
  end

  def build_strategy_comment(strategy)
    build_switch_input(true, strategy.comment, false)
      .merge(
        id: 'strategy_comment',
        name: 'strategy[comment]',
        label: t('comment.allow_comments'),
        info: t('comment.hint')
      )
  end

  def build_strategy_publishing(strategy)
    build_switch_input('0', !strategy.published?, '1')
      .merge(
        id: 'strategy_publishing',
        name: 'publishing',
        label: t('strategies.form.draft_question')
      )
  end

  private

  def build_switch_input(value, checked, unchecked_value)
    {
      type: 'switch',
      value: value,
      uncheckedValue: unchecked_value,
      checked: checked,
      dark: true
    }
  end

  def category_checkboxes
    checkboxes = []
    @categories.each do |item|
      checkboxes.push(
        id: item.slug,
        label: item.name,
        value: item.id,
        checked: @strategy.category.include?(item.id)
      )
    end
    checkboxes
  end
end
