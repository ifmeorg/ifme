class Support < ActiveRecord::Base
	attr_accessible :userid, :support_type, :support_ids
	validates_presence_of :userid, :support_type, :support_ids
	serialize :support_ids, Array
	validates :support_type, inclusion: %w(category mood trigger)
end
