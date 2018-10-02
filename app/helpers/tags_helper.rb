# frozen_string_literal: true
module TagsHelper
  # rubocop:disable MethodLength
  def tag_usage(data_id, data_type, user_id)
    result = []
    moments = Moment.where(user_id: user_id).order('created_at DESC')
    if data_type == 'category'
      strategies = Strategy.where(user_id: user_id).order('created_at DESC')
      [moments, strategies].each do |records|
        objs = []
        records.find_each do |r|
          objs.push(r) if data_included?(data_type, data_id, r)
        end
        result << objs
      end
    elsif data_type.in?(%w[mood strategy])
      moments.find_each do |m|
        result << m if data_included?(data_type, data_id, m)
      end
    end
    result
  end
  # rubocop:enable MethodLength

  private

  def data_included?(data_type, data_id, data)
    return false unless data_type.in?(%w[category mood strategy])

    data_id.in?(data[data_type])
  end
end
