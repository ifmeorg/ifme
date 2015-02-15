class AddNameToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :name, :string
  end
end
