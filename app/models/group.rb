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

  has_and_belongs_to_many :users, join_table: :group_members,
    foreign_key: :userid, association_foreign_key: :groupid
end
