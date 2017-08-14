# frozen_string_literal: true
require 'groupdate'

class MomentsController < ApplicationController
  include CollectionPageSetup

  before_action :set_moment, only: %i[show edit update destroy]

  # GET /moments
  # GET /moments.json
  def index
    page_collection('@moments', 'moment')
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    show_with_comments(@moment)
  end

  def comment
    comment_for('moment')
  end

  def delete_comment
    comment_exists = Comment.where(id: params[:commentid]).exists?
    is_my_comment = Comment.where(id: params[:commentid], comment_by: current_user.id).exists?

    if comment_exists
      momentid = Comment.where(id: params[:commentid]).first.commented_on
      is_my_moment = Moment.where(id: momentid, userid: current_user.id).exists?
      is_a_viewer = is_viewer(Moment.where(id: momentid).first.viewers)
    else
      is_my_moment = false
      is_a_viewer = false
    end

    if comment_exists && ((is_my_comment && is_a_viewer) || is_my_moment)
      Comment.find(params[:commentid]).destroy

      # Delete corresponding notifications
      public_uniqueid = 'comment_on_moment_' + params[:commentid].to_s
      Notification.where(uniqueid: public_uniqueid).destroy_all

      private_uniqueid = 'comment_on_moment_private_' + params[:commentid].to_s
      Notification.where(uniqueid: private_uniqueid).destroy_all
    end

    head :ok
  end

  def quick_moment
    # Assumme all viewers and comments allowed
    viewers = []
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end

    Moment.create!(
      user: current_user,
      name: params[:moment][:name],
      why: params[:moment][:why],
      comment: true,
      viewers: viewers,
      category: params[:moment][:category],
      mood: params[:moment][:mood]
    )

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render root_path }
    end
  end

  # GET /moments/new
  def new
    @moment = Moment.new
    set_association_variables!
  end

  # GET /moments/1/edit
  def edit
    unless @moment.userid == current_user.id
      redirect_to_path(moment_path(@moment))
    end

    set_association_variables!
  end

  # POST /moments
  # POST /moments.json
  def create
    # TODO: Testing out SentimentAnalysis
    sentiment = SentimentAnalysis.new(language: "en", id: "test", text: moment_params[:why])
    sentiment.get_sentiment

    @moment = Moment.new(moment_params)

    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
    respond_to do |format|
      if @moment.save
        format.html { redirect_to moment_path(@moment) }
        format.json { render :show, status: :created, location: @moment }
      else
        format.html { render :new }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moments/1
  # PATCH/PUT /moments/1.json
  def update
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
    respond_to do |format|
      if @moment.update(moment_params)
        format.html { redirect_to moment_path(@moment) }
        format.json { render :show, status: :ok, location: @moment }
      else
        format.html { render :edit }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment.destroy
    redirect_to_path(moments_path)
  end

  # GET /moments/analytics
  # GET /moments/analytics.json
  def analytics
    period = params[:period].present? ? params[:period] : 'day'
    value = params[:value].present? ? params[:value] : 'Moments'
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : get_start_by_period(period, end_date)

    case value
      when 'Moments'
        # restrict our moments to our current user id
        result = Moment.where('userid = ?', current_user.id).group_by_period(period, :created_at, range: start_date..end_date).count
      when 'Categories'
        # TODO: implement
        result = {}
      when 'Moods'
        # TODO: implement
        result = {}
      else
        result = {}
    end

    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  private

  def set_moment
    @moment = Moment.friendly.find(params[:id])
  rescue
    redirect_to_path(moments_path)
  end

  def moment_params
    params.require(:moment).permit(
      :name, :why, :fix, :userid, :comment,
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
    strategy_ids = Strategy.where(user: current_user).pluck(:id)

    @viewers.each do |ally|
      Strategy.where(userid: ally.id).each do |strategy|
        strategy_ids << strategy.id if strategy.viewer?(current_user)
      end
    end

    Strategy.where(id: strategy_ids).order(created_at: :desc)
  end

  def get_start_by_period(period, end_date)
    case period
    when 'day'
      end_date - 1.weeks
    when 'week'
      end_date - 1.months
    when 'month'
      end_date - 1.years
    else
      end_date - 1.weeks
    end
  end
end
