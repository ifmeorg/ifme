class ChangeColumnOnAlert < ActiveRecord::Migration
  def change
    rename_column :alerts, :userid, :user_id
  end
end
