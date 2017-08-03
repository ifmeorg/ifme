# frozen_string_literal: true

class StrategiesController < ApplicationController
  include CollectionPageSetup
  include ReminderHelper
  before_action :set_strategy, only: %i[show edit update destroy]

  def default_params
    @default_params ||= {
      strategy: {
        viewers: [],
        category: []
      }
    }
  end

  # GET /strategies
  # GET /strategies.json
  def index
    page_collection('@strategies', 'strategy')
  end

  # GET /strategies/1
  # GET /strategies/1.json
  def show
    if current_user.id == @strategy.userid
      @page_edit = edit_strategy_path(@strategy)
      @page_tooltip = t('strategies.edit_strategy')
    else
      link_url = '/profile?uid=' + get_uid(@strategy.userid).to_s
      name = User.where(id: @strategy.userid).first.name
      the_link = sanitize link_to name, link_url
      @page_author = the_link.html_safe
    end
    @no_hide_page = false
    if hide_page(@strategy) && @strategy.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to strategies_path }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      # @support = Support.new
      @comments = Comment.where(commented_on: @strategy.id, comment_type: 'strategy').all.order('created_at DESC')
      @no_hide_page = true
    end
  end

  def comment
    if params[:viewers].blank?
      @comment = Comment.new(comment_type: params[:comment_type], commented_on: params[:commented_on], comment_by: params[:comment_by], comment: params[:comment], visibility: params[:visibility])
    else
      # Can only get here if comment is from Strategy creator
      @comment = Comment.new(comment_type: params[:comment_type], commented_on: params[:commented_on], comment_by: params[:comment_by], comment: params[:comment], visibility: 'private', viewers: [params[:viewers].to_i])
    end

    unless @comment.save
      result = { no_save: true }
      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end

    # Notify commented_on user that they have a new comment
    strategy_user = Strategy.where(id: @comment.commented_on).first.userid

    if strategy_user != @comment.comment_by
      strategy_name = Strategy.where(id: @comment.commented_on).first.name
      cutoff = false
      cutoff = true if @comment.comment.length > 80
      uniqueid = 'comment_on_strategy' + '_' + @comment.id.to_s

      data = JSON.generate(
        user: current_user.name,
        strategyid: @comment.commented_on,
        strategy: strategy_name,
        commentid: @comment.id,
        comment: @comment.comment[0..80],
        cutoff: cutoff,
        type: 'comment_on_strategy',
        uniqueid: uniqueid
      )

      Notification.create(userid: strategy_user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: strategy_user).order('created_at ASC').all
      Pusher['private-' + strategy_user.to_s].trigger('new_notification', notifications: notifications)

      NotificationMailer.notification_email(strategy_user, data).deliver_now

    # Notify viewer that they have a new comment
    elsif @comment.viewers.present? && User.where(id: @comment.viewers[0]).exists?
      private_user = User.where(id: @comment.viewers[0]).first.id
      strategy_name = Strategy.where(id: @comment.commented_on).first.name
      cutoff = false
      cutoff = true if @comment.comment.length > 80
      uniqueid = 'comment_on_strategy_private' + '_' + @comment.id.to_s

      data = JSON.generate(
        user: current_user.name,
        strategyid: @comment.commented_on,
        strategy: strategy_name,
        commentid: @comment.id,
        comment: @comment.comment[0..80],
        cutoff: cutoff,
        type: 'comment_on_strategy_private',
        uniqueid: uniqueid
      )

      Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: private_user).order('created_at ASC').all
      Pusher['private-' + private_user.to_s].trigger('new_notification', notifications: notifications)

      NotificationMailer.notification_email(private_user, data).deliver_now
    end

    return unless @comment.save

    result = generate_comment(@comment, 'strategy')
    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  def delete_comment
    comment_exists = Comment.where(id: params[:commentid]).exists?
    is_my_comment = Comment.where(id: params[:commentid], comment_by: current_user.id).exists?

    if comment_exists
      strategyid = Comment.where(id: params[:commentid]).first.commented_on
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

    render nothing: true
  end

  def quick_create
    # Assumme all viewers and comments allowed
    viewers = []
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end

    strategy = Strategy.new(userid: current_user.id, name: params[:strategy][:name], description: params[:strategy][:description], category: params[:strategy][:category], comment: true, viewers: viewers)

    if strategy.save
      result = render_checkbox(strategy, 'strategies', 'moment')
    else
      result = { error: 'error' }
    end

    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
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
      respond_to do |format|
        format.html { redirect_to strategy_path(@strategy) }
        format.json { head :no_content }
      end
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
        format.html { redirect_to strategy_path(@strategy) }
        format.json { render :show, status: :created, location: @strategy }
      else
        format.html { render :new }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /strategies
  # POST /strategies.json
  def premade
    premade_category = Category.where(name: 'Meditation', userid: current_user.id)
    premade1 =
      if premade_category.exists?
        Strategy.new(
          userid: current_user.id,
          name: t('strategies.index.premade1_name'),
          description: t('strategies.index.premade1_description'),
          category: [premade_category.first.id], comment: false
        )
      else
        Strategy.new(
          userid: current_user.id,
          name: t('strategies.index.premade1_name'),
          description: t('strategies.index.premade1_description'),
          comment: false
        )
      end

    respond_to do |format|
      if premade1.save
        PerformStrategyReminder.create(strategy_id: premade1.id, active: false)
        format.html { redirect_to strategies_path }
        format.json { render :no_content }
      else
        format.html { redirect_to strategies_path }
        format.json do
          render json: premade1.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /strategies/1
  # PATCH/PUT /strategies/1.json
  def update
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    respond_to do |format|
      if @strategy.update(strategy_params)
        format.html { redirect_to strategy_path(@strategy) }
        format.json { render :show, status: :ok, location: @strategy }
      else
        format.html { render :edit }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /strategies/1
  # DELETE /strategies/1.json
  def destroy
    # Remove strategies from existing moments
    @moments = Moment.where(userid: current_user.id).all

    @moments.each do |item|
      item.strategies.delete(@strategy.id)
      the_moment = Moment.find_by(id: item.id)
      the_moment.update(strategies: item.strategies)
    end

    @strategy.destroy
    respond_to do |format|
      format.html { redirect_to strategies_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_strategy
    @strategy = Strategy.friendly.find(params[:id])
  rescue
    respond_to do |format|
      format.html { redirect_to strategies_path }
      format.json { head :no_content }
    end
  end

  def strategy_params
    params[:strategy] = default_params[:strategy].merge(params[:strategy])
    params.require(:strategy).permit(
      :name, :description, :userid,
      :comment, { category: [] }, { viewers: [] },
      perform_strategy_reminder_attributes: %i[active id]
    )
  end

  def hide_page(strategy)
    if Strategy.where(id: strategy.id).exists?
      if Strategy.where(id: strategy.id).first.viewers.include?(current_user.id) && are_allies(strategy.userid, current_user.id)
        return false
      end
    end
    true
  end
end
