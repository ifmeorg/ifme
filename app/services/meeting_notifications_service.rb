# frozen_string_literal: true

class MeetingNotificationsService
  attr_reader :current_user
  attr_reader :meeting
  attr_reader :type
  attr_reader :members
  attr_reader :uniqueid

  def initialize(current_user:, meeting:, type:, members:)
    @current_user = current_user
    @meeting = meeting
    @type = type
    @members = members
    @uniqueid = "#{type}_#{current_user.id}"
  end

  def self.handle_members(args = {})
    new(args).handle_members
  end

  # rubocop:disable MethodLength
  def handle_members
    members.each do |member|
      next if member.user_id == current_user.id
      data = notification_data
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

  def notification_data
    group = Group.where(id: meeting.group_id).first.name
    if type == 'remove_meeting'
      return {
        user: current_user.name,
        group_id: meeting.group_id,
        group: group,
        typename: meeting.name,
        type: type,
        uniqueid: uniqueid
      }.to_json
    end
    {
      user: current_user.name,
      typeid: meeting.id,
      group: group,
      typename: meeting.name,
      type: type,
      uniqueid: uniqueid
    }.to_json
  end
  # rubocop:enable MethodLength
end
