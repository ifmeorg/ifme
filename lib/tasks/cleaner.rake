# frozen_string_literal: true

namespace :cleaner do
  desc 'Remove lingering categories on Strategy instances'
  task remove_lingering_categories: :environment do
    Strategy.all.each do |strategy|
      strategy.category.each do |category_id|
        next if Category.find_by(id: category_id)

        p "Removing category #{category_id} from strategy: #{strategy.name}"
        strategy.category.delete(category_id)
        strategy.save
      end
    end
  end

  desc 'Convert existing Moment category IDs to join table records'
  task populate_moments_categories: :environment do
    Moment.populate_moments_categories
  end
end
