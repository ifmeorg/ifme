# frozen_string_literal: true
module TagsHelper
  def tag_usage(data_id, data_type, user_id)
    result = []
    moments = User.find_by(id: user_id).moments.order('created_at DESC')
    if data_type == 'category'
      result = get_moments(data_id, data_type, user_id, moments)
    elsif data_type.in?(%w[mood strategy])
      result = get_moods(data_id, data_type, moments)
    end
    result
  end

  private

  def get_moods(data_id, data_type, moments)
    result = []
    moments.find_each do |m|
      result << m if data_included?(data_type, data_id, m)
    end
    result
  end

  def get_moments(data_id, data_type, user_id, moments)
    result = []
    strategies = User.find_by(id: user_id).strategies.order('created_at DESC')
    [moments, strategies].each do |records|
      objs = []
      records.find_each do |r|
        objs.push(r) if data_included?(data_type, data_id, r)
      end
      result << objs
    end
    result
  end

  def data_included?(data_type, data_id, data)
    data_type.in?(%w[category mood strategy]) && data_id.in?(data[data_type])
  end
end
