class DropStrategiesCategoryColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :strategies, :category
  end
end
