class DropMomentsCategoryColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :moments, :category
  end
end
