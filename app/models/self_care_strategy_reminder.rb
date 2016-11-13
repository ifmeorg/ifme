# == Schema Information
#
# Table name: self_care_strategy_reminders
#
#  id          :integer          not null, primary key
#  strategy_id :integer          not null
#  active      :boolean          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SelfCareStrategyReminder < ActiveRecord::Base
  belongs_to :strategy
  validates_inclusion_of :active, in: [true, false]
  scope :active, -> { where(active: true) }

  def name
    I18n.t('strategies.self_care')
  end
end
