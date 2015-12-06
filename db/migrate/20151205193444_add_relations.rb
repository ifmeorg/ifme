class AddRelations < ActiveRecord::Migration
  def change
    rename_table :allies, :allyships
  end
end
