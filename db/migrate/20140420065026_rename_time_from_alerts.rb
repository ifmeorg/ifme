class RenameTimeFromAlerts < ActiveRecord::Migration
  def change
  	rename_column :alerts, :time, :time_hour
  end
end
