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
  extend FriendlyId
  include SerializableData

  belongs_to :user, foreign_key: :userid
  has_one :perform_strategy_reminder

  validates :comment, inclusion: [true, false]
  validates :description, length: { minimum: 1, maximum: 2000 }
  validates :userid, :name, :description, presence: true

  serialize :category, Array
  serialize :viewers, Array

  accepts_nested_attributes_for :perform_strategy_reminder
  array_data_variables :category, :viewers

  friendly_id :name

  def active_reminders
    [perform_strategy_reminder].select(&:active?) if perform_strategy_reminder
  end

  def self.link
    '/strategies'
  end
end
