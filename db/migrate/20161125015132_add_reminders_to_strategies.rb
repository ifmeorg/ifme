class AddRemindersToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :self_care_strategy, :string
  end
end
