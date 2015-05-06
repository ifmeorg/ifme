class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :groupid
      t.integer :userid
      t.boolean :leader

      t.timestamps
    end
  end
end
