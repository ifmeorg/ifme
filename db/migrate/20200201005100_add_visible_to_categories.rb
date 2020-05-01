class AddVisibleToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :visible, :boolean, default: true
  end
end
