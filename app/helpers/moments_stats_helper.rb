# frozen_string_literal: true

module MomentsStatsHelper
  def moments_stats
    return '' if moment_count[:total] < 1

    result = '<div class="center stats">'
    result += total_moment
    if moment_count[:total] != moment_count[:monthly]
      result += " #{monthly_moment}"
    end
    result + '</div>'
  end

  private

  def moment_count
    {
      total: current_user.moments.all.count,
      monthly: current_user.moments.where(
        created_at: Time.current.beginning_of_month..Time.current
      ).count
    }
  end

  def total_moment
    moment_key = moment_count[:total] == 1 ? 'moment' : 'moments'
    t("stats.total_#{moment_key}", count: moment_count[:total])
  end

  def monthly_moment
    moment_key = moment_count[:monthly] == 1 ? 'moment' : 'moments'
    t("stats.monthly_#{moment_key}", count: moment_count[:monthly])
  end
end
