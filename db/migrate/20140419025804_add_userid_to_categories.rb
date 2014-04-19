class AddUseridToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :userid, :integer
  end
end
