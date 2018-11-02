# frozen_string_literal: true

module StrategiesHelper
  include FormHelper
  include StrategyFormHelper
  include ViewersHelper

  def new_strategy_props(strategy, viewers)
    new_form_props(
      strategy_form_inputs(strategy, viewers),
      strategies_path
    )
  end

  def quick_create_strategy_props
    quick_create_form_props(
      quick_create_strategy_form_inputs,
      quick_create_strategies_path
    )
  end

  def edit_strategy_props(strategy, viewers)
    edit_form_props(
      strategy_form_inputs(strategy, viewers),
      strategy_path(strategy)
    )
  end

  private

  def strategy_form_inputs(strategy, viewers)
    [
      build_strategy_name(strategy),
      build_strategy_description(strategy),
      build_strategy_category,
      get_viewers_input(viewers, 'strategy', 'strategies', strategy),
      build_strategy_comment(strategy),
      build_strategy_publishing(strategy),
      build_strategy_reminder(strategy).merge(type: 'checkbox'),
      build_strategy_reminder_attributes(strategy)
    ]
  end

  def quick_create_strategy_form_inputs
    [
      build_strategy_name(@strategy),
      build_strategy_description(@strategy)
    ]
  end
end
