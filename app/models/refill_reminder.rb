# frozen_string_literal: true

# == Schema Information
#
# Table name: refill_reminders
#
#  id            :integer          not null, primary key
#  medication_id :integer          not null
#  active        :boolean          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class RefillReminder < ApplicationRecord
  belongs_to :medication
  validates :active, inclusion: { in: [true, false] }
  scope :active, -> { where(active: true) }

  def name
    I18n.t('medications.refill_reminder')
  end
end
