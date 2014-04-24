class Trigger < ActiveRecord::Base
	attr_accessible :category, :name, :mood, :why, :fix, :userid, :viewers
	serialize :category, Array
	serialize :viewers, Array
	serialize :mood, Array
	validates_presence_of :userid, :name, :category, :name, :why
end
