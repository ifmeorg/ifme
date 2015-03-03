class StrategiesController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_strategy, only: [:show, :edit, :update, :destroy]

  # GET /strategies
  # GET /strategies.json
  def index
    @strategies = Strategy.where(:userid => current_user.id).all
    @page_title = "Strategies"
    @page_new = new_strategy_path
  end

  # GET /strategies/1
  # GET /strategies/1.json
  def show
    if current_user.id == @strategy.userid
      @page_edit = edit_strategy_path(@strategy)
    else
      link_url = "/profile?userid=" + @strategy.userid.to_s
      the_link = link_to User.where(:id => @strategy.userid).first.firstname + " " + User.where(:id => @strategy.userid).first.lastname, link_url
      @page_author = the_link.html_safe
    end
    @no_hide_page = false
    if hide_page && @strategy.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to strategies_path }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      @support = Support.new
      @comments = Comment.where(:commented_on => @strategy.id, :comment_type => "strategy").all
      @no_hide_page = true
      @page_title = @strategy.name
    end
  end

  def comment
    @comment = Comment.create!(:comment_type => params[:comment][:comment_type], :commented_on => params[:comment][:commented_on], :comment_by => params[:comment][:comment_by], :comment => params[:comment][:comment], :visibility => params[:comment][:visibility])
    respond_to do |format|
        format.html { redirect_to strategy_path(params[:comment][:commented_on]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: Strategy.find(params[:comment][:commented_on]) }
    end
  end

  def support
    if !params[:support].nil? && !params[:support][:userid].empty? && !params[:support][:support_type].empty? && !params[:support][:support_id].empty?
      params[:userid] = params[:support][:userid]
      params[:support_type] = params[:support][:support_type]
      params[:support_id] = params[:support][:support_id]
    end

    support_id = params[:support_id].to_i

    if Support.where(userid: params[:userid], support_type: params[:support_type]).exists?
      new_support_ids = Support.where(userid: params[:userid], support_type: params[:support_type]).first.support_ids
      if new_support_ids.include?(support_id)
        new_support_ids.delete(support_id)
        the_support = Support.find_by(userid: params[:userid], support_type: params[:support_type])
        if new_support_ids.empty?
          @support = the_support.destroy
        else
          @support = the_support.update!(support_ids: new_support_ids)
        end
      else
        new_support_ids = new_support_ids.push(support_id)
        the_support = Support.find_by(userid: params[:userid], support_type: params[:support_type])
        the_support.update!(support_ids: new_support_ids)
      end
    else
      @support = Support.create!(userid: params[:userid], support_type: params[:support_type], support_ids: Array.new(1, support_id))
    end

    respond_to do |format|
        format.html { redirect_to strategy_path(support_id) }
        format.json { render :show, status: :created, location: Strategy.find(support_id) }
    end
  end

  # GET /strategies/new
  def new
    @viewers = get_accepted_allies(current_user.id)
    @strategy = Strategy.new
    @page_title = "New Strategy"
  end

  # GET /strategies/1/edit
  def edit
    if @strategy.userid == current_user.id
      @viewers = get_accepted_allies(current_user.id)
      @page_title = "Edit " + @strategy.name
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
    @page_title = "New Strategy"
    @viewers = get_accepted_allies(current_user.id)
    respond_to do |format|
      if @strategy.save
        format.html { redirect_to strategy_path(@strategy), notice: 'Strategy was successfully created.' }
        format.json { render :show, status: :created, location: @strategy }
      else
        format.html { render :new }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /strategies/1
  # PATCH/PUT /strategies/1.json
  def update
    @page_title = "Edit " + @strategy.name
    @viewers = get_accepted_allies(current_user.id)
    respond_to do |format|
      if @strategy.update(strategy_params)
        format.html { redirect_to strategy_path(@strategy), notice: 'Strategy was successfully updated.' }
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
    # Remove strategies from existing triggers
    @triggers = Trigger.where(:userid => current_user.id).all

    @triggers.each do |item|
      new_strategy = item.strategies.delete(@strategy.id)
      the_trigger = Trigger.find_by(id: item.id)
      the_trigger.update(strategies: item.strategies)
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
      begin
        @strategy = Strategy.find(params[:id])
      rescue
        if @strategy.blank?
          respond_to do |format|
            format.html { redirect_to strategies_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def strategy_params
      params.require(:strategy).permit(:name, :description, :userid, :comment, {:category => []}, {:viewers => []})
    end

    def hide_page
      if Strategy.where(:userid => @strategy.userid).exists?
        Strategy.where(:userid => @strategy.userid).all.each do |item|
          if item.viewers.include?(current_user.id)
            return false
          end
        end
      end
      return true
    end

    def if_not_signed_in
      if !user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
          format.json { head :no_content }
        end
      end
    end

end
