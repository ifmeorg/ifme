# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id      :integer
#

class Mood < ActiveRecord::Base
  validates_length_of :description, :maximum => 2000
  validates_presence_of :user_id, :name
end
