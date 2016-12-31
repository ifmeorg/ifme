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
  include SerializableData

  validates :comment, inclusion: [true, false]
  validates :userid, :name, :why, presence: true
  validates :why, length: { minimum: 1, maximum: 2000 }
  validates :fix, length: { maximum: 2000 }

  serialize :category, Array
  serialize :viewers, Array
  serialize :mood, Array
  serialize :strategies, Array

  array_data_variables :category, :viewers, :mood, :strategies

  def strategy
    strategies
  end
end
