# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  userid      :integer
#

class Category < ActiveRecord::Base
  validates_length_of :description, :maximum => 2000
  validates_presence_of :userid, :name
end
