module Comments
  class StrategyService < BaseService
    def initialize(params = {})
      super(params)

      @klass = Strategy
      @keys = %w(comment_on_strategy comment_on_strategy_private)
    end

    def create
      can_add_comment_to

      @comment.save
    end

    def can_delete_comment?
      return false unless comment.present?

      strategy_id = comment.commented_on
      is_my_strategy = current_user.strategies.where(id: strategy_id).exists?

      current_user_comment? || is_my_strategy
    end
  end
end
