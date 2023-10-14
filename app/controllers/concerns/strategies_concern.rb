# frozen_string_literal: true
module StrategiesConcern
  extend ActiveSupport::Concern

  included do
    helper_method :publishing?, :saving_as_draft,
                  :render_errors, :empty_array_for,
                  :premade_strategy
  end

  def publishing?
    params[:publishing] == '1'
  end

  def saving_as_draft?
    params[:publishing] != '1'
  end

  def render_errors(strategy)
    render json: strategy.errors, status: :unprocessable_entity
  end

  def empty_array_for(*symbols)
    symbols.each do |symbol|
      @strategy[symbol] = [] if strategy_params[symbol].nil? && @strategy.has_attribute?(symbol)
    end
  end

  def premade_strategy
    category = Category.find_by(name: 'Meditation', user: current_user)
    Strategy.new(
      user: current_user,
      name: t('strategies.index.premade1_name'),
      description: t('strategies.index.premade1_description'),
      category: category ? [category.id] : nil,
      comment: false,
      visible: true,
      published_at: Time.zone.now
    )
  end

  def strategy_params
    params.require(:strategy).permit(
      :name, :description, :published_at, :draft, :comment,
      { category: [] }, { viewers: [] }, :visible, :bookmarked,
      perform_strategy_reminder_attributes: %i[active id]
    )
  end
end
