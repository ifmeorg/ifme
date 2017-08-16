# frozen_string_literal: true

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
#  slug        :string
#

class Strategy < ApplicationRecord
  include Viewer
  extend FriendlyId

  friendly_id :name
  serialize :category, Array
  serialize :viewers, Array

  before_save :array_data_to_i!

  belongs_to :user, foreign_key: :userid

  has_one :perform_strategy_reminder
  accepts_nested_attributes_for :perform_strategy_reminder

  validates :comment, inclusion: [true, false]
  validates :userid, :name, :description, presence: true
  validates :description, length: { minimum: 1, maximum: 2000 }

  def array_data_to_i!
    category.map!(&:to_i)
    viewers.map!(&:to_i)
  end

  def active_reminders
    [perform_strategy_reminder].select(&:active?) if perform_strategy_reminder
  end

  def category_name
    category.try(:name)
  end

  def self.link
    '/strategies'
  end
end
