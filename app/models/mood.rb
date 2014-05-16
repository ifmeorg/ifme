class Mood < ActiveRecord::Base
	attr_accessible :name, :description, :userid
	validates_length_of :description, :minimum => 0, :maximum => 2000
	validates_presence_of :userid, :name
end
