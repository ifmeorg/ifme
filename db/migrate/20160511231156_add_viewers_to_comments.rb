class AddViewersToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :viewers, :text
  end
end
