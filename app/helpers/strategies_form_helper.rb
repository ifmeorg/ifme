# frozen_string_literal: true

module StrategiesFormHelper
  include CategoriesHelper

  def build_strategy_name(strategy)
    {
      id: 'strategy_name', type: 'text',
      name: 'strategy[name]', label: t('common.name'),
      value: strategy.name || nil,
      placeholder: t('strategies.form.name_hint'),
      required: true, dark: true
    }
  end

  def build_strategy_description(strategy)
    {
      id: 'strategy_description', type: 'textarea',
      name: 'strategy[description]',
      label: t('strategies.form.describe'),
      value: strategy.description || nil,
      required: true, dark: true
    }
  end

  def build_strategy_category
    {
      id: 'strategy_category', type: 'quickCreate',
      name: 'strategy[category][]',
      label: t('categories.plural'),
      placeholder: t('common.form.search_by_keywords'),
      checkboxes: category_checkboxes,
      formProps: quick_create_category_props
    }
  end

  def build_strategy_reminder(strategy)
    {
      id: 'strategy_perform_strategy_reminder',
      name: 'strategy[perform_strategy_reminder_attributes][active]',
      label: t('common.daily_reminder'),
      info: t('strategies.form.daily_reminder_hint'),
      value: true, uncheckedValue: false,
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
    build_switch_input(true, strategy.comment, false).merge(
      id: 'strategy_comment', name: 'strategy[comment]',
      label: t('comment.allow_comments'), info: t('comment.hint')
    )
  end

  def build_strategy_publishing(strategy, edit)
    checked = strategy.published?
    checked = !strategy.published? if edit
    checked = false if params[:bookmarked]

    build_switch_input('0', checked, '1')
      .merge(
        id: 'strategy_publishing', name: 'publishing',
        label: t('strategies.form.draft_question')
      )
  end

  def build_strategy_bookmarked(strategy)
    build_switch_input(
      true, params[:bookmarked] ? true : strategy.bookmarked, false
    )
      .merge(
        id: 'strategy_bookmarked', name: 'strategy[bookmarked]',
        label: t('strategies.form.bookmarked_question'),
        info: t('strategies.form.bookmarked_info')
      )
  end

  def build_strategy_visible(strategy)
    build_switch_input(true, strategy.visible, false).merge(
      id: 'strategy_visible', name: 'strategy[visible]',
      label: t('shared.stats.make_visible_in_stats')
    )
  end

  private

  def build_switch_input(value, checked, unchecked_value)
    {
      type: 'switch', value: value,
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
        checked: @strategy.categories.include?(item)
      )
    end
    checkboxes
  end
end
