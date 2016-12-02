require "spec_helper"

describe StrategyReminders do
  let(:deliveries) { ActionMailer::Base.deliveries }

  before { ActionMailer::Base.deliveries = [] }

  describe "#send_perform_strategy_reminder_emails" do
    context "no reminders" do
      it "sends no emails" do
        StrategyReminders.new.send_perform_strategy_reminder_emails
        expect(deliveries.count).to eq(0)
      end
    end

    context "reminders exist" do
      let!(:user) { FactoryGirl.create(:user1) }
      let!(:strategy) { FactoryGirl.create(:strategy, :with_daily_reminder, userid: user.id) }
      let!(:reminder) { strategy.perform_strategy_reminder }

      context "perform strategy reminder is active" do
        it "sends an email" do
          StrategyReminders.new.send_perform_strategy_reminder_emails
          expect(deliveries.count).to eq(1)
        end
      end

      context "perform strategy reminder is not active" do
        it "doesn't send an email" do
          reminder.update(active: false)
          StrategyReminders.new.send_perform_strategy_reminder_emails
          expect(deliveries.count).to eq(0)
        end
      end
    end
  end
end
