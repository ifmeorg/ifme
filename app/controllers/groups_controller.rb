class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.groups
                          .includes(:group_members)
                          .order("groups.created_at DESC")
    @page_tooltip = "New group"
    @page_new = new_group_path
    @available_groups = current_user.available_groups("groups.created_at DESC")
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if @group.members.include? current_user
      @meetings = @group.meetings.includes(:leaders)
    end

    if @group.led_by?(current_user)
      @page_new = new_meeting_path(groupid: @group.id)
      @page_tooltip = "New meeting"
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @group_members = GroupMember.where(groupid: @group.id).all
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    if @group.save
      leader = new_group_leader
      if leader.save
        notify_allies
        return redirect_to_group
      end
    end

    errors = @group.errors || leader.errors
    render_new(errors)
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        update_leaders

        format.html { redirect_to groups_path }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @group_member = GroupMember.create!(group_member_params)
    group = @group_member.group
    GroupNotifier.new(group, 'new_group_member', current_user)
                 .send_notifications_to(group.leaders)

    flash[:notice] = 'You have joined this group.'
    redirect_to_group
  end

  def leave
    member_id = params[:memberid] || current_user.id
    group_member = GroupMember.find_by(userid: member_id, groupid: params[:groupid])
    group = group_member.group

    # Cannot leave When you are the only leader
    if group.leader_ids == [member_id]
      flash[:alert] = 'You cannot leave the group, you are the only leader.'
    else
      group_member.destroy

      if member_id == current_user.id
        flash[:notice] = "You have left #{group.name}"
      else
        flash[:notice] = "You have removed #{group_member.user.name} from \
                         #{group.name}"
      end
    end

    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy

    # Delete notifications for this group
    Notification.where("uniqueid ilike ?", "%new_group%").all.each do |notification|
      if JSON.parse(notification.data)["groupid"].to_i == @group.id.to_i
        notification.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :description)
  end

  def group_member_params
    params.permit(:groupid).merge(userid: current_user.id, leader: false)
  end

  def update_leaders
    return if params[:group][:leader].nil?
    @group.group_members.each do |group_member|
      if params[:group][:leader].include? group_member.userid.to_s
        group_member.update(leader: true)
        pusher_type = 'add_group_leader'
      else
        group_member.update(leader: false)
        pusher_type = 'remove_group_leader'
      end

      GroupNotifier.new(@group, pusher_type, current_user)
                   .send_notifications_to(@group.leaders)
    end
  end

  def new_group_leader
    @group.group_members.new(user: current_user, leader: true)
  end

  def notify_allies
    accepted_allies = current_user.allies_by_status(:accepted)
    GroupNotifier.new(@group, 'new_group', current_user)
                 .send_notifications_to(accepted_allies)
  end

  def redirect_to_group
    respond_to do |format|
      format.html { redirect_to group_path(@group) }
      format.json { render :show, status: :created, location: @group }
    end
  end

  def render_new(errors)
    respond_to do |format|
      format.html { render :new }
      format.json { render json: errors, status: :unprocessable_entity }
    end
  end
end
