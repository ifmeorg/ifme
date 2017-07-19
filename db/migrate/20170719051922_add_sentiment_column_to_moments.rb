class AddSentimentColumnToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :sentiment, :float
  end
end
