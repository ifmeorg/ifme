class RenameTimesFromAlerts < ActiveRecord::Migration
  def change
  	rename_column :alerts, :times, :time
  end
end
