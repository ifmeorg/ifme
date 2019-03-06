# frozen_string_literal: true

class StrategiesController < ApplicationController
  include CollectionPageSetupConcern
  include ReminderHelper
  include StrategiesConcern
  include Shared
  include MomentsHelper

  before_action :set_strategy, only: %i[show edit update destroy]

  # GET /strategies
  # GET /strategies.json
  # rubocop:disable MethodLength
  def index
    page_collection('@strategies', 'strategy')
    respond_to do |format|
      format.json do
        render json:
          {
            data: moments_or_strategy_props(@strategies),
            lastPage: @strategies.last_page?
          }
      end
      format.html
    end
  end
  # rubocop:enable MethodLength

  # GET /strategies/1
  # GET /strategies/1.json
  def show
    show_with_comments(@strategy)
  end

  #  POST /strategies/quick_create
  def quick_create
    # Assume all viewers and comments allowed
    viewers = current_user.allies_by_status(:accepted).pluck(:id)
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
    unless @strategy.user_id == current_user.id
      redirect_to_path(strategy_path(@strategy))
    end
    @viewers = current_user.allies_by_status(:accepted)
    @categories = current_user.categories.order('created_at DESC')
    @category = Category.new
    PerformStrategyReminder.find_or_initialize_by(strategy_id: @strategy.id)
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
  def premade
    strategy = premade_strategy
    respond_to do |format|
      if strategy.save
        PerformStrategyReminder.create!(strategy: strategy, active: false)
        format.json { head :no_content }
      else
        format.json { render_errors(strategy) }
      end
      format.html { redirect_to strategies_path }
    end
  end

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
