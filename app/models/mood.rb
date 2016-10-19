# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  userid      :integer
#

class Mood < ActiveRecord::Base
  validates_length_of :description, maximum: 2000
  validates_presence_of :userid, :name
end
