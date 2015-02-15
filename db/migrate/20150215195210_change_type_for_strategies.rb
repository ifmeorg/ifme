class ChangeTypeForStrategies < ActiveRecord::Migration
  def change
  	change_table :strategies do |t|
      t.change :viewers, 'text USING CAST(viewers AS text)'
      t.change :category, 'text USING CAST(category AS text)'
    end
  end
end
