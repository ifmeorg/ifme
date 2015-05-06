class CreateSessionMembers < ActiveRecord::Migration
  def change
    create_table :session_members do |t|
      t.integer :sessionid
      t.integer :userid
      t.boolean :leader

      t.timestamps
    end
  end
end
