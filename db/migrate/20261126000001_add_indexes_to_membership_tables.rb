# frozen_string_literal: true

class AddIndexesToMembershipTables < ActiveRecord::Migration[7.0]
  def change
    add_index :allyships, :user_id
    add_index :allyships, :ally_id
    add_index :group_members, :group_id
    add_index :group_members, :user_id
    add_index :meeting_members, :meeting_id
    add_index :meeting_members, :user_id
  end
end
