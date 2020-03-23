# frozen_string_literal: true

module MedicationRefillHelper
  include CalendarHelper

  def save_refill_to_google_calendar(medication)
    upload_to_calendar(medication)
    true
  rescue Google::Apis::ClientError
    return_to_sign_in
    false
  rescue Google::Apis::ServerError
    redirect_to_medication(medication)
    false
  end

  private

  def upload_to_calendar(medication)
    return unless current_user.google_oauth2_enabled? &&
                  new_cal_refill_reminder_needed?(medication)

    summary = t('medications.event_summary', name: medication.name)

    CalendarUploader
      .new(current_user.google_access_token)
      .upload_event(summary, medication.refill)
  end
end
