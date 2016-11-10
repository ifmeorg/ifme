class StrategyReminders
  def send_strategy_reminder_emails
    StrategyEmailReminder.active.each do |reminder|
      NotificationMailer.perform_strategy(reminder).deliver_now
    end
  end

  def send_weekly_reminder_emails
    ready_for_self_care.each do |reminder|
      NotificationMailer.weekly_self_care(reminder).deliver_now
    end
  end

  private

  def ready_for_self_care
    SelfcareReminder.active.joins(:strategy)
                    .where('strategies.self_care_strategy': one_week_from_now_as_string)
  end

  def one_week_from_now_as_string
    (Time.now + 1.week).strftime('%m/%d/%Y')
  end
end
