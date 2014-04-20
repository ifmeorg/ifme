class RenameTimeFromAlerts < ActiveRecord::Migration
  def change
  	rename_column :alerts, :time, :times
  end
end
