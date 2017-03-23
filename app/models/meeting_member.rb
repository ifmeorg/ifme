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
  belongs_to :meeting, foreign_key: :meetingid
  belongs_to :user, foreign_key: :userid
  belongs_to :group_member, foreign_key: :userid

  validates :meetingid, :userid, presence: true
  validates :leader, inclusion: [true, false]
end
