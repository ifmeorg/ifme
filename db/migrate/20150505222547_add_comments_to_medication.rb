class AddCommentsToMedication < ActiveRecord::Migration
  def change
  	 add_column :medications, :comments, :text
  end
end
