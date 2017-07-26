# frozen_string_literal: true

module MedicationRefillHelper
  # Save refill date to Google calendar
  def save_refill_to_google_calendar(medication)
    return true unless current_user.google_oauth2_enabled? &&
                       medication.add_to_google_cal == '1'
    begin
      args = calendar_uploader_params(medication)
      CalendarUploader.new(args).upload_event
    rescue
      return_to_sign_in
    else
      true
    end
  end

  def calendar_uploader_params(medication)
    { summary: "Refill for #{medication.name}",
      date: medication.refill,
      access_token: current_user.google_access_token,
      email: current_user.email }
  end
end
