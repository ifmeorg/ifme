# frozen_string_literal: true

# rubocop:disable ModuleLength
module ApplicationHelper
  include ViewersHelper

  def html_options
    { class: 'htmlOptions' }
  end

  # rubocop:disable RescueStandardError
  def i18n_set?(key)
    I18n.t key, raise: true
  rescue
    false
  end
  # rubocop:enable RescueStandardError

def most_focus(data_type, profile_id)
  data = []
  user_id = profile_id || current_user.id
  moments =
    if current_user.id == profile_id
      user_moments(user_id)
    else
      user_moments(user_id).where.not(published_at: nil)
    end
  if data_type == 'category'
    strategies = user_strategies(user_id)
    [moments, strategies].each do |records|
      records.where(user_id: user_id).find_each do |r|
        if r.category.any? && (profile_id.blank? ||
                               profile_exists?(profile_id, r))
          data += r.category
        end
      end
    end
  elsif data_type.in?(%w[mood strategy])
    moments.find_each do |m|
      data_obj = m[data_type]
      if data_obj.any? && (profile_id.blank? ||
                           profile_exists?(profile_id, m))
        data += data_obj
      end
    end
  end

  data.empty? ? {} : top_three_focus(data)
end

private

def top_three_focus(data)
  # Turn data array into hash of value => freq_of_value
  freq = data.each_with_object(Hash.new(0)) do |value, hash|
    hash[value] += 1
  end

  def profile_exists?(profile, data)
    profile.present? &&
      (current_user.id == profile ||
       data.viewers.include?(current_user.id))
  end

  # rubocop:enable ModuleLength