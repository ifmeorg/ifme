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
    else
      link_url = "/profile?userid=" + @trigger.userid.to_s
      the_link = link_to User.where(:id => @trigger.userid).first.name, link_url
      @page_author = the_link.html_safe
    end
    @no_hide_page = false
    if hide_page && @trigger.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to triggers_path }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      @support = Support.new
      @comments = Comment.where(:commented_on => @trigger.id, :comment_type => 'trigger').all
      @no_hide_page = true
      @page_title = @trigger.name
    end
  end

  def comment
    @comment = Comment.create!(:comment_type => params[:comment][:comment_type], :commented_on => params[:comment][:commented_on], :comment_by => params[:comment][:comment_by], :comment => params[:comment][:comment], :visibility => params[:comment][:visibility])
    respond_to do |format|
        format.html { redirect_to trigger_path(params[:comment][:commented_on]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: Trigger.find(params[:comment][:commented_on]) }
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
        format.html { redirect_to trigger_path(support_id) }
        format.json { render :show, status: :created, location: Trigger.find(support_id) }
    end
  end

  # GET /triggers/new
  def new
    @viewers = get_accepted_allies(current_user.id)
    @trigger = Trigger.new
    @page_title = "New Trigger"
  end

  # GET /triggers/1/edit
  def edit
    if @trigger.userid == current_user.id
      @viewers = get_accepted_allies(current_user.id)
      @page_title = "Edit " + @trigger.name
    else
      respond_to do |format|
        format.html { redirect_to trigger_path(@trigger) }
        format.json { head :no_content }
      end
    end
  end


  # POST /triggers
  # POST /triggers.json
  def create
    @trigger = Trigger.new(trigger_params)
    @page_title = "New Trigger"
    #@allowed_viewers = Viewer.where(:triggerid => @trigger.id).pluck(:viewerid).join("\n")
    respond_to do |format|
      if @trigger.save
        format.html { redirect_to trigger_path(@trigger), notice: 'Trigger was successfully created.' }
        format.json { render :show, status: :created, location: @trigger }
      else
        format.html { render :new }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  def allies
    @viewers = get_accepted_allies(current_user.id)
    if params[:commit]
      if params[:viewers]
        @allowed_viewers = params[:viewers]
        @allowed_viewers.each do |viewer|
          Viewer.create(userid: current_user.id, triggerid: (Trigger.last.id + 1), viewerid: User.where(name: viewer).first.id)
          #User.where(name: viewer).first.update_attributes!(:view_permission => true)
          #@viewers.delete(User.where(name: viewer).first.id)
        end
        @views = Viewer.where(:triggerid => (Trigger.last.id + 1)).pluck(:viewerid)
        Rails.logger.info "+++++++++++++++"
        Rails.logger.info @views
        Rails.logger.info "+++++++++++++++"
      else
          #User.update_all(:view_permission => false)
      end
    else
      render :layout => false
    end
  end

  # PATCH/PUT /triggers/1
  # PATCH/PUT /triggers/1.json
  def update
    @page_title = "Edit " + @trigger.name
    @viewers = get_accepted_allies(current_user.id)
    respond_to do |format|
      if @trigger.update(trigger_params)
        format.html { redirect_to trigger_path(@trigger), notice: 'Trigger was successfully updated.' }
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
      format.html { redirect_to triggers_path }
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
            format.html { redirect_to triggers_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trigger_params
      params.require(:trigger).permit(:name, :why, :fix, :userid, :comment, :post_type, {:category => []}, {:mood => []}, {:viewers => []}, {:strategies => []})
    end

    def hide_page
      if Trigger.where(:userid => @trigger.userid).exists?
        Trigger.where(:userid => @trigger.userid).all.each do |item|
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
