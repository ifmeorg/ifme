# frozen_string_literal: true
describe 'BannedMailer' do
  let(:user) { create(:user) }
  let(:code_of_conduct_link) { link_to(I18n.t('navigation.code_of_conduct'), 'https://www.contributor-covenant.org/') }

  describe '#add_ban_email' do
    subject(:email) { BannedMailer.add_ban_email(user) }

    it 'sends correct email' do
      expect(email.to).to eq([user.email])
      expect(email.subject).to eq(I18n.t('notifications.mailer.add_ban_subject'))
      email.parts.each do |part|
        expect(part.body.raw_source).to include(I18n.t('add_ban_body', code_of_conduct_link: code_of_conduct_link))
      end
    end
  end

  describe '#remove_ban_email' do
    subject(:email) { BannedMailer.remove_ban_email(user) }

    it 'sends correct email' do
      expect(email.to).to eq([user.email])
      expect(email.subject).to eq(I18n.t('notifications.mailer.remove_ban_subject'))
      email.parts.each do |part|
        expect(part.body.raw_source).to include(I18n.t('remove_ban_body', code_of_conduct_link: code_of_conduct_link))
      end
    end
  end
end