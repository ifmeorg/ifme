# frozen_string_literal: true

module ApplicationMailerHelper
  GROUP = %w[
    new_group new_group_member add_group_leader remove_group_leader
  ].freeze
  MEETING = %w[new_meeting remove_meeting update_meeting join_meeting].freeze

  def can_notify(user, notify_type)
    return user.comment_notify.nil? if notify_type == 'comment_notify'
    return user.ally_notify.nil? if notify_type == 'ally_notify'
    return user.group_notify.nil? if notify_type == 'group_notify'
    return user.meeting_notify.nil? if notify_type == 'meeting_notify'

    false
  end

  def create_notifier
    notification_dictionary[@data[:type]].new(@recipient, @data)
  end

  def notification_dictionary
    {
      'new_ally_request' => AllyNotifications::NewAllyRequest,
      'accepted_ally_request' => AllyNotifications::AcceptedAllyRequest
    }
  end

  def comment_on_moment(data)
    data['type'] == 'comment_on_moment'
  end

  def comment_on_moment_private(data)
    data['type'] == 'comment_on_moment_private'
  end

  def comment_on_strategy(data)
    data['type'] == 'comment_on_strategy'
  end

  def comment_on_strategy_private(data)
    data['type'] == 'comment_on_strategy_private'
  end

  def comment_on_meeting(data)
    data['type'] == 'comment_on_meeting'
  end

  def can_comment(data)
    comment_on_moment(data) ||
      comment_on_moment_private(data) ||
      comment_on_strategy(data) ||
      comment_on_strategy_private(data) ||
      comment_on_meeting(data)
  end

  def can_group(data)
    GROUP.include? data['type']
  end

  def can_meeting(data)
    MEETING.include? data['type']
  end

  def you?(recipient, data)
    recipient.name == data['user']
  end
end
