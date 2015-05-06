class MeetingMember < ActiveRecord::Base
	attr_accessible :meetingid, :userid, :leader

	validates_presence_of :meetingid, :userid
	validates :leader, inclusion: [true, false]
end
