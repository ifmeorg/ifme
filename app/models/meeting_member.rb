# frozen_string_literal: true

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

class MeetingMember < ApplicationRecord
  validates :meetingid, :userid, presence: true
  validates :leader, inclusion: [true, false]

  belongs_to :meeting, foreign_key: :meetingid, inverse_of: :meeting_member
  belongs_to :user, foreign_key: :userid, inverse_of: :meeting_member
  belongs_to :group_member, foreign_key: :userid, inverse_of: :meeting_member
end
