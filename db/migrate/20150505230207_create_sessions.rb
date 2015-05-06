class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :name
      t.text :description
      t.text :location
      t.string :time
      t.integer :maxmembers
      t.integer :groupid

      t.timestamps
    end
  end
end
