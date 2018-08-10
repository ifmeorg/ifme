# frozen_string_literal: true

class LeaderUpdater
  def initialize(group, updated_leader_ids)
    @group = group
    @updated_leader_ids = updated_leader_ids
    @leader_ids_before_update = group.leader_ids
  end

  def update
    remove_former_leaders
    add_new_leaders

    notify_leaders(former_leader_user_ids, 'remove_group_leader')
    notify_leaders(new_leader_user_ids, 'add_group_leader')
  end

  private

  def add_new_leaders
    group_memberships_for(new_leader_user_ids)
      .update_all(leader: true)
  end

  def remove_former_leaders
    group_memberships_for(former_leader_user_ids)
      .update_all(leader: false)
  end

  def notify_leaders(user_ids, pusher_type)
    User.where(id: user_ids).each do |user|
      GroupNotifier.new(@group, pusher_type, user)
                   .send_notifications_to(@group.leaders)
    end
  end

  def group_memberships_for(user_ids)
    @group.group_members.where(user_id: user_ids)
  end

  def former_leader_user_ids
    @leader_ids_before_update - @updated_leader_ids
  end

  def new_leader_user_ids
    @updated_leader_ids - @leader_ids_before_update
  end
end
