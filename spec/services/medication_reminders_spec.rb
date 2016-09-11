require "spec_helper"

describe MedicationReminders do
  let(:deliveries) { ActionMailer::Base.deliveries }

  before { ActionMailer::Base.deliveries = [] }

  describe "#send_take_medication_reminder_emails" do
    context "no reminders" do
      it "sends no emails" do
        MedicationReminders.new.send_take_medication_reminder_emails
        expect(deliveries.count).to eq(0)
      end
    end

    context "reminders exist" do
      let!(:user) { FactoryGirl.create(:user1) }
      let!(:medication) { FactoryGirl.create(:medication, userid: user.id) }
      let!(:reminder) { FactoryGirl.create(:take_medication_reminder, medication_id: medication.id) }

      context "take medication reminder is active" do
        it "sends an email" do
          MedicationReminders.new.send_take_medication_reminder_emails
          expect(deliveries.count).to eq(1)
        end
      end

      context "take medication reminder is not active" do
        it "doesn't send an email" do
          reminder.update(active: false)
          MedicationReminders.new.send_take_medication_reminder_emails
          expect(deliveries.count).to eq(0)
        end
      end
    end
  end

  describe "#send_refill_reminder_emails" do
    context "no reminders" do
      it "sends no emails" do
        MedicationReminders.new.send_refill_reminder_emails
        expect(deliveries.count).to eq(0)
      end
    end

    context "reminders exist and it is one week before the refill" do
      let!(:user) { FactoryGirl.create(:user1) }
      let(:refill_date) { '01/01/2010' }
      let!(:medication) { FactoryGirl.create(:medication, userid: user.id, refill: refill_date) }
      let!(:reminder) { FactoryGirl.create(:refill_reminder, medication_id: medication.id) }

      before "pretend its a week before the refill is happening" do
        allow(Time).to receive(:now).and_return(Time.strptime(refill_date, '%m/%d/%Y') - 1.week)
      end

      context "refill reminder is active " do
        it "sends an email" do
          MedicationReminders.new.send_refill_reminder_emails
          expect(deliveries.count).to eq(1)
        end
      end

      context "refill reminder is not active" do
        it "doesn't send an email" do
          reminder.update(active: false)
          MedicationReminders.new.send_refill_reminder_emails
          expect(deliveries.count).to eq(0)
        end
      end
    end
  end

end
