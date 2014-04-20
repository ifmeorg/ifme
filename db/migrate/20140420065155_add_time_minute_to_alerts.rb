class AddTimeMinuteToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :time_minute, :integer
  end
end
