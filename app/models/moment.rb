# frozen_string_literal: true

# == Schema Information
#
# Table name: moments
#
#  id         :integer          not null, primary key
#  category   :text
#  name       :string
#  mood       :text
#  why        :text
#  fix        :text
#  created_at :datetime
#  updated_at :datetime
#  userid     :integer
#  viewers    :text
#  comment    :boolean
#  strategies :text
#  slug       :string
#

class Moment < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  serialize :category, Array
  serialize :viewers, Array
  serialize :mood, Array
  serialize :strategies, Array
  validates :comment, inclusion: [true, false]
  validates :userid, :name, :why, presence: true
  validates :why, length: { minimum: 1, maximum: 2000 }
  validates :fix, length: { maximum: 2000 }
  before_save :array_data

  def array_data
    self.category = category.collect(&:to_i) if category.is_a?(Array)
    self.viewers = viewers.collect(&:to_i) if viewers.is_a?(Array)
    self.mood = mood.collect(&:to_i) if mood.is_a?(Array)
    self.strategies = strategies.collect(&:to_i) if strategies.is_a?(Array)
  end

  def strategy
    strategies
  end

  def category_name
    category.try(:name)
  end

  def mood_name
    mood.try(:name)
  end

  def strategy_name
    strategy.try(:name)
  end
end
