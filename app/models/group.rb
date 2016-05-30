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
  has_many :members, -> { order 'name' }, through: :group_members, source: :user
  has_many :meetings, -> { order 'created_at DESC' }, foreign_key: :groupid
  has_many :meetings, foreign_key: :groupid
  has_many :leaders, -> { where(group_members: { leader: true }) },
           through: :group_members, source: :user

  def led_by?(user)
    leaders.include? user
  end
end
