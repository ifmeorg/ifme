class CreatePerformStrategyReminders < ActiveRecord::Migration
  def change
    create_table :perform_strategy_reminders do |t|
      t.integer :strategy_id, null: false
      t.boolean :active, null:false

      t.timestamps null: false
    end
  end
end
