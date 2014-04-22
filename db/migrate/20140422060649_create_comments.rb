class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_type
      t.integer :commented_on
      t.integer :comment_by
      t.string :comment

      t.timestamps
    end
  end
end
