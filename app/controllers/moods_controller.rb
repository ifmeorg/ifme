# frozen_string_literal: true

class MoodsController < ApplicationController
  include CollectionPageSetup
  include Shared
  before_action :set_mood, only: %i[show edit update destroy]

  # GET /moods
  # GET /moods.json
  def index
    page_collection('@moods', 'mood')
  end

  # GET /moods/1
  # GET /moods/1.json
  def show
    if @mood.user_id == current_user.id
      @page_edit = edit_mood_path(@mood)
      @page_tooltip = t('moods.edit_mood')
    else
      redirect_to_path(moods_path)
    end
  end

  # GET /moods/new
  def new
    @mood = Mood.new
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
    shared_create(@mood, 'mood')
  end

  # POST /moods
  # POST /moods.json
  def premade
    Mood.add_premade(current_user.id)
    redirect_to_path(moods_path)
  end

  # PATCH/PUT /moods/1
  # PATCH/PUT /moods/1.json
  def update
    shared_update(@mood, 'mood', mood_params)
  end

  # DELETE /moods/1
  # DELETE /moods/1.json
  def destroy
    shared_destroy(@mood, 'mood')
  end

  # rubocop:disable MethodLength
  def quick_create
    mood = Mood.new(
      user_id: current_user.id,
      name: params[:mood][:name],
      description: params[:mood][:description]
    )
    shared_quick_create(mood)
  end
  # rubocop:enable MethodLength

  private

  # Use callbacks to share common setup or constraints between actions.
  # rubocop:disable RescueStandardError
  def set_mood
    @mood = Mood.friendly.find(params[:id])
  rescue
    redirect_to_path(moods_path)
  end
  # rubocop:enable RescueStandardError

  def mood_params
    params.require(:mood).permit(:name, :description)
  end
end
