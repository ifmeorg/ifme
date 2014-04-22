class Medication < ActiveRecord::Base
	attr_accessible :name, :dosage, :refill, :userid
	validates_presence_of :userid, :name, :dosage, :refill
end
