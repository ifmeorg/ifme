module Comments
  class BaseService
    attr_reader :comment, :current_user

    def initialize(params: {}, comment: nil, user: nil)
      @params = params
      @comment = comment
      @current_user = user
    end

    def create; end

    def delete
      return unless can_delete_comment?

      comment.destroy
      drop_notifications_from_keys
    end

    protected

    def drop_notifications_from_keys
      Notification.where(uniqueid: keys).destroy_all
    end

    def keys
      @keys.map { |item| "#{item}_#{comment.id}" }
    end

    def current_user_comment?
      comment.comment_by == current_user.id
    end

    def can_delete_comment?
      raise 'Not Implemented yet'
    end
  end
end
