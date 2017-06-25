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
  validates_presence_of :userid, :name, :why
  validates_length_of :why, :minimum => 1, :maximum => 2000
  validates_length_of :fix, :maximum => 2000
  before_save :array_data

  def array_data
    if !self.category.nil? && self.category.is_a?(Array)
      self.category = self.category.collect{|i| i.to_i}
    end
    if !self.viewers.nil? && self.viewers.is_a?(Array)
      self.viewers = self.viewers.collect{|i| i.to_i}
    end
    if !self.mood.nil? && self.mood.is_a?(Array)
      self.mood = self.mood.collect{|i| i.to_i}
    end
    if !self.strategies.nil? && self.strategies.is_a?(Array)
      self.strategies = self.strategies.collect{|i| i.to_i}
    end
  end

  def strategy
    strategies
  end
end
