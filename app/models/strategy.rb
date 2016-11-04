# == Schema Information
#
# Table name: strategies
#
#  id          :integer          not null, primary key
#  userid      :integer
#  category    :text
#  description :text
#  viewers     :text
#  comment     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#

class Strategy < ActiveRecord::Base
  
  belongs_to :user, foreign_key: :userid

  has_one :perform_strategy_reminder
  has_one :refill_reminder
  accepts_nested_attributes_for :perform_strategy_reminder
  accepts_nested_attributes_for :refill_reminder

  serialize :category, Array
  serialize :viewers, Array
  validates :comment, inclusion: [true, false]
  validates_presence_of :userid, :name, :description
  validates_length_of :description, :minimum => 1, :maximum => 2000
  before_save :array_data

  def array_data
    if !self.category.nil? && self.category.is_a?(Array)
      self.category = self.category.collect{|i| i.to_i}
    end
    if !self.viewers.nil? && self.viewers.is_a?(Array)
      self.viewers = self.viewers.collect{|i| i.to_i}
    end
  end

   def active_reminders
    [refill_reminder, perform_strategy_reminder].select(&:active?)
  end
end
