# encoding: UTF-8
class CreateMeetingMembers < ActiveRecord::Migration

  create_table :meeting_members, force: true do |t|
    t.references :meeting, index: true, null: false
    t.references :user, index: true, null: false
    t.boolean  :leader
    t.timestamps
  end

  add_foreign_key :meeting_members, :meetings
  add_foreign_key :meeting_members, :users
end
