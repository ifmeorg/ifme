class TriggersController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_trigger, only: [:show, :edit, :update, :destroy]

  # GET /triggers
  # GET /triggers.json
  def index
    @triggers = Trigger.where(:userid => current_user.id).all
    @page_title = "Triggers"
    @page_new = new_trigger_path
  end

  # GET /triggers/1
  # GET /triggers/1.json
  def show
    if current_user.id == @trigger.userid
      @page_edit = edit_trigger_path(@trigger) 
    end
    @no_hide_page = false
    if hide_page && @trigger.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to triggers_url }
        format.json { head :no_content }
      end
    else 
      @comment = Comment.new
      @support = Support.new
      @comments = Comment.where(:commented_on => @trigger.id).all
      @no_hide_page = true
      @page_title = @trigger.name
    end 
  end

  def comment
    @comment = Comment.create(:comment_type => params[:comment][:comment_type], :commented_on => params[:comment][:commented_on], :comment_by => params[:comment][:comment_by], :comment => params[:comment][:comment])
    respond_to do |format|
        format.html { redirect_to Trigger.find(params[:comment][:commented_on]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: Trigger.find(params[:comment][:commented_on]) }
    end
  end 

  def support
    if !params[:support].nil? && !params[:support][:userid].empty? && !params[:support][:support_type].empty? && !params[:support][:support_id].empty?
      params[:userid] = params[:support][:userid]
      params[:support_type] = params[:support][:support_type]
      params[:support_id] = params[:support][:support_id]
    end
    
    if Support.where(userid: params[:userid], support_type: params[:support_type]).exists?
      new_support_ids = Support.where(userid: params[:userid], support_type: params[:support_type]).first.support_ids
      if new_support_ids.include?(params[:support_id])
    else
      support_id = params[:support_id].to_i
      @support = Support.create(userid: params[:userid], support_type: params[:support_type], support_ids: Array.new(support_id))
    end

    respond_to do |format|
        format.html { redirect_to trigger_path(support_id) }
        format.json { render :show, status: :created, location: Trigger.find(support_id) }
    end
  end 

  # GET /triggers/new
  def new
    @viewers = Array.new
    if Ally.where(:userid => current_user.id).exists?
      User.where.not(:id => current_user.id).all.each do |item|
        if Ally.where(:userid => item.id).exists? && Ally.where(:userid => item.id).first.allies.include?(current_user.id.to_s) && Ally.where(:userid => current_user.id).first.allies.include?(item.id.to_s)
          @viewers.push(item.id)
        end
      end
    end 
    @trigger = Trigger.new
    @page_title = "New Trigger"
  end

  # GET /triggers/1/edit
  def edit
    if @trigger.userid == current_user.id
      @viewers = Array.new
      if Ally.where(:userid => current_user.id).exists?
        User.where.not(:id => current_user.id).all.each do |item|
          if Ally.where(:userid => item.id).exists? && Ally.where(:userid => item.id).first.allies.include?(current_user.id.to_s) && Ally.where(:userid => current_user.id).first.allies.include?(item.id.to_s)
            @viewers.push(item.id)
          end
        end
      end 
      @page_title = "Edit " + @trigger.name
    else 
      respond_to do |format|
        format.html { redirect_to triggers_url }
        format.json { head :no_content }
      end
    end 
  end

  # POST /triggers
  # POST /triggers.json
  def create
    @trigger = Trigger.new(trigger_params)
    respond_to do |format|
      if @trigger.save
        format.html { redirect_to @trigger, notice: 'Trigger was successfully created.' }
        format.json { render :show, status: :created, location: @trigger }
      else
        format.html { render :new }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /triggers/1
  # PATCH/PUT /triggers/1.json
  def update
    respond_to do |format|
      if @trigger.update(trigger_params)
        format.html { redirect_to @trigger, notice: 'Trigger was successfully updated.' }
        format.json { render :show, status: :ok, location: @trigger }
      else
        format.html { render :edit }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /triggers/1
  # DELETE /triggers/1.json
  def destroy
    @trigger.destroy
    respond_to do |format|
      format.html { redirect_to triggers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trigger
      begin
        @trigger = Trigger.find(params[:id])
      rescue
        if @trigger.blank?
          respond_to do |format|
            format.html { redirect_to triggers_url }
            format.json { head :no_content }
          end
        end 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trigger_params
      params.require(:trigger).permit(:name, :why, :fix, :userid, {:category => []}, {:mood => []}, {:viewers => []})
    end

    def hide_page 
      if Trigger.where(:userid => @trigger.userid).exists?
        Trigger.where(:userid => @trigger.userid).all.each do |item|
          if item.viewers.include?(current_user.id.to_s) 
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
