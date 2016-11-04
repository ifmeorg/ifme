class AddStrategyIdToRefillReminders < ActiveRecord::Migration
  def change
    add_column :refill_reminders, :strategy_id, :integer
  end
end
