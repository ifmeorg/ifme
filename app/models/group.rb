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
end
