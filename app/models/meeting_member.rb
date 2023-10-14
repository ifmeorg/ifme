# frozen_string_literal: true
# == Schema Information
#
# Table name: meeting_members
#
#  id                  :bigint           not null, primary key
#  meeting_id          :integer
#  user_id             :integer
#  leader              :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  google_cal_event_id :string
#

class MeetingMember < ApplicationRecord
  USER_DATA_ATTRIBUTES = %w[
    id
    meeting_id
    leader
    created_at
    updated_at
    google_cal_event_id
  ].map!(&:freeze).freeze

  validates :meeting_id, :user_id, presence: true
  validates :leader, inclusion: [true, false]

  belongs_to :meeting
  belongs_to :user
  belongs_to :group_member, foreign_key: :user_id, optional: true
end
