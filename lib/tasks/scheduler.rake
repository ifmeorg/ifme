namespace :scheduler do
  desc 'Send taking medication reminders'
  task send_take_medication_reminders: :environment do
    MedicationReminders.new.send_take_medication_reminder_emails
  end

  desc 'Send refill reminders'
  task send_refill_reminders: :environment do
    MedicationReminders.new.send_refill_reminder_emails
  end

  desc 'Send strategy library reminders'
  task send_startegy_reminder_emails: :environment do
    PerformStrategyReminders.new.send_startegy_reminder_emails
  end

  desc 'Self-care reminders'
  task send_self_care_strategy_emails: :environment do
    PerformStrategyReminders.new.send_self_care_strategy_emails
  end

  desc 'Send meeting reminders'
  task send_meeting_reminders: :environment do
    MeetingReminders.new.send_meeting_reminder_emails
  end
end
