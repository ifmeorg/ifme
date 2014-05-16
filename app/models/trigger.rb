class Trigger < ActiveRecord::Base
	attr_accessible :category, :name, :mood, :why, :fix, :userid, :viewers
	serialize :category, Array
	serialize :viewers, Array
	serialize :mood, Array
	validates_presence_of :userid, :name, :category, :name, :why
	validates_length_of :why, :minimum => 1, :maximum => 2000
	validates_length_of :fix, :minimum => 0, :maximum => 2000
	before_save :array_data

	def array_data 
		if !self.category.nil? && self.category.is_a?(Array)
			self.category = self.category.collect{|i| i.to_i}
		end
		if !self.viewers.nil? && self.viewers.is_a?(Array)
			self.viewers = self.viewers.collect{|i| i.to_i}
		end
		if !self.mood.nil? && self.mood.is_a?(Array)
			self.mood = self.mood.collect{|i| i.to_i}
		end
	end 
end
