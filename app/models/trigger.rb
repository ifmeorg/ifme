class Trigger < ActiveRecord::Base
	attr_accessible :category, :name, :mood, :why, :fix, :fix, :userid
	serialize :category, Array
	serialize :mood, Array
end
