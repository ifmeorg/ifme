# == Schema Information
#
# Table name: strategy_reminders
#
#  id          :integer          not null, primary key
#  strategy_id :integer          not null
#  active      :boolean          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StrategyReminder < ActiveRecord::Base
  belongs_to :strategy
  validates_inclusion_of :active, in: [true, false]
  scope :active, -> { where(active: true) }

  def name
    I18n.t('strategies.daily_reminder')
  end
end
