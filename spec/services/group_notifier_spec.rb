# frozen_string_literal: true

describe GroupNotifier do
  let(:current_user) { build(:user) }
  let(:group) { build(:group) }
  let(:type) { 'notifier' }
  let(:recipient) { build(:user) }
  let(:recipients) { [recipient] }
  let(:new_notifications) { [build(:notification)] }
  let(:client) { double('client') }
  let(:mailer) { double('mailer') }
  let(:data) do
    {
      user: current_user.name,
      user_id: current_user.id,
      group_id: group.id,
      group: group.name,
      type: type,
      uniqueid: "notifier_#{current_user.id}"
    }.to_json
  end
  subject { GroupNotifier.new(group, type, current_user) }

  after do
    subject.send_notifications_to(recipients)
  end

  it 'creates push notifications' do
    allow(subject).to receive(:create_notification)
    allow(subject).to receive(:send_email_notification)
    allow(Notification).to receive_message_chain(:where, :order).and_return(new_notifications)
    allow(Pusher).to receive(:[]).with("private-#{recipient.id}").and_return(client)
    expect(client).to receive(:trigger).with('new_notification', notifications: new_notifications)
  end

  it 'sends email notifications' do
    allow(subject).to receive(:push_notifications)
    allow(subject).to receive(:create_notification)
    expect(NotificationMailer).to receive(:notification_email).with(recipient.id, data).and_return(mailer)
    expect(mailer).to receive(:deliver_now)
  end

  it 'creates notifications' do
    allow(subject).to receive(:push_notifications)
    allow(subject).to receive(:send_email_notification)
    expect(Notification).to receive(:create).with(user_id: recipient.id, uniqueid: "notifier_#{current_user.id}", data: data)
  end
end
