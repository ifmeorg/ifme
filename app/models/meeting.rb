class Meeting < ActiveRecord::Base
	attr_accessible :name, :description, :location, :date, :time, :maxmembers, :groupid

	validates_presence_of :name, :description, :location, :date, :time, :groupid
end
