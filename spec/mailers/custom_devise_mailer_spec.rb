# frozen_string_literal: true

require 'spec_helper'

describe CustomDeviseMailer do
  let(:inviter) { create(:user2) }
  let(:recipient) { '123@abc.com' }
  let(:key) { 'invitation_instructions' }
  let(:email) { Devise.mailer.deliveries.last }

  describe 'subject_for' do
    context 'if the inviting user has a name' do
      it 'includes the inviter\'s name in the subject' do
        User.invite!({ email: recipient }, inviter)
        expect(email.subject).to eq("#{inviter.name} invited you to join if-me.org!")
      end

      it 'adds logo to email attachments' do
        User.invite!({ email: recipient }, inviter)
        email.deliver
        expect(email.attachments[0].filename).to eq('logo@2x.png')
      end
    end

    context 'if the inviting user does not have a name' do
      it 'uses "Someone" in place of the inviter\'s name' do
        User.invite!(email: recipient)
        expect(email.subject).to eq('Someone invited you to join if-me.org!')
      end

      it 'adds logo to email attachments' do
        User.invite!(email: recipient)
        email.deliver
        expect(email.attachments[0].filename).to eq('logo@2x.png')
      end
    end
  end
end
