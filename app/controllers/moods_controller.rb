class MoodsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_mood, only: [:show, :edit, :update, :destroy]

  # GET /moods
  # GET /moods.json
  def index
    name = params[:search]
    search = Mood.where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      @moods = search.order("created_at DESC").page(params[:page]).per($per_page)
    else
      @moods = Mood.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page]).per($per_page)
    end
    @page_tooltip = "#{t('moods.new')}"
  end

  # GET /moods/1
  # GET /moods/1.json
  def show
    if @mood.userid == current_user.id || is_viewer(params[:moment], @mood)
      if @mood.userid == current_user.id
        @page_edit = edit_mood_path(@mood)
        @page_tooltip = "#{t('moods.edit_mood')}"
      else
        link_url = "/profile?uid=" + get_uid(@mood.userid).to_s
        the_link = link_to User.where(:id => @mood.userid).first.name, link_url
        @page_author = the_link.html_safe
      end
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
    if @mood.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to mood_path(@mood) }
        format.json { head :no_content }
      end
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
    premade1 = Mood.create(userid: current_user.id, name: t('moods.index.premade1_name'), description: t('moods.index.premade1_description'))
    premade2 = Mood.create(userid: current_user.id, name: t('moods.index.premade2_name'), description: t('moods.index.premade2_description'))
    premade3 = Mood.create(userid: current_user.id, name: t('moods.index.premade3_name'), description: t('moods.index.premade3_description'))
    premade4 = Mood.create(userid: current_user.id, name: t('moods.index.premade4_name'), description: t('moods.index.premade4_description'))
    premade5 = Mood.create(userid: current_user.id, name: t('moods.index.premade5_name'), description: t('moods.index.premade5_description'))

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
    @moments = Moment.where(:userid => current_user.id).all

    @moments.each do |item|
      new_category = item.mood.delete(@mood.id)
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
      label = '<span class="notification_wrapper">
            <span class="tip_notifications_button link_style">' + mood.name + '</span><br>'
      label += render_to_string :partial => '/notifications/preview', locals: { data: mood, edit: edit_mood_path(mood) }
      label += '</span>'
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
      begin
        @mood = Mood.find(params[:id])
      rescue
        if @mood.blank?
          respond_to do |format|
            format.html { redirect_to moods_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mood_params
      params.require(:mood).permit(:name, :description, :userid)
    end

    def if_not_signed_in
      if !user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
          format.json { head :no_content }
        end
      end
    end

    def is_viewer(moment, mood)
      if moment.blank?
        return false
      else
        if Moment.where(:id => moment).exists? && Moment.where(:id => moment).first.mood.include?(mood.id) && Moment.where(:id => moment).first.viewers.include?(current_user.id) && are_allies(moment.userid, current_user.id)
          return true
        end
      end
      return false
    end
end
