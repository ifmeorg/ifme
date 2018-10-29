# frozen_string_literal: true
module MostFocusHelper
  def most_focus(data_type, user)
    return unless user && %w[mood strategy category].include?(data_type)

    data = get_data(data_type, user)
    return unless data.any?

    top_three_focus(data)
  end

  private

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

  def get_data_type(model_object, data_type)
    data = []
    model_object.select do |item|
      next unless item[data_type].any? && viewable?(item)

      data.concat(item[data_type])
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
