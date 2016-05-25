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

class GroupMember < ActiveRecord::Base
  validates_presence_of :groupid, :userid
  validates :leader, inclusion: [true, false]

  belongs_to :group, foreign_key: :groupid
  belongs_to :user, foreign_key: :userid
end
