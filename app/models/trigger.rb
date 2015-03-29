class Trigger < ActiveRecord::Base
	attr_accessible :category, :name, :mood, :why, :fix, :userid, :viewers, :comment, :strategies, :post_type
	serialize :category, Array
	serialize :viewers, Array
	serialize :mood, Array
	serialize :strategies, Array
	validates :comment, inclusion: [true, false]
	validates_presence_of :userid, :name, :why
	validates_length_of :why, :minimum => 1, :maximum => 2000
	validates_length_of :fix, :maximum => 2000
	before_save :array_data
	before_save :check_post_type

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
		if !self.strategies.nil? && self.strategies.is_a?(Array)
			self.strategies = self.strategies.collect{|i| i.to_i}
		end
	end

	def check_post_type
		if self.post_type == 1
	   		self.viewers = Ally.where(:status => 0).pluck(:id)
    	else
	   		self.viewers = nil
    	end
	end

end