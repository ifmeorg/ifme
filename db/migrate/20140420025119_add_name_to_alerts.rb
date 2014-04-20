class AddNameToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :name, :string
  end
end
