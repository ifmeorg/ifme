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

  def strategy
    strategies
  end

  private

  def array_data
    %i(category viewers mood strategies).each do |item|
      var = send(item)

      send("#{item}=", var.collect(&:to_i)) if !var.nil? && var.is_a?(Array)
    end
  end
end
