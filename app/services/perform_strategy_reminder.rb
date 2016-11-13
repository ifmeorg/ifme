class PerformStrategyReminders
  def send_startegy_reminder_emails
    StrategyReminder.active.each do |reminder|
      NotificationMailer.perform_strategy(reminder).deliver_now
    end
  end

  def send_self_care_strategy_emails
    ready_for_self_care.each do |reminder|
      NotificationMailer.self_care_strategy(reminder).deliver_now
    end
  end

  private

  def ready_for_self_care
    SelfCareStrategyReminder.active.joins(:strategy).where(
      'strategies.self_care_strategy': one_week_from_now_as_string
    )
  end

  def one_week_from_now_as_string
    (Time.now + 1.week).strftime('%m/%d/%Y')
  end
end
