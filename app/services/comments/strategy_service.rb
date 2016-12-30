module Comments
  class StrategyService < BaseService

    def delete
      # TODO: refactor this method to part of it be placed on father.

      is_my_comment = comment.comment_by == current_user.id

      if comment.present?
        strategy_id = comment.commented_on
        is_my_strategy = klass.where(id: strategy_id, userid: current_user.id).exists?
      else
        is_my_strategy = false
      end

      if comment.present? && (is_my_comment || is_my_strategy)
        comment.destroy

        public_id = "comment_on_strategy_#{comment.id}"
        private_id = "comment_on_strategy_private_#{comment.id}"

        Notification.where(uniqueid: [private_id, public_id]).destroy_all
      end
    end

    def klass
      Strategy
    end
  end
end
