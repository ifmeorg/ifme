class AddSelfCareStrategyToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :self_care_strategy, :datetime
  end
end
