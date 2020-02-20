# frozen_string_literal: true
describe 'ApplicationMailer' do
  describe '#load_logo_inline' do
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2) }

    subject(:email) { ReportMailer.reported_email(user1, user2) }

    it 'adds logo to email attachments' do
      email = ReportMailer.reported_email(user1, user2)
      email.deliver
      expect(email.attachments[0].filename).to eq('logo@2x.png')
    end
  end
end
