class RenameTimeMinuteFromAlerts < ActiveRecord::Migration
  def change
  	change_column :alerts, :time_minute, :string
  end
end
