module Comments
  class BaseService
    attr_reader :comment, :current_user

    def initialize(params: {}, comment: nil, user: nil, klass: nil)
      @params = params
      @comment = comment
      @current_user = user
      @klass = klass
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

    # All these methods need to be reviewed
    # - test this method from this place
    # - extract or remove this method from this place

    def send_notification(user, uniqueid, data)
      Notification.create(userid: user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: user).order('created_at ASC')
      Pusher['private-' + user.to_s]
        .trigger('new_notification', notifications: notifications)

      NotificationMailer.notification_email(user, data).deliver_now
    end

    def do_the_job!(key, user)
      name = klass.where(id: @comment.commented_on).first.name
      uniqueid = "#{key}_#{@comment.id}"

      data = generate_data(name, uniqueid, key)
      send_notification(user, uniqueid, data)
    end

    def can_add_comment_to
      check_params_for_create

      user = @klass.where(id: @comment.commented_on).first.userid
      users = User.where(id: @comment.viewers[0])

      comment_for_these(user, users)
    end

    def comment_for_these(user, users)
      if user != @comment.comment_by
        do_the_job!(@keys.first, user)
      elsif @comment.viewers.present? && users.exists?
        new_user = users.first.id

        do_the_job!(@keys.last, new_user)
      end
    end

    def check_params_for_create
      unless @params[:viewers].blank?
        @params.merge(visibility: 'private', viewers: [params[:viewers].to_i])
      end

      @comment = Comment.new(params)
    end
  end
end
