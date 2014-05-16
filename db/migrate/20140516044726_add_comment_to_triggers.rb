class AddCommentToTriggers < ActiveRecord::Migration
  def change
    add_column :triggers, :comment, :boolean
  end
end
