# frozen_string_literal: true

# == Schema Information
#
# Table name: group_members
#
#  id         :integer          not null, primary key
#  groupid    :integer
#  userid     :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class GroupMember < ApplicationRecord
  after_destroy :destroy_meeting_memberships

  validates :group_id, :userid, presence: true
  validates :leader, inclusion: [true, false]

  belongs_to :group
  belongs_to :user, foreign_key: :userid

  has_many :meetings, through: :group
  has_many :meeting_memberships,
           lambda { |group_member|
             where(meeting_members: { userid: group_member.userid })
           },
           through: :meetings, source: :meeting_members

  def destroy_meeting_memberships
    # this can't be done through dependent: :destroy because nested associations
    # are readonly
    MeetingMember.where(id: meeting_membership_ids).destroy_all
  end
end
