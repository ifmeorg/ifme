class GroupsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.where(:userid => current_user.id).all
    @page_title = "Groups"
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if current_user.id == @group.userid
      @page_edit = edit_group_path(@group)
    else
      link_url = "/profile?userid=" + @group.userid.to_s
      the_link = link_to User.where(:id => @group.userid).first.name, link_url
      @page_author = the_link.html_safe
    end
    @no_hide_page = false
    if hide_page && @group.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to groups_path }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      @support = Support.new
      @comments = Comment.where(:commented_on => @group.id, :comment_type => "group").all
      @no_hide_page = true
      @page_title = @group.name
    end
  end

  def comment
    @comment = Comment.create!(:comment_type => params[:comment][:comment_type], :commented_on => params[:comment][:commented_on], :comment_by => params[:comment][:comment_by], :comment => params[:comment][:comment], :visibility => params[:comment][:visibility])
    respond_to do |format|
        format.html { redirect_to group_path(params[:comment][:commented_on]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: Group.find(params[:comment][:commented_on]) }
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
        format.html { redirect_to group_path(support_id) }
        format.json { render :show, status: :created, location: Group.find(support_id) }
    end
  end

  # GET /groups/new
  def new
    @viewers = get_accepted_allies(current_user.id)
    @group = Group.new
    @page_title = "New Group"
  end

  # GET /groups/1/edit
  def edit
    if @group.userid == current_user.id
      @viewers = get_accepted_allies(current_user.id)
      @page_title = "Edit " + @group.name
    else
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.json { head :no_content }
      end
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @page_title = "New Group"
    @viewers = get_accepted_allies(current_user.id)
    respond_to do |format|
      if @group.save
        format.html { redirect_to group_path(@group), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @page_title = "Edit " + @group.name
    @viewers = get_accepted_allies(current_user.id)
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_path(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    # Remove groups from existing triggers
    @triggers = Trigger.where(:userid => current_user.id).all

    @triggers.each do |item|
      new_group = item.groups.delete(@group.id)
      the_trigger = Trigger.find_by(id: item.id)
      the_trigger.update(groups: item.groups)
    end

    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      begin
        @group = Group.find(params[:id])
      rescue
        if @group.blank?
          respond_to do |format|
            format.html { redirect_to groups_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :userid, :comment, {:category => []}, {:viewers => []})
    end

    def hide_page
      if Group.where(:userid => @group.userid).exists?
        Group.where(:userid => @group.userid).all.each do |item|
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
