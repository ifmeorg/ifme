# frozen_string_literal: true

module Notifications
  extend ActiveSupport::Concern

  included do
    helper_method :notifications_for_members
  end

  # rubocop:disable MethodLength
  def notifications_for_members(members, type)
    uniqueid = "#{type}_#{current_user.id}"
    members.each do |member|
      next if member.user_id == current_user.id
      data = notification_data(type, uniqueid)
      Notification.create(
        user_id: member.user_id,
        uniqueid: uniqueid,
        data: data
      )
      notifications = Notification.where(user_id: member.user_id)
                                  .order('created_at ASC').all
      Pusher["private-#{member.user_id}"].trigger(
        'new_notification',
        notifications: notifications
      )
      NotificationMailer.notification_email(member.user_id, data).deliver_now
    end
  end

  private

  def notification_data(type, uniqueid)
    group = Group.where(id: @meeting.group_id).first.name
    if type == 'remove_meeting'
      return JSON.generate(
        user: current_user.name,
        group_id: @meeting.group_id,
        group: group,
        typename: @meeting.name,
        type: type,
        uniqueid: uniqueid
      )
    end
    JSON.generate(
      user: current_user.name,
      typeid: @meeting.id,
      group: group,
      typename: @meeting.name,
      type: type,
      uniqueid: uniqueid
    )
  end
  # rubocop:enable MethodLength
end
