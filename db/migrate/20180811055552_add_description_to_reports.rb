class AddDescriptionToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :commentable_type, :string
    add_column :reports, :commentable_id, :integer
  end
end
