# frozen_string_literal: true

class StrategiesController < ApplicationController
  include CollectionPageSetup
  include ReminderHelper
  include QuickCreate

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

  def comment
    comment_for('strategy')
  end

  def delete_comment
    comment_exists = Comment.where(id: params[:commentid]).exists?
    is_my_comment = Comment.where(id: params[:commentid], comment_by: current_user.id).exists?

    if comment_exists
      strategyid = Comment.where(id: params[:commentid]).first.commentable_id
      is_my_strategy = Strategy.where(id: strategyid, userid: current_user.id).exists?
    else
      is_my_strategy = false
    end

    if comment_exists && (is_my_comment || is_my_strategy)
      Comment.find(params[:commentid]).destroy

      # Delete corresponding notifications
      public_uniqueid = 'comment_on_strategy_' + params[:commentid].to_s
      Notification.where(uniqueid: public_uniqueid).destroy_all

      private_uniqueid = 'comment_on_strategy_private_' + params[:commentid].to_s
      Notification.where(uniqueid: private_uniqueid).destroy_all
    end

    head :ok
  end

  def quick_create
    # Assumme all viewers and comments allowed
    viewers = []
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end

    strategy = Strategy.new(userid: current_user.id,
                            name: params[:strategy][:name],
                            description: params[:strategy][:description],
                            category: params[:strategy][:category],
                            published_at: Time.zone.now,
                            comment: true, viewers: viewers)

    result = if strategy.save
               render_checkbox(strategy, 'strategy', 'moment')
             else
               { error: 'error' }
             end

    respond_with_json(result)
  end

  # GET /strategies/new
  def new
    @viewers = current_user.allies_by_status(:accepted)
    @strategy = Strategy.new
    @categories = Category.where(userid: current_user.id).all.order('created_at DESC')
    @category = Category.new
    @strategy.build_perform_strategy_reminder
  end

  # GET /strategies/1/edit
  def edit
    if @strategy.userid == current_user.id
      @viewers = current_user.allies_by_status(:accepted)
      @categories = Category.where(userid: current_user.id).all.order('created_at DESC')
      @category = Category.new
      PerformStrategyReminder.find_or_initialize_by(strategy_id: @strategy.id)
    else
      redirect_to_path(strategy_path(@strategy))
    end
  end

  # POST /strategies
  # POST /strategies.json
  def create
    @strategy = Strategy.new(strategy_params)
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    respond_to do |format|
      if @strategy.save
        publish
        format.html { redirect_to strategy_path(@strategy) }
        format.json { render :show, status: :created, location: @strategy }
      else
        format.html { render :new }
        format.json { render_errors(@strategy) }
      end
    end
  end

  # POST /strategies
  # POST /strategies.json
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

  # PATCH/PUT /strategies/1
  # PATCH/PUT /strategies/1.json
  def update
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @strategy.published_at = nil if saving_as_draft?
    respond_to do |format|
      if @strategy.update(strategy_params)
        publish
        format.html { redirect_to strategy_path(@strategy) }
        format.json { render :show, status: :ok, location: @strategy }
      else
        format.html { render :edit }
        format.json { render_errors(@strategy) }
      end
    end
  end

  # DELETE /strategies/1
  # DELETE /strategies/1.json
  def destroy
    # Remove strategies from existing moments
    @moments = Moment.where(userid: current_user.id).all

    @moments.each do |item|
      item.strategy.delete(@strategy.id)
      the_moment = Moment.find_by(id: item.id)
      the_moment.update(strategy: item.strategy)
    end

    @strategy.destroy
    redirect_to_path(strategies_path)
  end

  private

  def render_errors(strategy)
    render json: strategy.errors, status: :unprocessable_entity
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_strategy
    @strategy = Strategy.friendly.find(params[:id])
  rescue
    redirect_to_path(strategies_path)
  end

  def strategy_params
    params.require(:strategy).permit(
      :name, :description, :userid, :published_at, :draft,
      :comment, { category: [] }, { viewers: [] },
      perform_strategy_reminder_attributes: %i[active id]
    )
  end

  def publish
    @strategy.update(published_at: Time.zone.now) if publishing?
  end

  def publishing?
    params[:publishing] == '1'
  end

  def saving_as_draft?
    params[:publishing] != '1'
  end
end
