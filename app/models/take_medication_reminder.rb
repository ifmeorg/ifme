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

class TakeMedicationReminder < ActiveRecord::Base
  belongs_to :medication
  validates_inclusion_of :active, in: [true, false]
  scope :active, -> { where(active: true) }

  def name
    I18n.t('medications.daily_reminder')
  end
end
