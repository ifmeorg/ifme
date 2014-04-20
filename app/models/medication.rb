class Medication < ActiveRecord::Base
	attr_accessible :name, :dosage, :refill, :userid
end
