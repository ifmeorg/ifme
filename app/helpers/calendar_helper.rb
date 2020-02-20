# frozen_string_literal: true

module CalendarHelper
  def new_cal_refill_reminder_needed?(medication)
    (medication.add_to_google_cal && medication.refill &&
     (medication.add_to_google_cal_changed? || medication.refill_changed?))
      .present?
  end
end
