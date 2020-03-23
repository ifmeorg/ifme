class RenameUseridOnStrategies < ActiveRecord::Migration[5.0]
  def change
    rename_column(:strategies, :userid, :user_id)
  end
end
