class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.integer :userid
      t.integer :triggerid
      t.integer :viewerid
      t.timestamps
    end
  end
end
