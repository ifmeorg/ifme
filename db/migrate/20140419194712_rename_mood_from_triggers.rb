class RenameMoodFromTriggers < ActiveRecord::Migration
  def change
  	change_column :triggers, :mood, :string
  end
end
