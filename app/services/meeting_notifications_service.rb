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

  def handle_members
    members.each do |member|
      next if member.id == current_user.id

      send_member_notification(member, notification_data)
    end
  end

  private

  def get_notifications(member, data)
    Notification.create!(
      user_id: member.id,
      uniqueid: uniqueid,
      data: data
    )
    Notification.where(user_id: member.id)
                .order('created_at ASC').all
  end

  def send_member_notification(member, data)
    Pusher["private-#{member.id}"].trigger(
      'new_notification',
      notifications: get_notifications(member, data)
    )
    NotificationMailer.notification_email(member.id, data).deliver_now
  end

  def remove_meeting_data
    {
      user: current_user.name,
      group_id: meeting.group_id,
      group: meeting.group.name,
      typename: meeting.name,
      type: type,
      uniqueid: uniqueid
    }.to_json
  end

  def new_or_update_meeting_data
    {
      user: current_user.name,
      typeid: meeting.id,
      group: meeting.group.name,
      typename: meeting.name,
      type: type,
      uniqueid: uniqueid
    }.to_json
  end

  def notification_data
    return remove_meeting_data if type == 'remove_meeting'
    return unless %w[update_meeting new_meeting].include?(type)

    new_or_update_meeting_data
  end
end
