# frozen_string_literal: true

class StrategyReminders
  def send_perform_strategy_reminder_emails
    PerformStrategyReminder.active.each do |reminder|
      NotificationMailer.perform_strategy(reminder).deliver_now
    end
  end
end
