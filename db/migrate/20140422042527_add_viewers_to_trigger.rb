class AddViewersToTrigger < ActiveRecord::Migration
  def change
    add_column :triggers, :viewers, :string
  end
end
