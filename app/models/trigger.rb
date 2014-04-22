class Trigger < ActiveRecord::Base
	attr_accessible :category, :name, :mood, :why, :fix, :userid
	serialize :category, Array
	serialize :mood, Array
	validates_presence_of :userid, :name, :category, :name
end
