require "spec_helper"

describe "NotificationMailer" do
  describe "#take_medication" do
    let(:recipient) { FactoryGirl.create(:user1, email: "some@user.com") }
    let!(:medication) { FactoryGirl.create(:medication, userid: recipient.id) }
    let!(:reminder) { FactoryGirl.create(:take_medication_reminder, medication_id: medication.id) }
    let(:mail) { NotificationMailer.take_medication(reminder) }

    it "sends a reminder to a user" do
      expect(mail.to).to eq(["some@user.com"])
      expect(mail.subject).to eq("Don't forget to take Fancy Medication Name!")
    end
  end

  describe "#refill_medication" do
    let(:recipient) { FactoryGirl.create(:user1, email: "some@user.com") }
    let!(:medication) { FactoryGirl.create(:medication, userid: recipient.id) }
    let!(:reminder) { FactoryGirl.create(:take_medication_reminder, medication_id: medication.id) }
    let(:mail) { NotificationMailer.refill_medication(reminder) }

    it "sends a reminder to a user" do
      expect(mail.to).to eq(["some@user.com"])
      expect(mail.subject).to eq("Your refill for Fancy Medication Name is coming up soon!")
    end
  end
end
