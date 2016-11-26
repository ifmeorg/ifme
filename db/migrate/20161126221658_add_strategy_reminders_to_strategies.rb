class AddRemindersToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :strategy_reminders, :string
  end
end
