# frozen_string_literal: true

class MoodsController < ApplicationController
  include CollectionPageSetupConcern
  include CategoriesHelper
  include SharedBasicConcern
  include TagsHelper
  before_action :set_mood, only: %i[show edit update destroy]

  # GET /moods
  # GET /moods.json
  def index
    page_collection('@moods', 'mood')
    respond_to do |format|
      format.json do
        render json: {
          data: categories_or_moods_props(@moods),
          lastPage: @moods.last_page?
        }
      end
      format.html
    end
  end

  # GET /moods/1
  # GET /moods/1.json
  def show
    setup_stories
    redirect_to_path(moods_path) if @mood.user_id != current_user.id
  end

  # GET /moods/new
  def new
    @mood = Mood.new
    @mood.visible = true
  end

  # GET /moods/1/edit
  def edit
    return if @mood.user_id == current_user.id

    redirect_to_path(mood_path(@mood))
  end

  # POST /moods
  # POST /moods.json
  def create
    @mood = Mood.new(mood_params.merge(user_id: current_user.id))
    shared_create(@mood)
  end

  # POST /moods
  # POST /moods.json
  def premade
    shared_add_premade(Mood, 5)
    redirect_to_path(moods_path)
  end

  # PATCH/PUT /moods/1
  # PATCH/PUT /moods/1.json
  def update
    shared_update(@mood, mood_params)
  end

  # DELETE /moods/1
  # DELETE /moods/1.json
  def destroy
    shared_destroy(@mood)
  end

  def quick_create
    shared_quick_create_basic(Mood, params)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mood
    @mood = Mood.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(moods_path)
  end

  def mood_params
    params.require(:mood).permit(:name, :description, :visible)
  end
end
