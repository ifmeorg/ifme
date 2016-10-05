require 'spec_helper'

describe MeetingReminders do
  subject { described_class.new }

  describe '#send_meeting_reminder_emails' do
    let(:mail) { instance_double(ActionMailer::MessageDelivery) }
    let!(:member_one) { FactoryGirl.create(:meeting_member, meeting: meeting) }
    let!(:member_two) { FactoryGirl.create(:meeting_member, meeting: meeting) }
    let(:meeting) do 
      FactoryGirl.create(
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
        expect(mail).to receive(:deliver_now).twice
        subject.send_meeting_reminder_emails
      end

      it 'sends a notification email to each member' do
        expect(NotificationMailer)
          .to have_received(:meeting_reminder)
          .with(meeting: meeting, member: member_one.user)
        expect(NotificationMailer)
          .to have_received(:meeting_reminder)
          .with(meeting: meeting, member: member_two.user)
      end
    end
  end
end
