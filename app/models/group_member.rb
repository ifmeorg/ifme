# == Schema Information
#
# Table name: group_members
#
#  id         :integer          not null, primary key
#  group_id    :integer
#  user_id     :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class GroupMember < ActiveRecord::Base
  after_destroy :destroy_meeting_memberships

  validates_presence_of :group_id, :user_id
  validates :leader, inclusion: [true, false]

  belongs_to :group, foreign_key: :group_id
  belongs_to :user, foreign_key: :user_id

  has_many :meetings, through: :group
  has_many :meeting_memberships,
           -> (group_member) { where(meeting_members: { user_id: group_member.user_id }) },
           through: :meetings, source: :meeting_members

  def destroy_meeting_memberships
    # this can't be done through dependent: :destroy because nested associations
    # are readonly
    MeetingMember.where(id: meeting_membership_ids).destroy_all
  end
end
