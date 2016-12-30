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
#  name        :string
#

class Strategy < ActiveRecord::Base
  belongs_to :user, foreign_key: :userid
  serialize :category, Array
  serialize :viewers, Array
  validates :comment, inclusion: [true, false]
  validates_presence_of :userid, :name, :description
  validates_length_of :description, :minimum => 1, :maximum => 2000
  has_one :perform_strategy_reminder
  accepts_nested_attributes_for :perform_strategy_reminder
  before_save :array_data

  def array_data
    if !category.nil? && category.is_a?(Array)
      self.category = category.collect(&:to_i)
    end
    if !viewers.nil? && viewers.is_a?(Array)
      self.viewers = viewers.collect(&:to_i)
    end
  end

  def active_reminders
    [perform_strategy_reminder].select(&:active?)
  end

  def self.link
    '/strategies'
  end
end
