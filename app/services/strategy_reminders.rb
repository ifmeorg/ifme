class StrategyReminders
  def send_strategy_reminder_emails
    TakeStrategyReminder.active.each do | reminder |
      NotificationMailer.perform_strategy(reminder).deliver_now
    end
  end

  def send_weekly_reminder_emails
    ready_for_self_care.each do | reminder |
      NotificationMailer.weekly_self_care(reminder).deliver_now
    end
  end

  private

  def ready_for_self_care
    RefillReminder.active.joins(:strategy).where('strategies.self_care_strategy': one_week_from_now_as_string)
  end

  #Strategy Refill dates are currently stored as strings in the database
  #instead of timestamps. If we want to do more complicated reminders, we
  #should migrate the data to timestamps.
  def one_week_from_now_as_string
    (Time.now + 1.week).strftime('%m/%d/%Y')
  end
end
