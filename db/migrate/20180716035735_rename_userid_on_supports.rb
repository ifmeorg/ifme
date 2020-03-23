class RenameUseridOnSupports < ActiveRecord::Migration[5.0]
  def change
    rename_column(:supports, :userid, :user_id)
  end
end
