class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :userid
      t.string :uniqueid
      t.text :data

      t.timestamps null: false
    end
  end
end
