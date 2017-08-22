class SetLimitsOnText < ActiveRecord::Migration[4.2]
  def change
  	change_column :categories, :description, :text, :limit => nil
  	change_column :comments, :comment, :text, :limit => nil
  	change_column :comments, :viewers, :text, :limit => nil
  	change_column :groups, :description, :text, :limit => nil
  	change_column :medications, :comments, :text, :limit => nil
  	change_column :meetings, :description, :text, :limit => nil
  	change_column :meetings, :location, :text, :limit => nil
  	change_column :moments, :category, :text, :limit => nil
  	change_column :moments, :mood, :text, :limit => nil
  	change_column :moments, :why, :text, :limit => nil
  	change_column :moments, :fix, :text, :limit => nil
  	change_column :moments, :viewers, :text, :limit => nil
  	change_column :moments, :strategies, :text, :limit => nil
  	change_column :moods, :description, :text, :limit => nil
  	change_column :notifications, :data, :text, :limit => nil
  	change_column :strategies, :category, :text, :limit => nil
  	change_column :strategies, :description, :text, :limit => nil
  	change_column :strategies, :viewers, :text, :limit => nil
  	change_column :users, :about, :text, :limit => nil
  	change_column :users, :conditions, :text, :limit => nil
  end
end
