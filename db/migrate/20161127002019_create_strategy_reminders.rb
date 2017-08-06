class CreateStrategyReminders < ActiveRecord::Migration[4.2]
  def change
    create_table :perform_strategy_reminders do |t|
      t.integer :strategy_id, null: false
      t.boolean :active, null: false

      t.timestamps
    end
  end
end
