class RenameUseridOnMoods < ActiveRecord::Migration[5.0]
  def change
    rename_column(:moods, :userid, :user_id)
  end
end
