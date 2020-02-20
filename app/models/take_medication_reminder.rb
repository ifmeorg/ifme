# frozen_string_literal: true

# == Schema Information
#
# Table name: take_medication_reminders
#
#  id            :integer          not null, primary key
#  medication_id :integer          not null
#  active        :boolean          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class TakeMedicationReminder < ApplicationRecord
  belongs_to :medication
  validates :active, inclusion: { in: [true, false] }
  scope :active, -> { where(active: true) }
  scope :for_day, lambda { |day = Time.current.wday|
    joins(:medication).where('? = any(medications.weekly_dosage)', day)
  }

  def name
    I18n.t('common.daily_reminder')
  end
end
