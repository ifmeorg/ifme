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
#

class Moment < ActiveRecord::Base
  serialize :category, Array
  serialize :viewers, Array
  serialize :mood, Array
  serialize :strategies, Array
  validates :comment, inclusion: [true, false]
  validates_presence_of :userid, :name, :why
  validates_length_of :why, minimum: 1, maximum: 2000
  validates_length_of :fix, maximum: 2000
  before_save :array_data

  def array_data
    if !category.nil? && category.is_a?(Array)
      self.category = category.collect(&:to_i)
    end
    if !viewers.nil? && viewers.is_a?(Array)
      self.viewers = viewers.collect(&:to_i)
    end
    self.mood = mood.collect(&:to_i) if !mood.nil? && mood.is_a?(Array)
    if !strategies.nil? && strategies.is_a?(Array)
      self.strategies = strategies.collect(&:to_i)
    end
  end

  def strategy
    strategies
  end

end
