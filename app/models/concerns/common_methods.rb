# frozen_string_literal: true
module CommonMethods
  extend ActiveSupport::Concern

  def mood_names_and_slugs
    return unless self.class.reflect_on_association(:moods)

    names_and_slugs_hash(
      moods.pluck(:name, :slug),
      'moods'
    )
  end

  def category_names_and_slugs
    return unless attribute(:category)

    names_and_slugs_hash(
      Category.where(id: category).pluck(:name, :slug),
      'categories'
    )
  end

  private

  def names_and_slugs_hash(data, model_name)
    data.map { |name, slug| { name: name, slug: "/#{model_name}/#{slug}" } }
  end
end
