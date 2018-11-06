# frozen_string_literal: true
# == Schema Information
#
# Table name: meeting_members
#
#  id         :bigint(8)        not null, primary key
#  meeting_id :integer
#  user_id    :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class MeetingMember < ApplicationRecord
  validates :meeting_id, :user_id, presence: true
  validates :leader, inclusion: [true, false]

  belongs_to :meeting, foreign_key: :meeting_id
  belongs_to :user, foreign_key: :user_id
  belongs_to :group_member, foreign_key: :user_id
end
