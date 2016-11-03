class RefillReminder < ActiveRecord::Base
  belongs_to :medication
  belongs_to :strategy, foreign_key: :strategy_id
  validates_inclusion_of :active, in: [true, false]
  scope :active, -> { where(active: true) }

  def name
    I18n.t('medications.refill_reminder')
    I18n.t('strategies.refill_reminder')
  end
end
