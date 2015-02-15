class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.integer :userid
      t.string :category
      t.text :description
      t.string :viewers
      t.boolean :comment

      t.timestamps
    end
  end
end
