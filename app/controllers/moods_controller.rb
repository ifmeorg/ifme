# frozen_string_literal: true

class MoodsController < ApplicationController
  include CollectionPageSetup
  before_action :set_mood, only: %i[show edit update destroy]

  # GET /moods
  # GET /moods.json
  def index
    page_collection('@moods', 'mood')
  end

  # GET /moods/1
  # GET /moods/1.json
  def show
    if @mood.userid == current_user.id
      @page_edit = edit_mood_path(@mood)
      @page_tooltip = t('moods.edit_mood')
    elsif !(moment = params[:moment]).nil? &&
          moment.first.mood.include?(@mood.id) &&
          is_viewer(moment.first.viewers) &&
          are_allies(moment.userid, current_user.id)
      link_url = '/profile?uid=' + get_uid(@mood.userid).to_s
      name = User.where(id: @mood.userid).first.name
      the_link = sanitize link_to name, link_url
      @page_author = the_link.html_safe
    else
      respond_to do |format|
        format.html { redirect_to moods_path }
        format.json { head :no_content }
      end
    end
  end

  # GET /moods/new
  def new
    @mood = Mood.new
  end

  # GET /moods/1/edit
  def edit
    return if @mood.userid == current_user.id

    respond_to do |format|
      format.html { redirect_to mood_path(@mood) }
      format.json { head :no_content }
    end
  end

  # POST /moods
  # POST /moods.json
  def create
    @mood = Mood.new(mood_params)
    respond_to do |format|
      if @mood.save
        format.html { redirect_to mood_path(@mood) }
        format.json { render :show, status: :created, location: @mood }
      else
        format.html { render :new }
        format.json { render json: @mood.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /moods
  # POST /moods.json
  def premade
    Mood.create(userid: current_user.id, name: t('moods.index.premade1_name'), description: t('moods.index.premade1_description'))
    Mood.create(userid: current_user.id, name: t('moods.index.premade2_name'), description: t('moods.index.premade2_description'))
    Mood.create(userid: current_user.id, name: t('moods.index.premade3_name'), description: t('moods.index.premade3_description'))
    Mood.create(userid: current_user.id, name: t('moods.index.premade4_name'), description: t('moods.index.premade4_description'))
    Mood.create(userid: current_user.id, name: t('moods.index.premade5_name'), description: t('moods.index.premade5_description'))

    respond_to do |format|
      format.html { redirect_to moods_path }
      format.json { render :no_content }
    end
  end

  # PATCH/PUT /moods/1
  # PATCH/PUT /moods/1.json
  def update
    respond_to do |format|
      if @mood.update(mood_params)
        format.html { redirect_to mood_path(@mood) }
        format.json { render :show, status: :ok, location: @mood }
      else
        format.html { render :edit }
        format.json { render json: @mood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moods/1
  # DELETE /moods/1.json
  def destroy
    # Remove moods from existing moments
    @moments = Moment.where(userid: current_user.id).all

    @moments.each do |item|
      item.mood.delete(@mood.id)
      the_moment = Moment.find_by(id: item.id)
      the_moment.update(mood: item.mood)
    end

    @mood.destroy
    respond_to do |format|
      format.html { redirect_to moods_path }
      format.json { head :no_content }
    end
  end

  def quick_create
    mood = Mood.new(userid: current_user.id, name: params[:mood][:name], description: params[:mood][:description])

    if mood.save
      checkbox = '<input type="checkbox" value="' + mood.id.to_s + '" name="moment[mood][]" id="moment_mood_' + mood.id.to_s + '">'
      label = '<span>' + mood.name + '</span><br>'
      result = { checkbox: checkbox, label: label }
    else
      result = { error: 'error' }
    end

    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mood
    @mood = Mood.friendly.find(params[:id])
  rescue
    respond_to do |format|
      format.html { redirect_to moods_path }
      format.json { head :no_content }
    end
  end

  def mood_params
    params.require(:mood).permit(:name, :description, :userid)
  end
end
