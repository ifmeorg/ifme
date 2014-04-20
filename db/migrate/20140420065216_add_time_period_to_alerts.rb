class AddTimePeriodToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :time_period, :string
  end
end
