module GroupsHelper
  def user_is_leader_of?(group)
    group.group_members.where(userid: current_user.id, leader: true).exists?
  end

  def edit_group_link(group)
    link_to t('groups.index.edit'), edit_group_path(group),
            class: 'small_margin_right'
  end

  def delete_group_link(group, attrs = {})
    link_to t('.delete'), group,
            { method: :delete,
              data: { confirm: t('.confirm') }
            }.merge(attrs)
  end

  def leave_group_link(group, attrs = {})
    link_to t('.leave'), leave_groups_path(groupid: group.id),
            { id: 'leave' }.merge(attrs)
  end

  def join_group_link(group, attrs = {})
    link_to t('.join'), join_groups_path(groupid: group.id),
            { id: 'join' }.merge(attrs)
  end

  def render_group_member_partial(members)
    render partial: '/notifications/members',
           locals: { data: members }
  end
end
