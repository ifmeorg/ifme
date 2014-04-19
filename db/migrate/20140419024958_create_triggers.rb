class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.integer :category
      t.string :name
      t.integer :mood
      t.string :why
      t.string :fix

      t.timestamps
    end
  end
end
