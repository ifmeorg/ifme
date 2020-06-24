class CreateCarePlanContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :care_plan_contacts do |t|
      t.string :name
      t.string :phone
      t.integer :user_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
