# frozen_string_literal: true

class MedicationReminders
  def send_take_medication_reminder_emails
    TakeMedicationReminder.active.for_day.each do |reminder|
      NotificationMailer.take_medication(reminder).deliver_now
    end
  end

  def send_refill_reminder_emails
    ready_for_refill.each do |reminder|
      NotificationMailer.refill_medication(reminder).deliver_now
    end
  end

  private

  def ready_for_refill
    RefillReminder.active
                  .joins(:medication)
                  .where('medications.refill': one_week_from_now_as_string)
  end

  def one_week_from_now_as_string
    (Time.current + 1.week).strftime('%m/%d/%Y')
  end
end
