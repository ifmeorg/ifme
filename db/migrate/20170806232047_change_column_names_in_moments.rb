class ChangeColumnNamesInMoments < ActiveRecord::Migration
  def change
    rename_column :moments, :strategies, :strategy
  end
end
