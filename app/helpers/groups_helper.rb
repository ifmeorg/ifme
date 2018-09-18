# frozen_string_literal: true

module GroupsHelper
  include FormHelper

  def user_is_leader_of?(object)
    # object can be either group or meeting
    object.leaders.include? current_user
  end

  def user_can_edit?(group)
    user_is_leader_of?(group)
  end

  def user_can_leave?(group)
    !user_is_leader_of?(group) || group.group_members.count > 1
  end

  def user_can_delete?(group)
    user_is_leader_of?(group) && group.group_members.count == 1
  end

  def edit_group_link(group)
    link_to t('common.actions.edit'), edit_group_path(group),
            class: 'small_margin_right'
  end

  def leader_link(leader)
    name = leader == current_user ? t('common.you') : leader.name
    link_to name, profile_index_path(uid: leader.uid)
  end

  def delete_group_link(group, attrs = {})
    link_to t('common.actions.delete'), group,
            {
              method: :delete,
              data: { confirm: t('common.actions.confirm') }
            }.merge(attrs)
  end

  def kick_member_link(group, member, attrs = {})
    link_to t('common.actions.remove'),
            kick_group_membership_path(
              group_id: group.id,
              member_id: member.id
            ),
            {
              class: 'kick',
              method: :delete
            }.merge(attrs)
  end

  def leave_group_link(group, attrs = {})
    link_to t('common.actions.leave'),
            group_membership_path(group_id: group.id),
            {
              id: 'leave',
              method: :delete
            }.merge(attrs)
  end

  def join_group_link(group, attrs = {})
    link_to t('common.actions.join'),
            group_membership_path(group_id: group.id),
            {
              id: 'join',
              method: :post
            }.merge(attrs)
  end

  def edit_meeting_link(meeting, html_options = {})
    return unless user_is_leader_of? meeting
    link_to edit_meeting_path(meeting), html_options do
      raw '<i class="fa fa-pencil-alt"></i>'
    end
  end

  def new_group_props
    new_form_props(group_form_inputs, groups_path)
  end

  def edit_group_props
    edit_form_props(group_form_inputs, group_path(@group))
  end

  private

  def group_form_inputs
    edit_inputs || common_inputs
  end

  def common_inputs
    [
      {
        id: 'group_name',
        type: 'text',
        name: 'group[name]',
        label: t('common.name'),
        value: @group.name || nil,
        required: true,
        dark: true
      },
      {
        id: 'group_description',
        type: 'textarea',
        name: 'group[description]',
        label: t('common.form.description'),
        value: @group.description || nil,
        required: true,
        dark: true
      }
    ]
  end

  def edit_inputs
    inputs = nil
    if action_name == 'edit' || action_name == 'update'
      inputs = common_inputs
      checkboxes = []
      @group.group_members.each do |member|
        checkboxes.push(
          id: "group_leader_#{member.user_id}",
          name: 'group[leader][]',
          value: member.user_id,
          checked: member.leader,
          label: link_to(member.user.name, profile_index_path(uid: get_uid(member.user_id)))
        )
      end
      inputs.push(
        id: 'group_leader',
        name: 'group[leader]',
        type: 'checkboxGroup',
        checkboxes: checkboxes,
        label: t('groups.form.leaders'),
        dark: true,
        required: true
      )
    end
  end
end
