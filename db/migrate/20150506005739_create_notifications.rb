# encoding: UTF-8
class CreateNotifications < ActiveRecord::Migration

  create_table :notifications do |t|
      t.references :user, index: true, null: false
      t.string :uniqueid
      t.text :data
      t.timestamps null: false
  end
end
