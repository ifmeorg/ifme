# frozen_string_literal: true

require 'spec_helper'

describe AllyNotifications::NewAllyRequest do
  let(:recipient)  { FactoryBot.create(:user1, email: 'some@user.com') }
  let(:ally)       { FactoryBot.create(:user2) }
  let(:allies_url) { 'http://localhost:3000/allies' }

  let(:data) do
    ActiveSupport::HashWithIndifferentAccess.new(
      'user' => ally.name,
      'user_id' => ally.id,
      'uid' => ally.uid,
      'type' => 'new_ally_request',
      'uniqueid' => 'some_unique_id'
    )
  end

  subject(:notification) { described_class.new(recipient, data) }

  it { expect(notification.to).to eq(recipient.email) }
  it { expect(notification.subject).to eq("if me | #{ally.name} sent an ally request!") }
  it { expect(notification.message).to eq('<p>Please <a href="http://localhost:3000/allies">sign in</a> to accept or reject the request!</p>') }
end
