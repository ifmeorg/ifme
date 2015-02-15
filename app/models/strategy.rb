class Strategy < ActiveRecord::Base
	attr_accessible :userid, :category, :description, :viewers, :comment, :name
	serialize :category, Array
	serialize :viewers, Array
	validates :comment, inclusion: [true, false]
	validates_presence_of :userid, :name, :description
	validates_length_of :description, :minimum => 1, :maximum => 2000
	before_save :array_data

	def array_data
		if !self.category.nil? && self.category.is_a?(Array)
			self.category = self.category.collect{|i| i.to_i}
		end
		if !self.viewers.nil? && self.viewers.is_a?(Array)
			self.viewers = self.viewers.collect{|i| i.to_i}
		end
	end
end
