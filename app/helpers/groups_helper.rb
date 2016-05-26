module GroupsHelper
  def user_is_leader_of?(group)
    group.group_members.where(userid: current_user.id, leader: true).exists?
  end

  def edit_group_link(group)
    link_to t('groups.index.edit'), edit_group_path(group),
            class: 'small_margin_right'
  end

  def delete_group_link(group)
    link_to t('groups.index.delete'), group,
            method: :delete,
            data: { confirm: t('groups.index.confirm') }
  end

  def group_has_more_than_one_member?(group)
    group.group_members.count > 1
  end

  def leave_group_link(group)
    link_to t('groups.index.leave'), leave_groups_path(groupid: group.id),
            id: 'leave'
  end
end
