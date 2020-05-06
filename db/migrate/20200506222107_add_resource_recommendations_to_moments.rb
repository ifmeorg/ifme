class AddResourceRecommendationsToMoments < ActiveRecord::Migration[5.2]
  def change
    add_column :moments, :resource_recommendations, :boolean
  end
end
