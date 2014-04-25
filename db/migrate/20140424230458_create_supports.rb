class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.integer :userid
      t.string :support_type
      t.string :support_ids

      t.timestamps
    end
  end
end
