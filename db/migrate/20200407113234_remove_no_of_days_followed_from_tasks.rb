class RemoveNoOfDaysFollowedFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :no_of_days_followed
  end
end
