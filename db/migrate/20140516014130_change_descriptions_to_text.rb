class ChangeDescriptionsToText < ActiveRecord::Migration
  def change
  	change_column :categories, :description, :text
  	change_column :comments, :comment, :text
  	change_column :moods, :description, :text
  	change_column :triggers, :why, :text
  	change_column :triggers, :fix, :text
  end
end
