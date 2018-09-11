require 'spec_helper'

describe GroupNotifier, '#send_notifications_to' do
  let(:group) { build_stubbed :group }
  let(:type) { 'notification_type' }
  let(:user) { build_stubbed :user1 }
  let(:notifier) { GroupNotifier.new(group, type, user) }
  let(:single_recipient) { build_stubbed :user1 }

  it 'creates a notification for each recipient' do
    stub_notification_mailer

    recipients = build_stubbed_list :user1, 3
    expect(Notification).to receive(:create).exactly(3).times

    notifier.send_notifications_to(recipients)
  end

  it 'creates a notification with the correct user_id, uniqueid and data' do
    stub_notification_mailer

    expect(Notification).to receive(:create).with(
      user_id: single_recipient.id,
      uniqueid: "notification_type_#{user.id}",
      data: expected_data
    )

    notifier.send_notifications_to([single_recipient])
  end

  it 'pushes notifications' do
    stub_notification_mailer

    notifications = double('notifications')
    expect(Notification).to receive(:where)
      .with(user_id: single_recipient.id) { notifications }
    allow(notifications).to receive(:order) { notifications }
    pusher = double('pusher')
    expect(Pusher).to receive(:[])
      .with("private-#{single_recipient.id}") { pusher }
    expect(pusher).to receive(:trigger)
      .with('new_notification', notifications: notifications)

    notifier.send_notifications_to([single_recipient])
  end

  it 'sends an email notification to the recipient' do
    email = double('email')
    expect(NotificationMailer).to receive(:notification_email)
      .with(single_recipient.id, expected_data) { email }
    expect(email).to receive(:deliver_now)

    notifier.send_notifications_to([single_recipient])
  end

  def stub_notification_mailer
    notification_email = double('notification_email')
    allow(NotificationMailer).to receive(:notification_email) { notification_email }
    allow(notification_email).to receive(:deliver_now)
  end

  def expected_data
    {
      user: user.name,
      group_id: group.id,
      group: group.name,
      type: type,
      uniqueid: "#{type}_#{user.id}"
    }.to_json
  end
end
