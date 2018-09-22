# frozen_string_literal: true

module MedicationRefillHelper
  include CalendarHelper
  # Save refill date to Google calendar
  # rubocop:disable RescueStandardError
  def save_refill_to_google_calendar(medication)
    return true unless current_user.google_oauth2_enabled? &&
                       new_cal_refill_reminder_needed?(medication)

    begin
      args = calendar_uploader_params(medication)
      CalendarUploader.new(args).upload_event
    rescue
      return_to_sign_in
    else
      true
    end
  end
  # rubocop:enable RescueStandardError

  def calendar_uploader_params(medication)
    { summary: "Refill for #{medication.name}",
      date: medication.refill,
      access_token: current_user.google_access_token,
      email: current_user.email }
  end
end
