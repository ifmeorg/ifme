module Comments
  class StrategyService < BaseService
    def initialize(params = {})
      super(params)

      @keys = %w(comment_on_strategy comment_on_strategy_private)
    end

    def create
      if params[:viewers].blank?
        @comment = Comment.new(comment_type: params[:comment_type],
                               commented_on: params[:commented_on],
                               comment_by: params[:comment_by],
                               comment: params[:comment],
                               visibility: params[:visibility])
      else
        # Can only get here if comment is from Strategy creator
        @comment = Comment.new(comment_type: params[:comment_type],
                               commented_on: params[:commented_on],
                               comment_by: params[:comment_by],
                               comment: params[:comment],
                               visibility: 'private',
                               viewers: [params[:viewers].to_i])
      end

      unless @comment.save
        result = { no_save: true }
        respond_to do |format|
          format.html { render json: result }
          format.json { render json: result }
        end
      end

      # Notify commented_on user that they have a new comment
      strategy_user = Strategy.where(id: @comment.commented_on).first.userid

      if strategy_user != @comment.comment_by
        strategy_name = Strategy.where(id: @comment.commented_on).first.name
        cutoff = false
        cutoff = true if @comment.comment.length > 80
        uniqueid = 'comment_on_strategy' + '_' + @comment.id.to_s

        data = JSON.generate(user: current_user.name,
                             strategyid: @comment.commented_on,
                             strategy: strategy_name,
                             commentid: @comment.id,
                             comment: @comment.comment[0..80],
                             cutoff: cutoff,
                             type: 'comment_on_strategy',
                             uniqueid: uniqueid)

        Notification.create(userid: strategy_user, uniqueid: uniqueid, data: data)
        notifications = Notification.where(userid: strategy_user).order('created_at ASC').all
        Pusher['private-' + strategy_user.to_s].trigger('new_notification', notifications: notifications)

        NotificationMailer.notification_email(strategy_user, data).deliver_now

        # Notify viewer that they have a new comment
      elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
        private_user = User.where(id: @comment.viewers[0]).first.id
        strategy_name = Strategy.where(id: @comment.commented_on).first.name
        cutoff = false
        cutoff = true if @comment.comment.length > 80
        uniqueid = 'comment_on_strategy_private' + '_' + @comment.id.to_s

        data = JSON.generate(user: current_user.name,
                             strategyid: @comment.commented_on,
                             strategy: strategy_name,
                             commentid: @comment.id,
                             comment: @comment.comment[0..80],
                             cutoff: cutoff,
                             type: 'comment_on_strategy_private',
                             uniqueid: uniqueid)

        Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
        notifications = Notification.where(userid: private_user).order('created_at ASC').all
        Pusher['private-' + private_user.to_s].trigger('new_notification', notifications: notifications)

        NotificationMailer.notification_email(private_user, data).deliver_now
      end

      if @comment.save
        result = generate_comment(@comment, 'strategy')
        respond_to do |format|
          format.html { render json: result }
          format.json { render json: result }
        end
      end
    end

    def can_delete_comment?
      return false unless comment.present?

      strategy_id = comment.commented_on
      is_my_strategy = current_user.strategies.where(id: strategy_id).exists?

      current_user_comment? || is_my_strategy
    end
  end
end
