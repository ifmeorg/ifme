# frozen_string_literal: true

module StoriesHelper
  # rubocop:disable MethodLength
  def get_stories(user, include_allies)
    moments, strategies =
      if user == current_user
        get_current_user_stories(user, include_allies)
      else
        get_user_stories(user, include_allies)
      end

    stories =
      if moments.any?
        moments.zip(strategies).flatten
      else
        strategies
      end

    stories.compact.sort_by(&:created_at).reverse!
  end
  # rubocop:enable MethodLength

  private

  # rubocop:disable MethodLength
  def get_current_user_stories(user, include_allies)
    user_moments = user.moments.all.recent
    user_strategies = user.strategies.all.recent

    if include_allies
      user.allies_by_status(:accepted).each do |ally|
        user_moments += user_stories(ally, Moment)
        user_strategies += user_stories(ally, Strategy)
      end
    end

    [
      Moment.where(id: user_moments.map(&:id)),
      Strategy.where(id: user_strategies.map(&:id))
    ]
  end
  # rubocop:enable MethodLength

  def get_user_stories(user, include_allies)
    return [Moment.none, Strategy.none] unless include_allies

    user_moments = user_stories(user, Moment)
    user_strategies = user_stories(user, Strategy)

    [
      Moment.where(id: user_moments.map(&:id)),
      Strategy.where(id: user_strategies.map(&:id))
    ]
  end

  def user_stories(user, scope)
    scope.published.where(user_id: user.id).recent.select do |story|
      story.viewers.include?(current_user.id)
    end
  end
end
