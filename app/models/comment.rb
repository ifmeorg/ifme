# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment_type :string(255)
#  commented_on :integer
#  comment_by   :integer
#  comment      :text
#  created_at   :datetime
#  updated_at   :datetime
#  visibility   :string(255)
#

class Comment < ActiveRecord::Base
	attr_accessible :comment_type, :commented_on, :comment_by, :comment, :visibility
	validates_length_of :comment, :minimum => 0, :maximum => 1000
	validates_presence_of :comment_type, :commented_on, :comment_by, :comment
	validates :comment_type, inclusion: %w(trigger strategy)
	validates :visibility, inclusion: %w(all private)
end
