class ChangeColumnNamesInMoments < ActiveRecord::Migration[4.2]
  def change
    rename_column :moments, :strategies, :strategy
  end
end
