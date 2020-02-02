class AddVisibleToStrategies < ActiveRecord::Migration[5.2]
  def change
    add_column :strategies, :visible, :boolean, default: true
  end
end
