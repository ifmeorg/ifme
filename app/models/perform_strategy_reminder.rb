# == Schema Information
#
# Table name: perform_strategy_reminders
#
#  id          :integer          not null, primary key
#  strategy_id :integer          not null
#  active      :boolean          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class PerformStrategyReminder < ActiveRecord::Base
  belongs_to :strategy
  validates_inclusion_of :active, in: [true, false]
  scope :active, -> { where(active: true) }

  def name
    I18n.t('common.daily_reminder')
  end
end
