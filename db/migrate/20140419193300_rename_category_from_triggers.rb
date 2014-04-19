class RenameCategoryFromTriggers < ActiveRecord::Migration
  def change
  	change_column :triggers, :category, :string
  end
end
