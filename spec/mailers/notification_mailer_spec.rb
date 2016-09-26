require "spec_helper"

describe "NotificationMailer" do
  let(:recipient)  { FactoryGirl.create(:user1, email: "some@user.com") }
  let(:medication) { FactoryGirl.create(:medication, userid: recipient.id) }
  let(:reminder)   { FactoryGirl.create(:take_medication_reminder, medication_id: medication.id) }

  describe "#take_medication" do
    subject(:email) { NotificationMailer.take_medication(reminder) }

    it { expect(email.to).to eq(["some@user.com"]) }
    it { expect(email.subject).to eq("Don't forget to take Fancy Medication Name!") }
  end

  describe "#refill_medication" do
    subject(:email) { NotificationMailer.refill_medication(reminder) }

    it { expect(email.to).to eq(["some@user.com"]) }
    it { expect(email.subject).to eq("Your refill for Fancy Medication Name is coming up soon!") }
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
  end
end
