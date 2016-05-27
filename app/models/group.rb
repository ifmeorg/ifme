# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

class Group < ActiveRecord::Base
  validates_presence_of :name, :description

  has_many :group_members, foreign_key: :groupid
  has_many :users, through: :group_members
  has_many :meetings, foreign_key: :groupid

  def led_by?(user)
    leaders.include?(user)
  end

  private

  def leaders
    users.where(group_members: { leader: true })
  end
end
