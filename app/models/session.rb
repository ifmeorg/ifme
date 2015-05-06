class Session < ActiveRecord::Base
	attr_accessible :name, :description, :location, :time, :maxmembers, :groupid

	validates_presence_of :name, :description, :location, :time, :groupid
end
