# frozen_string_literal: true
module MostFocusHelper
  def most_focus(data_type, user)
    return unless user && %w[moods strategies categories].include?(data_type)

    data = get_data(data_type, user)
    return unless data.any?

    filter_visible_data(data, data_type)
  end

  private

  def filter_visible_data(data, data_type)
    visible_data = get_visible_data_for(data, data_type).map(&:id)
    data = data.select { |h| visible_data.include? h }

    return unless data.any?

    top_three_focus(data)
  end

  def get_visible_data_for(data, data_type)
    case data_type
    when 'moods'
      Mood.where(id: data.uniq, visible: true)
    when 'categories'
      Category.where(id: data.uniq, visible: true)
    when 'strategies'
      Strategy.where(id: data.uniq, visible: true)
    end
  end

  def get_data(data_type, user)
    data = get_data_type(user.moments.published, data_type)
    if data_type == 'category'
      data.concat(get_data_type(user.strategies.published, data_type))
    end
    data
  end

  def viewable?(item)
    current_user.id == item.user_id || item.viewer?(current_user)
  end

  def get_data_objs(item, data_type)
    if data_type == 'moods'
      item.moods.pluck(:id)
    elsif data_type == 'categories'
      item.categories.pluck(:id)
    elsif data_type == 'strategies'
      item.strategies.pluck(:id)
    end
  end

  def get_data_type(model_object, data_type)
    data = []
    model_object.select do |item|
      objs = get_data_objs(item, data_type)
      next unless objs.any? && viewable?(item)

      data.concat(objs)
    end
    data
  end

  def top_three_focus(data)
    freq = data.each_with_object(Hash.new(0)) do |value, hash|
      hash[value] += 1
    end
    freq.sort_by do |occurrences, _value|
      occurrences
    end[0..2].to_h
  end
end
