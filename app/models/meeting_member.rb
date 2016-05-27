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
  validates_presence_of :meetingid, :userid
  validates :leader, inclusion: [true, false]

  belongs_to :meeting, foreign_key: :meetingid
  belongs_to :user, foreign_key: :userid
end
