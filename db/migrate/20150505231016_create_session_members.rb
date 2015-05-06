class CreateSessionMembers < ActiveRecord::Migration
  def change
    create_table :meeting_members do |t|
      t.integer :meetingid
      t.integer :userid
      t.boolean :leader

      t.timestamps
    end
  end
end
