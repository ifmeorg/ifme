class ChangeColumnNamesInAllyships < ActiveRecord::Migration[4.2]
  def change
    rename_column :allyships, :userid1, :user_id
    rename_column :allyships, :userid2, :ally_id
  end
end
