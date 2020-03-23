# frozen_string_literal: true

require 'spec_helper'

describe AllyNotifications::AcceptedAllyRequest do
  let(:recipient) { FactoryBot.create(:user1, email: 'some@user.com') }
  let(:ally)      { FactoryBot.create(:user2) }
  let(:data) do
    ActiveSupport::HashWithIndifferentAccess.new(
      'user' => ally.name,
      'user_id' => ally.id,
      'uid' => ally.uid,
      'type' => 'accepted_ally_request',
      'uniqueid' => 'some_unique_id'
    )
  end

  subject(:notification) { described_class.new(recipient, data) }

  it { expect(notification.subject).to eq("if me | #{ally.name} accepted your ally request!") }
  it { expect(notification.message).to eq("<p>Congrats! You can now share Moments, Strategies, and more with #{ally.name}.</p>") }
  it { expect(notification.to).to eq(recipient.email) }
end
