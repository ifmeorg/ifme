# frozen_string_literal: true

module StoriesHelper
  # rubocop:disable MethodLength
  def get_stories(user, include_allies)
    if user.id == current_user.id
      my_moments = user.moments.all.recent
      my_strategies = user.strategies.all.recent
    end

    if include_allies && user.id == current_user.id
      allies = user.allies_by_status(:accepted)
      allies.each do |ally|
        my_moments += user_stories(ally, 'moments')
        my_strategies += user_stories(ally, 'strategies')
      end
    elsif !include_allies && user.id != current_user.id
      my_moments = user_stories(user, 'moments')
      my_strategies = user_stories(user, 'strategies')
    end

    moments = Moment.where(id: my_moments.map(&:id)).order(created_at: :desc)
    strategies = Strategy.where(id: my_strategies.map(&:id))
                         .order(created_at: :desc)

    stories =
      if moments.count.positive?
        moments.zip(strategies).flatten.compact
      else
        strategies.compact
      end

    stories.sort_by(&:created_at).reverse!
  end
  # rubocop:enable MethodLength

  private

  def user_stories(user, collection)
    case collection
    when 'moments'
      query = Moment.published
    when 'strategies'
      query = Strategy.published
    end

    query.where(user_id: user.id).all.recent.map do |story|
      story if story.viewers.include?(current_user.id)
    end.compact
  end
end
