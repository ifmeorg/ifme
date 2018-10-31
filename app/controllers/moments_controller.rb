# frozen_string_literal: true
class MomentsController < ApplicationController
  include CollectionPageSetupConcern
  include MomentsHelper
  include Shared

  before_action :set_moment, only: %i[show edit update destroy]
  before_action :load_viewers, only: %i[new edit create update]

  # GET /moments
  # GET /moments.json
  def index
    if current_user
      # +1 day buffer to ensure we include today as well
      end_date = Date.current + 1.day
      start_date = end_date - 1.week
      @react_moments = current_user.moments
                                   .group_by_period('day',
                                                    :created_at,
                                                    range: start_date..end_date)
                                   .count
    end
    page_collection('@moments', 'moment')
  end

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
    @moment = current_user.moments.build(moment_params)
    @moment.published_at = Time.zone.now if publishing?
    shared_create(@moment)
  end

  # PATCH/PUT /moments/1
  # PATCH/PUT /moments/1.json
  def update
    if publishing? && !@moment.published?
      @moment.published_at = Time.zone.now
    elsif saving_as_draft?
      @moment.published_at = nil
    end
    empty_array_for :viewers, :mood, :strategy, :category
    shared_update(@moment, moment_params)
  end

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
    @categories = current_user.categories.order(created_at: :desc)
    @category = Category.new
    @moods = current_user.moods.order(created_at: :desc)
    @mood = Mood.new
    @strategies = associated_strategies
    @strategy = Strategy.new
  end

  def load_viewers
    @viewers = current_user.allies_by_status(:accepted)
  end

  def associated_strategies
    # current_user's strategies and all viewable strategies from allies
    strategy_ids = current_user.strategy_ids
    Strategy.where(user: @viewers).each do |strategy|
      strategy_ids << strategy.id if strategy.viewer?(current_user)
    end
    Strategy.where(id: strategy_ids).order(created_at: :desc)
  end

  def publishing?
    params[:publishing] == '1'
  end

  def saving_as_draft?
    !publishing?
  end

  def empty_array_for(*symbols)
    symbols.each do |symbol|
      @moment[symbol] = [] if moment_params[symbol].nil?
    end
  end
end
