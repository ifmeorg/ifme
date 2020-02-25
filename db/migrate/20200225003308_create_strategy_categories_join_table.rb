class CreateStrategyCategoriesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :strategies_categories do |t|
      t.integer :strategy_id
      t.integer :category_id
    end

    add_index :strategies_categories, [:strategy_id, :category_id], unique: true
    add_foreign_key :strategies_categories, :strategies
    add_foreign_key :strategies_categories, :categories
  end
end
