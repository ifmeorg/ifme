class AddNoOfDaysFollowedToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :no_of_days_followed, :integer
  end
end
