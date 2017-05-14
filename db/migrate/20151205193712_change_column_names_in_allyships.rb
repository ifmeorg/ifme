class ChangeColumnNamesInAllyships < ActiveRecord::Migration
  def change
    rename_column :allyships, :userid1, :user_id
    rename_column :allyships, :userid2, :ally_id
  end
end
