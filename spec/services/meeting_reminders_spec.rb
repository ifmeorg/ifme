require 'spec_helper'

describe MeetingReminders do
  subject { described_class.new }

  describe '#send_meeting_reminder_emails' do
    let(:mail) { instance_double(ActionMailer::MessageDelivery) }
    let!(:member_one) { FactoryBot.create(:meeting_member, meeting: meeting) }
    let!(:member_two) { FactoryBot.create(:meeting_member, meeting: meeting) }
    let(:meeting) do
      FactoryBot.create(
        :meeting,
        maxmembers: 0,
        date: date
      )
    end

    before do
      allow(NotificationMailer).to receive(:meeting_reminder).and_return(mail)
    end

    context 'when there are no meetings occurring tomorrow' do
      let(:date) { 2.days.from_now.strftime('%m/%d/%Y') }

      before do
        subject.send_meeting_reminder_emails
      end

      it 'does not send any notification emails' do
        expect(NotificationMailer).to_not have_received(:meeting_reminder)
      end
    end

    context 'when there is a meeting occurring tomorrow' do
      let(:date) { 1.days.from_now.strftime('%m/%d/%Y') }

      before do
        allow(mail).to receive(:deliver_now)
        subject.send_meeting_reminder_emails
      end

      it 'sends a notification email to each member' do
        expect(NotificationMailer)
          .to have_received(:meeting_reminder)
          .with(meeting, member_one.user)

        expect(NotificationMailer)
          .to have_received(:meeting_reminder)
          .with(meeting, member_two.user)

        expect(mail).to have_received(:deliver_now).twice
      end
    end
  end
end
