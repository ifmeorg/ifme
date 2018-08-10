class RenameUseridOnMedications < ActiveRecord::Migration[5.0]
  def change
    rename_column(:medications, :userid, :user_id)
  end
end
