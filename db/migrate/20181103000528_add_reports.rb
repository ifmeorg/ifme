class AddReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer "reporter_id"
      t.integer "reportee_id"
      t.text "reasons"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "comment_id"
    end
  end
end
