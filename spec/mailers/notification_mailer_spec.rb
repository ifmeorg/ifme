require "spec_helper"

describe "NotificationMailer" do
  let(:recipient)  { FactoryGirl.create(:user1, email: "some@user.com") }
  let(:medication) { FactoryGirl.create(:medication, :with_daily_reminder, userid: recipient.id) }
  let(:reminder)   { medication.take_medication_reminder }
  let(:strategy) { FactoryGirl.create(:strategy, :with_daily_reminder, userid: recipient.id) }
  let(:reminder)   { medication.take_medication_reminder }
  let(:strategy_reminder)   { strategy.strategy_reminder }
  let(:take_medication_text) { I18n.t('mailers.notification_mailer.medication_subject', name: medication.name) }
  let(:refill_medication_text) { I18n.t('mailers.notification_mailer.refill_subject', name: medication.name) }
  let(:perform_strategy_text) { I18n.t('mailers.notification_mailer.strategy_subject', name: strategy.name) }
  let(:self_care_text) { I18n.t('mailers.notification_mailer.selfcare_subject', name: strategy.name) }

  describe "#take_medication" do
    subject(:email) { NotificationMailer.take_medication(reminder) }

    it { expect(email.to).to eq(["some@user.com"]) }
    it { expect(email.subject).to eq take_medication_text }
  end

  describe "#refill_medication" do
    subject(:email) { NotificationMailer.refill_medication(reminder) }

    it { expect(email.to).to eq(["some@user.com"]) }
    it { expect(email.subject).to eq refill_medication_text }
  end

  describe "#perform_strategy" do
    subject(:email) { NotificationMailer.perform_strategy(strategy_reminder) }

    it { expect(email.to).to eq(["some@user.com"]) }
    it { expect(email.subject).to eq perform_strategy_text }
  end

  describe "#self_care_strategy" do
    subject(:email) { NotificationMailer.self_care_strategy(strategy_reminder) }

    it { expect(email.to).to eq(["some@user.com"]) }
    it { expect(email.subject).to eq self_care_text }
  end

  describe '#meeting_reminder' do
    let(:member) { FactoryGirl.create(:meeting_member, meeting: meeting).user }
    let(:meeting) { FactoryGirl.create(:meeting) }

    subject(:email) { NotificationMailer.meeting_reminder(meeting, member) }

    it 'sends the email to the correct recipient' do
      expect(email.to).to eq([member.email])
    end

    it 'has the correct subject' do
      expected_subject = I18n.t(
        'meetings.reminder_mailer.subject',
        meeting_name: meeting.name,
        time: meeting.time
      )

      expect(email.subject).to eq(expected_subject)
    end

    it 'is addressed to the correct person' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(member.name)
      end
    end

    it 'includes the meeting location' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(meeting.location)
      end
    end

    it 'includes the meeting time' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(meeting.time)
      end
    end

    it 'includes the meeting name' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(meeting.name)
      end
    end
  end

  describe 'notification' do
    let(:who_triggered_event) { FactoryGirl.create(:user2) }

    let(:data) do
      JSON.generate(user: who_triggered_event.name,
                    userid: who_triggered_event.id,
                    uid: who_triggered_event.uid,
                    type: type,
                    uniqueid: 'some_unique_id')
    end

    context 'when type is accepted_ally_request' do
      let(:type) { 'accepted_ally_request' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} accepted your ally request!") }
      it { expect(email.body.encoded).to match("<p>Congrats! You can now share Moments, Strategies, and more with #{who_triggered_event.name}.</p>") }
    end

    context 'when type is new_ally_request' do
      let(:type) { 'new_ally_request' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} sent an ally request!") }
      it { expect(email.body.encoded).to match("<p>Please <a href=\"http://localhost:3000/allies\">sign in</a> to accept or reject the request!</p>") }
    end

    describe 'when type is comment on moment' do
      let(:moment_desc) { 'some_moment_description' }
      let(:phrase_ally) { "<p>Your ally <strong>#{who_triggered_event.name}" }
      let(:comment)     { "</strong> commented:</p><p><i>my_comment</i></p>" }
      let(:link) do
        "<p>You can read it all <a href=\"http://localhost:3000/moments/1\">here</a>!</p>"
      end

      let(:data) do
        JSON.generate({
          user: who_triggered_event.name,
          momentid: 1,
          moment: moment_desc,
          commentid: 2,
          comment: 'my_comment',
          cutoff: false,
          type: 'comment_on_moment',
          uniqueid: 'some_unique_id'
        })
      end

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} commented on your moment \"#{moment_desc}\"") }
      it { expect(email.body.encoded).to match(phrase_ally) }
      it { expect(email.body.encoded).to match(comment) }
      it { expect(email.body.encoded).to match(link) }
    end
  end
end
