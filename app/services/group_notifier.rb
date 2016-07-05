class GroupNotifier
  def initialize(group, type, current_user)
    @group = group
    @type = type
    @current_user = current_user
  end

  def send_notifications_to(recipients)
    recipients.each do |recipient|
      create_notification(recipient)
      push_notifications(recipient)
      send_email_notification(recipient)
    end
  end

  private

  def send_email_notification(recipient)
    NotificationMailer.notification_email(recipient.id, data).deliver_now
  end

  def push_notifications(recipient)
    notifications = Notification.where(userid: recipient.id)
                                .order('created_at ASC')
    Pusher["private-#{recipient.id}"]
      .trigger('new_notification', notifications: notifications)
  end

  def create_notification(recipient)
    Notification.create(
      userid: recipient.id,
      uniqueid: uniqueid,
      data: data
    )
  end

  def data
    JSON.generate(
      user: @current_user.name,
      groupid: @group.id,
      group: @group.name,
      type: @type,
      uniqueid: uniqueid
    )
  end

  def uniqueid
    "#{@type}_#{@current_user.id}"
  end
end
