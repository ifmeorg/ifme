# frozen_string_literal: true
module StoriesHelper
  def get_stories(user, include_allies = false)
    moments, strategies =
      if user == current_user
        get_current_user_stories(user, include_allies)
      else
        get_user_stories(user)
      end
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

  def user_objects(user, model_object, include_allies)
    if include_allies
      user.allies_by_status(:accepted).each do |ally|
        model_object += user_stories(ally, model_object.class)
      end
    end
    model_object
  end

  def get_current_user_stories(user, include_allies)
    [
      Moment.where(
        id: user_objects(user, user.moments.recent, include_allies).map(&:id)
      ),
      Strategy.where(
        id: user_objects(user, user.strategies.recent, include_allies).map(&:id)
      )
    ]
  end

  def get_user_stories(user)
    [
      Moment.where(id: user_stories(user, Moment).map(&:id)),
      Strategy.where(id: user_stories(user, Strategy).map(&:id))
    ]
  end

  def user_stories(user, scope)
    scope.published.where(user_id: user.id).recent.select do |story|
      story.viewers.include?(current_user.id)
    end
  end
end
