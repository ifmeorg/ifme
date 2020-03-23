class ChangeCommentsToBePolymorphic < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :comment_type, :commentable_type
    rename_column :comments, :commented_on, :commentable_id

    add_index :comments, [:commentable_type, :commentable_id]
  end
end
