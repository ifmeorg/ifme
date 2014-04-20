class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :userid
      t.integer :trigger
      t.integer :medication
      t.string :message
      t.string :means
      t.string :days
      t.string :time

      t.timestamps
    end
  end
end
