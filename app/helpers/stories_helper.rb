# frozen_string_literal: true
module StoriesHelper
  def get_stories(user)
    moments, strategies = get_user_stories(user)
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

  def get_user_stories(user)
    [
      user_stories(user.moments.recent, user),
      user_stories(user.strategies.recent, user)
    ]
  end

  def viewable_published_stories(scope)
    scope.published.select do |story|
      story.viewers.include?(current_user.id)
    end
  end

  def user_stories(scope, user)
    return viewable_published_stories(scope) unless current_user.id == user.id

    user.allies_by_status(:accepted).each do |ally|
      scope_class = scope&.first&.class
      ally_scope = scope_class == Moment ? ally.moments : ally.strategies
      scope += viewable_published_stories(ally_scope)
    end
    scope
  end
end
