class AddRelations < ActiveRecord::Migration[4.2]
  def change
    rename_table :allies, :allyships
  end
end
