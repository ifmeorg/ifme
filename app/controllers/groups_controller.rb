class GroupsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = GroupMember.where(userid: current_user.id).all
    @page_title = "Groups"
    accepted_allies = get_accepted_allies(current_user.id)
    @page_new = new_group_path

    @available_groups = Array.new
  	find_available_groups = GroupMember.where(userid: accepted_allies).all
  	find_available_groups.each do |group|
  		if !GroupMember.where(userid: current_user.id, groupid: group.groupid).exists?
  			@available_groups.push(group)
  		end
  	end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  	@group = Group.find(params[:id])
  	@page_title = @group.name
    @page_new = new_meeting_path
  	@meetings = Meeting.where(groupid: @group.id).order('created_at DESC')
  	@group_leaders = GroupMember.where(groupid: @group.id, leader: true).all
  end

  # GET /groups/new
  def new
    @group = Group.new
    @page_title = "New Group"
  end

  # GET /groups/1/edit
  def edit
    @page_title = "Edit " + @group.name
    @group_members = GroupMember.where(groupid: @group.id).all
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @page_title = "New Group"
    respond_to do |format|
      if @group.save
        group_member = GroupMember.new(groupid: @group.id, userid: current_user.id, leader: true)
        if group_member.save
          format.html { redirect_to group_path(@group), notice: 'Group was successfully created.' }
          format.json { render :show, status: :created, location: @group }
        end
      end

      format.html { render :new }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @page_title = "Edit " + @group.name
    respond_to do |format|
      if @group.update(group_params)
        error = false
        group_members = GroupMember.where(groupid: @group.id).all
        group_members.each do |member|
          group_member_id = GroupMember.where(groupid: @group.id, userid: member.userid).first.id
          if params[:group][:leader].nil?
            error = true
            break
          elsif params[:group][:leader].include? member.userid.to_s
            GroupMember.update(group_member_id, groupid: @group.id, userid: member.userid, leader: true)
          else
            GroupMember.update(group_member_id, groupid: @group.id, userid: member.userid, leader: false)
          end
        end
        if !error
          format.html { redirect_to group_path(@group), notice: 'Group was successfully updated.' }
          format.json { render :show, status: :ok, location: @group }
        else
          @group_members = GroupMember.where(groupid: @group.id).all
          format.html { render :edit }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @group_member = GroupMember.create!(groupid: params[:groupid], userid: current_user.id, leader: false)

    respond_to do |format|
        format.html { redirect_to group_path(params[:groupid]), notice: 'You have joined this group.' }
        format.json { render :show, status: :created, location: Group.find(params[:groupid]) }
    end
  end

  def leave
    group_name = Group.where(id: params[:groupid]).first.name

    # Cannot leave When you are the only leader
    is_leader = GroupMember.where(userid: current_user.id, groupid: params[:groupid], leader: true).count
    are_leaders = GroupMember.where(groupid: params[:groupid], leader: true).count
    if (is_leader == 1 && are_leaders == is_leader)
      respond_to do |format|
        format.html { redirect_to groups_path, alert: 'You cannot leave the group, you are the only leader.' }
        format.json { head :no_content }
      end
    else
      # Remove corresponding meetings
      meetings = MeetingMember.where(userid: current_user.id).all
      meetings.each do |meeting|
        group_meetings = Meeting.where(id: meeting.id, groupid: params[:groupid]).all
        group_meetings.each do |group_meeting|
          group_meeting.destroy
        end
      end

      group_member = GroupMember.find_by(userid: current_user.id, groupid: params[:groupid])
      group_member.destroy

      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'You have left ' + group_name }
        format.json { head :no_content }
      end
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
      params.require(:group).permit(:name, :description)
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
