class AddCommentIdToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :comment_id, :integer
  end
end
