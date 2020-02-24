class CreateMomentCategoriesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :moments_categories do |t|
      t.integer :moment_id
      t.integer :category_id
    end

    add_index :moments_categories, [:moment_id, :category_id], unique: true
    add_foreign_key :moments_categories, :moments
    add_foreign_key :moments_categories, :categories
  end
end
