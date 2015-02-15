class ChangeTypeForTrigger < ActiveRecord::Migration
  def change
  	change_table :triggers do |t|
      t.change :viewers, 'text USING CAST(viewers AS text)'
      t.change :strategies, 'text USING CAST(strategies AS text)'
    end
  end
end
