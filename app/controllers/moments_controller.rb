class MomentsController < ApplicationController
  include CollectionPageSetup
  before_action :set_moment, only: [:show, :edit, :update, :destroy]

  def default_params
    @default_params ||= {
      moment: {
        category: [],
        mood: [],
        viewers: [],
        strategies: []
      }
    }
  end

  # GET /moments
  # GET /moments.json
  def index
    page_collection('@moments', 'moment')
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    if current_user.id == @moment.userid
      @page_edit = edit_moment_path(@moment)
      @page_tooltip = t('moments.edit_moment')
    else
      link_url = "/profile?uid=" + get_uid(@moment.userid).to_s
      the_link = link_to User.where(:id => @moment.userid).first.name, link_url
      @page_author = the_link.html_safe
    end
    @no_hide_page = false
    if hide_page(@moment) && @moment.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to moments_path }
        format.json { head :no_content }
      end
    else
      @comments = Comment.where(commented_on: @moment.id, comment_type: 'moment').all.order("created_at DESC")
      @no_hide_page = true
    end
  end

  def quick_moment
    # Assumme all viewers and comments allowed
    viewers = Array.new
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end

    moment = Moment.new(userid: current_user.id, name: params[:moment][:name], why: params[:moment][:why], comment: true, viewers: viewers, category: params[:moment][:category], mood: params[:moment][:mood])
    moment.save

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render root_path }
    end
  end

  # GET /moments/new
  def new
    @viewers = current_user.allies_by_status(:accepted)
    @categories = Category.where(:userid => current_user.id).all.order("created_at DESC")
    @moods = Mood.where(:userid => current_user.id).all.order("created_at DESC")

    # current_user's strategies and all viewable strategies from allies
    my_strategies = Strategy.where(:userid => current_user.id).all.order("created_at DESC")
    ally_strategies = []
    @viewers.each do |ally|
      Strategy.where(userid: ally.id).all.order("created_at DESC").each do |strategy|
        if strategy.viewers.include?(current_user.id)
          ally_strategies << strategy
        end
      end
    end
    my_strategies += ally_strategies
    @strategies = Strategy.where(id: my_strategies.map(&:id)).all.order("created_at DESC")

    @moment = Moment.new
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
  end

  # GET /moments/1/edit
  def edit
    if @moment.userid == current_user.id
      @viewers = current_user.allies_by_status(:accepted)
      @categories = Category.where(:userid => current_user.id).all.order("created_at DESC")
      @moods = Mood.where(:userid => current_user.id).all.order("created_at DESC")

      # current_user's strategies and all viewable strategies from allies
      my_strategies = Strategy.where(:userid => current_user.id).all.order("created_at DESC")
      ally_strategies = []
      @viewers.each do |ally|
        Strategy.where(userid: ally.id).all.order("created_at DESC").each do |strategy|
          if strategy.viewers.include?(current_user.id)
            ally_strategies << strategy
          end
        end
      end
      my_strategies += ally_strategies
      @strategies = Strategy.where(id: my_strategies.map(&:id)).all.order("created_at DESC")

      @category = Category.new
      @mood = Mood.new
      @strategy = Strategy.new
    else
      respond_to do |format|
        format.html { redirect_to moment_path(@moment) }
        format.json { head :no_content }
      end
    end
  end

  # POST /moments
  # POST /moments.json
  def create
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
    respond_to do |format|
      format.html { redirect_to moments_path }
      format.json { head :no_content }
    end
  end

  private

  def set_moment
    @moment = Moment.find(params[:id])
  rescue
    respond_to_nothing(moments_path) if @moment.blank?
  end

  def moment_params
    params[:moment] = default_params[:moment].merge(params[:moment])

    params.require(:moment).permit(:name, :why, :fix, :userid, :comment,
      category: [], mood: [], viewers: [], strategies: [])
  end

  def hide_page(moment)
    if Moment.where(id: moment.id).exists?
      if Moment.where(id: moment.id).first.viewers.include?(current_user.id) && are_allies(moment.userid, current_user.id)
        return false
      end
    end
    return true
  end
end
