class Medication < ActiveRecord::Base
	attr_accessible :name, :dosage, :refill, :userid, :total, :strength, :dosage_unit, :total_unit, :strength_unit

	# dosage: amount of medication taken at one time
	# total: total quantity of medication
	# strength: strength of medication

	validates_presence_of :name, :dosage, :refill, :userid, :total, :strength, :dosage_unit, :total_unit, :strength_unit

	validates :dosage, :numericality => { :greater_than_or_equal_to => 0 }
	validates :total, :numericality => { :greater_than_or_equal_to => 0 }
	validates :strength, :numericality => { :greater_than_or_equal_to => 0 }
end
