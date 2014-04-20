class CreateAllies < ActiveRecord::Migration
  def change
    create_table :allies do |t|
      t.integer :userid
      t.string :allies

      t.timestamps
    end
  end
end
