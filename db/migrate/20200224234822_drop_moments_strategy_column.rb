class DropMomentsStrategyColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :moments, :strategy
  end
end
