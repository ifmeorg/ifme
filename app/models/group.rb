class Group < ActiveRecord::Base
	attr_accessible :name, :description

	validates_presence_of :name, :description
end
