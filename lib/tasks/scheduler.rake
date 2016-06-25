namespace :scheduler do
  desc "Send taking medication reminders"
  task send_take_medication_reminders: :environment do
    MedicationReminders.new.send_take_medication_reminder_emails
  end

  desc "Send refill reminders"
  task send_refill_reminders: :environment do
    MedicationReminders.new.send_refill_reminder_emails
  end
end
