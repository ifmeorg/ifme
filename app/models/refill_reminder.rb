class RefillReminder < ActiveRecord::Base
  belongs_to :medication
  validates_inclusion_of :active, in: [true, false]
  scope :active, -> { where(active: true) }

  def name
    I18n.t('medications.refill_reminder')
  end
end
