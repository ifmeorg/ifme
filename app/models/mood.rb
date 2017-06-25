# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  userid      :integer
#  slug        :string
#

class Mood < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  validates_length_of :description, :maximum => 2000
  validates_presence_of :userid, :name

  def self.link
    'moods'
  end
end
