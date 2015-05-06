class GroupMember < ActiveRecord::Base
	attr_accessible :groupid, :userid, :leader

	validates_presence_of :groupid, :userid
	validates :leader, inclusion: [true, false]
end
