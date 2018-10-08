# frozen_string_literal: true

module MedicationRefillHelper
  include CalendarHelper
  # Save refill date to Google calendar
  def save_refill_to_google_calendar(medication)
    return true unless current_user.google_oauth2_enabled? &&
                       new_cal_refill_reminder_needed?(medication)

    args = calendar_uploader_params(medication)
    CalendarUploader.new(args).upload_event
    true
  rescue Google::Apis::ClientError
    return_to_sign_in
  rescue Google::Apis::ServerError
    CalendarUploader.new(args).upload_event
  end

  def calendar_uploader_params(medication)
    { summary: "Refill for #{medication.name}",
      date: medication.refill,
      access_token: current_user.google_access_token,
      email: current_user.email }
  end
end
