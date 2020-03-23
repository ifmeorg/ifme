class RenameUseridOnCategories < ActiveRecord::Migration[5.0]
  def change
    rename_column(:categories, :userid, :user_id)
  end
end
