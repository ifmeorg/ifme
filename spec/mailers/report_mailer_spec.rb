# frozen_string_literal: true
describe 'ReportMailer' do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  describe '#reported_email' do
    subject(:email) { ReportMailer.reported_email(user1, user2) }

    it 'sends correct email' do
      expect(email.to).to eq([user1.email])
      expect(email.subject).to eq(I18n.t('notifications.mailer.reported_user_subject'))
      expect(email.parts[0].body.raw_source).to include(I18n.t('notifications.mailer.reported_user_body', reported_name: user2.name))
    end
  end

  describe '#reportee_email' do
    subject(:email) { ReportMailer.reportee_email(user1) }

    it 'sends correct email' do
      expect(email.to).to eq([user1.email])
      expect(email.subject).to eq(I18n.t('notifications.mailer.reportee_user_subject'))
      expect(email.parts[0].body.raw_source).to include(I18n.t('notifications.mailer.reportee_user_body'))
    end
  end
end
