# frozen_string_literal: true

# rubocop:disable ClassLength
class StrategiesController < ApplicationController
  include CollectionPageSetup
  include ReminderHelper
  include Shared

  before_action :set_strategy, only: %i[show edit update destroy]

  # GET /strategies
  # GET /strategies.json
  def index
    page_collection('@strategies', 'strategy')
  end

  # GET /strategies/1
  # GET /strategies/1.json
  def show
    show_with_comments(@strategy)
  end

  def quick_create
    # Assume all viewers and comments allowed
    viewers = []
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end
    strategy = Strategy.new(quick_create_params(viewers))
    shared_quick_create(strategy)
  end

  # GET /strategies/new
  def new
    @viewers = current_user.allies_by_status(:accepted)
    @strategy = Strategy.new
    @categories = current_user.categories.order('created_at DESC')
    @category = Category.new
    @strategy.build_perform_strategy_reminder
  end

  # GET /strategies/1/edit
  def edit
    if @strategy.user_id == current_user.id
      @viewers = current_user.allies_by_status(:accepted)
      @categories = current_user.categories.order('created_at DESC')
      @category = Category.new
      PerformStrategyReminder.find_or_initialize_by(strategy_id: @strategy.id)
    else
      redirect_to_path(strategy_path(@strategy))
    end
  end

  # POST /strategies
  # POST /strategies.json
  def create
    @strategy = Strategy.new(strategy_params.merge(user_id: current_user.id))
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @strategy.published_at = Time.zone.now if publishing?
    shared_create(@strategy)
  end

  # POST /strategies
  # POST /strategies.json
  # rubocop:disable MethodLength
  def premade
    category = Category.find_by(name: 'Meditation', user: current_user)
    strategy = Strategy.new(
      user: current_user,
      name: t('strategies.index.premade1_name'),
      description: t('strategies.index.premade1_description'),
      category: category ? [category.id] : nil,
      comment: false
    )
    respond_to do |format|
      if strategy.save
        PerformStrategyReminder.create!(strategy: strategy, active: false)
        format.html { redirect_to strategies_path }
        format.json { render :no_content }
      else
        format.html { redirect_to strategies_path }
        format.json { render_errors(strategy) }
      end
    end
  end
  # rubocop:enable MethodLength

  # PATCH/PUT /strategies/1
  # PATCH/PUT /strategies/1.json
  def update
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    if publishing? && !@strategy.published?
      @strategy.published_at = Time.zone.now
    elsif saving_as_draft?
      @strategy.published_at = nil
    end
    empty_array_for :viewers, :category
    shared_update(@strategy, strategy_params)
  end

  # DELETE /strategies/1
  # DELETE /strategies/1.json
  def destroy
    shared_destroy(@strategy)
  end

  private

  def render_errors(strategy)
    render json: strategy.errors, status: :unprocessable_entity
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_strategy
    @strategy = Strategy.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(strategies_path)
  end

  def strategy_params
    params.require(:strategy).permit(
      :name, :description, :published_at, :draft,
      :comment, { category: [] }, { viewers: [] },
      perform_strategy_reminder_attributes: %i[active id]
    )
  end

  def publishing?
    params[:publishing] == '1'
  end

  def saving_as_draft?
    params[:publishing] != '1'
  end

  def empty_array_for(*symbols)
    symbols.each do |symbol|
      @strategy[symbol] = [] if strategy_params[symbol].nil?
    end
  end

  def quick_create_params(viewers)
    {
      user_id: current_user.id,
      name: params[:strategy][:name],
      description: params[:strategy][:description],
      category: params[:strategy][:category],
      published_at: Time.zone.now,
      comment: true,
      viewers: viewers
    }
  end
end
# rubocop:enable ClassLength
