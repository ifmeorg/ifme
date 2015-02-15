class AddStrategiesToTriggers < ActiveRecord::Migration
  def change
    add_column :triggers, :strategies, :string
  end
end
