# == Schema Information
#
# Table name: meeting_members
#
#  id         :integer          not null, primary key
#  meetingid  :integer
#  userid     :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class MeetingMember < ActiveRecord::Base
	attr_accessible :meetingid, :userid, :leader

	validates_presence_of :meetingid, :userid
	validates :leader, inclusion: [true, false]
end
