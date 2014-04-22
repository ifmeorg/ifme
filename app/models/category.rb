class Category < ActiveRecord::Base
	attr_accessible :name, :description, :userid
	validates_presence_of :userid, :name
end
