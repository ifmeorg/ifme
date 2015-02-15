class ChangeTypeForSupports < ActiveRecord::Migration
  def change
  	change_table :supports do |t|
      t.change :support_ids, 'text USING CAST(support_ids AS text)'
    end
  end
end
