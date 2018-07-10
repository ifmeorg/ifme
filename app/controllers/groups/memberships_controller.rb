# frozen_string_literal: true

module Groups
  class MembershipsController < ApplicationController
    # POST /groups/memberships
    def create
      @group_member = GroupMember.create!(group_member_params)
      @group = @group_member.group
      GroupNotifier.new(@group, 'new_group_member', current_user)
                   .send_notifications_to(@group.leaders)

      flash[:notice] = t('groups.join_success')
      redirect_to_group
    end

    # DELETE /groups/membership/1
    # rubocop:disable MethodLength
    def destroy
      member_id = params[:memberid] || current_user.id
      group_member = GroupMember.find_by(
        userid: member_id,
        groupid: params[:groupid]
      )
      group = group_member.group

      # Cannot leave When you are the only leader
      if group.leader_ids == [member_id]
        flash[:alert] = t('groups.leave.error')
      else
        group_member.destroy
        flash[:notice] = if member_id == current_user.id
                           t('groups.leave.success', group: group.name)
                         else
                           t(
                             'groups.leave.remove_member_success',
                             user: group_member.user.name,
                             group: group.name
                           )
                         end
      end
      redirect_to groups_path
    end
    # rubocop:enable MethodLength

    private

    def group_member_params
      params.permit(:groupid).merge(userid: current_user.id, leader: false)
    end

    def redirect_to_group
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.json { render :show, status: :created, location: @group }
      end
    end
  end
end
