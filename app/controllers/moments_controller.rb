# frozen_string_literal: true
class MomentsController < ApplicationController
  include CollectionPageSetupConcern
  include MomentsHelper
  include MomentsConcern
  include MomentsStatsHelper
  include MomentsFormHelper
  include Shared
  include TagsHelper

  before_action :set_moment, only: %i[show edit update destroy picture]
  before_action :load_viewers, only: %i[new edit create update picture]

  # GET /moments
  # GET /moments.json
  def index
    page_collection('@moments', 'moment')
    respond_to do |format|
      format.json { render json: moments_data_json }
      format.html { moments_data_html }
    end
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    show_with_comments(@moment)
    resources_data = get_resources_data(@moment, current_user)
    @resources = ResourceRecommendations.new(
      moment: @moment, current_user: current_user
    ).call
    @show_crisis_prevention = resources_data[:show_crisis_prevention]
    @resources_tags = resources_data[:tags]
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
    if (publishing? && !@moment.published?) || saving_as_draft?
      @moment.published_at = !saving_as_draft? && Time.zone.now
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

  # POST /moments/1/picture
  # POST /moments/1/picture.json
  def picture
    # TODO: add image upload options
    cloudinary_response = CloudinaryService.upload(file, options)
    return if cloudinary_response.nil?

    moment = set_moment(params[:moment_id])
    moment.picture_id = cloudinary_response['public_id']
    moment.save!
  end

  def tagged
    setup_stories
    respond_to do |format|
      format.json do
        render json: tagged_moments_data_json if @moments
      end
    end
  end

  private

  def set_moment
    @moment = Moment.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(moments_path)
  end

  def moment_params
    params.require(:moment).permit(:name, :why, :fix, :comment, :draft,
                                   :bookmarked, :resource_recommendations,
                                   category: [], mood: [], viewers: [],
                                   strategy: [])
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
end
