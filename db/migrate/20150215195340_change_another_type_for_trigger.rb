class ChangeAnotherTypeForTrigger < ActiveRecord::Migration
  def change
  	change_table :triggers do |t|
      t.change :category, 'text USING CAST(category AS text)'
    end
  end
end
