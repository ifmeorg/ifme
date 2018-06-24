require 'spec_helper'

describe Allyships::AllianceNotifier do
  describe '#perform' do
    subject { described_class.perform }
    let(:instantiated_object) { described_class.new }

    it 'calls .perform' do
      allow(described_class).to receive(:new).and_return(instantiated_object)

      expect(instantiated_object).to receive(:perform)

      subject
    end
  end

  describe '.perform' do
    subject { described_class.perform(params) }

    let(:params) do
      {
        ally_id: ally.id,
        current_user: user,
        pusher_type: pusher_type
      }
    end
    let(:user) { create :user }
    let(:ally) { create :user }
    let(:pusher_type) do
      'new_ally_request'
    end
    let(:notifications) do
      {
        notifications: Notification.where(userid: ally.id).order(:created_at)
      }
    end

    it 'creates the notification' do
      expect { subject }.to change(Notification, :count).by(1)
    end

    it 'triggers Pusher' do
      mock_client = double('client')
      Pusher.stub(:[]).with("private-#{ally.id}").and_return(mock_client)

      expect(mock_client).to receive(:trigger)
        .with('new_notification', notifications)
        .once

      subject
    end
  end
end
