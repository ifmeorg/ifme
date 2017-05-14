class AddViewersToComments < ActiveRecord::Migration
  def change
    add_column :comments, :viewers, :text
  end
end
