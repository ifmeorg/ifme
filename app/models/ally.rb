class Ally < ActiveRecord::Base
	attr_accessible :userid, :allies
	serialize :allies, Array
	before_save :array_data

	def array_data 
		if !self.allies.nil? && self.allies.is_a?(Array)
			self.allies = self.allies.collect{|i| i.to_i}
		end
	end 
end
