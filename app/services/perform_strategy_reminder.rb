class PerformStrategyReminders
  def send_strategy_reminder_emails
    StrategyReminder.active.each do |reminder|
      NotificationMailer.perform_strategy(reminder).deliver_now
    end
  end

  def send_strategy_reminders_emails
    ready_for_strategy_reminders.each do |reminder|
      NotificationMailer.strategy_reminders(reminder).deliver_now
    end
  end

  private

  def ready_for_strategy_reminders
    StrategyCalendarReminder.active.joins(:strategy).where(
      'strategies.strategy_reminders': one_week_from_now_as_string
    )
  end

  def one_week_from_now_as_string
    (Time.now + 1.week).strftime('%m/%d/%Y')
  end
end
