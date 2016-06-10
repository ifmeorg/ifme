# encoding: UTF-8
class CreateGroupMembers < ActiveRecord::Migration

  create_table :group_members, force: true do |t|
    t.references :group, index: true, null: false
    t.references :user, index: true, nill: false
    t.boolean  :leader
    t.timestamps
  end

  add_foreign_key :group_members, :groups
  add_foreign_key :group_members, :users

end
