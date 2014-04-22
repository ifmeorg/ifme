class Comment < ActiveRecord::Base
	attr_accessible :comment_type, :commented_on, :comment_by, :comment
	validates_presence_of :comment_type, :commented_on, :comment_by, :comment
	validates :comment_type, inclusion: %w(trigger)
end
