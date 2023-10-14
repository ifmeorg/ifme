# frozen_string_literal: true
module CommonMethods
  extend ActiveSupport::Concern

  def mood_names_and_slugs
    return unless self.class.reflect_on_association(:moods)

    names_and_slugs_hash(moods.pluck(:name, :slug), 'moods')
  end

  def category_names_and_slugs
    return unless self.class.reflect_on_association(:categories)

    names_and_slugs_hash(categories.pluck(:name, :slug), 'categories')
  end

  def elements_array_data(elements)
    elements.each do |element|
      associated_elements = element.pluralize
      klass = element.capitalize.constantize
      if send(element).is_a?(Array)
        element_ids = send(element).collect(&:to_i)
        send("#{associated_elements}=",
             klass.where(user_id:, id: element_ids))
      else
        send("#{associated_elements}=", klass.none)
      end
    end
  end

  private

  def names_and_slugs_hash(data, model_name)
    data.map { |name, slug| { name:, slug: "/#{model_name}/#{slug}" } }
  end
end
