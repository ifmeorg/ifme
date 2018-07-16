# frozen_string_literal: true
# == Schema Information
#
# Table name: meeting_members
#
#  id         :integer          not null, primary key
#  meetingid  :integer
#  user_id    :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class MeetingMember < ApplicationRecord
  validates :meetingid, :user_id, presence: true
  validates :leader, inclusion: [true, false]

  belongs_to :meeting, foreign_key: :meetingid
  belongs_to :user, foreign_key: :user_id
  belongs_to :group_member, foreign_key: :user_id
end
