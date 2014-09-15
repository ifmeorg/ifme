class AddVisibiltyToComment < ActiveRecord::Migration
  def change
    add_column :comments, :visibility, :string
  end
end
