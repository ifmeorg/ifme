# frozen_string_literal: true

module Groups
  class MembershipsController < ApplicationController
    before_action :authenticate_user!

    # POST /groups/:group_id/membership
    def create
      @group_member = GroupMember.create!(group_member_params)
      @group = @group_member.group
      GroupNotifier.new(@group, 'new_group_member', current_user)
                   .send_notifications_to(@group.leaders)

      flash[:notice] = t('groups.join.success')
      redirect_to_group
    rescue NoMethodError
      flash[:alert] = t('groups.join.group_not_exists')
      redirect_to groups_path
    end

    # DELETE /groups/:group_id/membership/
    def destroy
      my_id = current_user.id
      @group = Group.find_by(id: params[:group_id])
      @group_member = find_group_member(my_id)
      # Cannot leave When you are the only leader
      if @group.leader_ids == [my_id]
        flash[:alert] = t('groups.leave.error')
      else
        @group_member.destroy
        flash[:notice] = notice_destroy(my_id)
      end
      redirect_to groups_path
    end

    # DELETE /groups/:group_id/membership/:member_id
    def kick
      member_id = params[:member_id]
      @group = Group.find_by(id: params[:group_id])
      @group_member = find_group_member(member_id)
      # Cannot kick if you are not a leader (hacker prevention)
      if @group.leader_ids.include?(current_user.id)
        @group_member.destroy
        flash[:notice] = notice_destroy(member_id)
      else
        flash[:alert] = t('groups.leave.remove_member_error')
      end
      redirect_to groups_path
    end

    private

    def group_member_params
      params.permit(:group_id).merge(user_id: current_user.id, leader: false)
    end

    def redirect_to_group
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.json { render :show, status: :created, location: @group }
      end
    end

    def notice_destroy(id)
      if id == current_user.id
        t('groups.leave.success', group: @group.name)
      else
        t(
          'groups.leave.remove_member_success',
          user: @group_member.user.name,
          group: @group.name
        )
      end
    end

    def find_group_member(id)
      GroupMember.find_by(
        user_id: id,
        group: @group
      )
    end
  end
end
