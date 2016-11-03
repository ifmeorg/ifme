class AddDailyReminderEmailStrategyToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :daily_reminder_email, :boolean
  end
end
