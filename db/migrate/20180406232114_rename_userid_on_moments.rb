class RenameUseridOnMoments < ActiveRecord::Migration[5.0]
  def change
    rename_column(:moments, :userid, :user_id)
  end
end
