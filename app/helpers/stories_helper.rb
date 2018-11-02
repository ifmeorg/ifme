# frozen_string_literal: true
module StoriesHelper
  def get_stories(user, include_allies = false)
    moments, strategies = get_user_stories(user, include_allies)
    combine_stories(moments, strategies)
  end

  private

  def combine_stories(moments, strategies)
    stories =
      if moments.any?
        moments.zip(strategies).flatten
      else
        strategies
      end
    stories.compact.sort_by(&:created_at).reverse!
  end

  def get_user_stories(user, include_allies)
    [
      user_stories(user.moments.recent, user, include_allies),
      user_stories(user.strategies.recent, user, include_allies)
    ]
  end

  def viewable_published_stories(scope)
    scope.published.select do |story|
      story.viewers.include?(current_user.id)
    end
  end

  def include_allies_in_stories(scope, user)
    user.allies_by_status(:accepted).each do |ally|
      scope_class = scope&.first&.class
      ally_scope = scope_class == Moment ? ally.moments : ally.strategies
      scope += viewable_published_stories(ally_scope)
    end
    scope
  end

  def user_stories(scope, user, include_allies)
    return viewable_published_stories(scope) unless current_user.id == user.id
    return scope unless include_allies

    include_allies_in_stories(scope, user)
  end
end
