class RenameSelfCareStrategyToSelfCareStrategy < ActiveRecord::Migration
  def change
  	change_column :strategies, :self_care_strategy, :string
  end
end
