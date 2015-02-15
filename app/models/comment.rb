class Comment < ActiveRecord::Base
	attr_accessible :comment_type, :commented_on, :comment_by, :comment, :visibility
	validates_length_of :comment, :minimum => 0, :maximum => 1000
	validates_presence_of :comment_type, :commented_on, :comment_by, :comment
	validates :comment_type, inclusion: %w(trigger strategy)
	validates :visibility, inclusion: %w(all private)
end
