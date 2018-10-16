# frozen_string_literal: true

# rubocop:disable ClassLength
class MomentsController < ApplicationController
  include CollectionPageSetup
  include Shared

  before_action :set_moment, only: %i[show edit update destroy]

  # GET /moments
  # GET /moments.json
  # rubocop:disable MethodLength
  def index
    if current_user
      @user_logged_in = true
      period = 'day'
      # +1 day buffer to ensure we include today as well
      end_date = Date.current + 1.day
      start_date = get_start_by_period(period, end_date)
      @react_moments = Moment.where(user: current_user)
                             .group_by_period(period,
                                              :created_at,
                                              range: start_date..end_date).count
    else
      @user_logged_in = false
    end
    page_collection('@moments', 'moment')
  end
  # rubocop:enable MethodLength

  # GET /moments/1
  # GET /moments/1.json
  def show
    show_with_comments(@moment)
  end

  # GET /moments/new
  def new
    @moment = Moment.new
    set_association_variables!
  end

  # GET /moments/1/edit
  def edit
    unless @moment.user_id == current_user.id
      redirect_to_path(moment_path(@moment))
    end

    set_association_variables!
  end

  # POST /moments
  # POST /moments.json
  def create
    @moment = Moment.new(moment_params.merge(user_id: current_user.id))
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
    @moment.published_at = Time.zone.now if publishing?
    shared_create(@moment)
  end

  # PATCH/PUT /moments/1
  # PATCH/PUT /moments/1.json
  # rubocop:disable MethodLength
  def update
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
    if publishing? && !@moment.published?
      @moment.published_at = Time.zone.now
    elsif saving_as_draft?
      @moment.published_at = nil
    end
    empty_array_for :viewers, :mood, :strategy, :category
    shared_update(@moment, moment_params)
  end
  # rubocop:enable MethodLength

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment.destroy
    redirect_to_path(moments_path)
  end

  private

  def set_moment
    @moment = Moment.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(moments_path)
  end

  def moment_params
    params.require(:moment).permit(
      :name, :why, :fix, :comment, :published_at, :draft,
      category: [], mood: [], viewers: [], strategy: []
    )
  end

  def set_association_variables!
    @viewers = current_user.allies_by_status(:accepted)
    @categories = Category.where(user: current_user).order(created_at: :desc)
    @category = Category.new
    @moods = Mood.where(user: current_user).order(created_at: :desc)
    @mood = Mood.new
    @strategies = associated_strategies
    @strategy = Strategy.new
  end

  def associated_strategies
    # current_user's strategies and all viewable strategies from allies
    strategy_ids = current_user.strategies.pluck(:id)
    @viewers.each do |ally|
      ally.strategies.each do |strategy|
        strategy_ids << strategy.id if strategy.viewer?(current_user)
      end
    end

    Strategy.where(id: strategy_ids).order(created_at: :desc)
  end

  def get_start_by_period(period, end_date)
    case period
    when 'day'
      end_date - 1.week
    when 'week'
      end_date - 1.month
    when 'month'
      end_date - 1.year
    else
      end_date - 1.week
    end
  end

  def publishing?
    params[:publishing] == '1'
  end

  def saving_as_draft?
    params[:publishing] != '1'
  end

  def empty_array_for(*symbols)
    symbols.each do |symbol|
      @moment[symbol] = [] if moment_params[symbol].nil?
    end
  end
end
# rubocop:enable ClassLength
