# frozen_string_literal: true
# == Schema Information
#
# Table name: group_members
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  user_id    :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class GroupMember < ApplicationRecord
  after_destroy :destroy_meeting_memberships

  validates :group_id, :user_id, presence: true
  validates :leader, inclusion: [true, false]

  belongs_to :group
  belongs_to :user, foreign_key: :user_id

  has_many :meetings, through: :group
  has_many :meeting_memberships,
           lambda { |group_member|
             where(meeting_members: { user_id: group_member.user_id })
           },
           through: :meetings, source: :meeting_members

  def destroy_meeting_memberships
    # this can't be done through dependent: :destroy because nested associations
    # are readonly
    MeetingMember.where(id: meeting_membership_ids).destroy_all
  end

  def self.member?(user, group)
    exists?(
      group_id: group.id,
      user_id: user.id
    )
  end

  def self.leader?(user, group)
    exists?(
      group_id: group.id,
      user_id: user.id,
      leader: true
    )
  end
end
