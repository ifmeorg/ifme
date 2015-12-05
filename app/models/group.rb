# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

class Group < ActiveRecord::Base
	attr_accessible :name, :description

	validates_presence_of :name, :description
end
