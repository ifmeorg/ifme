# frozen_string_literal: true
module CommonMethods
  extend ActiveSupport::Concern

  def mood_names
    return unless attribute(:mood)

    Mood.where(id: mood).pluck(:name)
  end

  def category_names
    return unless attribute(:category)

    Category.where(id: category).pluck(:name)
  end
end
