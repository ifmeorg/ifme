class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :reporter_id
      t.string :reportee_id
      t.text :reasons

      t.timestamps
    end
  end
end
