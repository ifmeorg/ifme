module Comments
  class MomentService < BaseService
    def initialize(params = {})
      super(params)

      @keys = %w(comment_on_moment comment_on_moment_private)
    end

    def create
      if params[:viewers].blank?
        @comment = Comment.new(comment_type: params[:comment_type],
                               commented_on: params[:commented_on],
                               comment_by: params[:comment_by],
                               comment: params[:comment],
                               visibility: params[:visibility])
      else
        # Can only get here if comment is from Moment creator
        @comment = Comment.new(comment_type: params[:comment_type],
                               commented_on: params[:commented_on],
                               comment_by: params[:comment_by],
                               comment: params[:comment], visibility: 'private',
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
      moment_user = Moment.where(id: @comment.commented_on).first.userid

      if moment_user != @comment.comment_by
        moment_name = Moment.where(id: @comment.commented_on).first.name
        cutoff = false
        cutoff = true if @comment.comment.length > 80
        uniqueid = 'comment_on_moment' + '_' + @comment.id.to_s

        data = JSON.generate(user: current_user.name,
                             momentid: @comment.commented_on,
                             moment: moment_name,
                             commentid: @comment.id,
                             comment: @comment.comment[0..80],
                             cutoff: cutoff,
                             type: 'comment_on_moment',
                             uniqueid: uniqueid)

        Notification.create(userid: moment_user, uniqueid: uniqueid, data: data)
        notifications = Notification.where(userid: moment_user).order('created_at ASC').all
        Pusher['private-' + moment_user.to_s].trigger('new_notification', notifications: notifications)

        NotificationMailer.notification_email(moment_user, data).deliver_now

        # Notify viewer that they have a new comment
      elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
        private_user = User.where(id: @comment.viewers[0]).first.id
        moment_name = Moment.where(id: @comment.commented_on).first.name
        cutoff = false
        cutoff = true if @comment.comment.length > 80
        uniqueid = 'comment_on_moment_private' + '_' + @comment.id.to_s

        data = JSON.generate(user: current_user.name,
                             momentid: @comment.commented_on,
                             moment: moment_name,
                             commentid: @comment.id,
                             comment: @comment.comment[0..80],
                             cutoff: cutoff,
                             type: 'comment_on_moment_private',
                             uniqueid: uniqueid)

        Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
        notifications = Notification.where(userid: private_user).order('created_at ASC').all
        Pusher['private-' + private_user.to_s].trigger('new_notification', notifications: notifications)

        NotificationMailer.notification_email(private_user, data).deliver_now
      end

      if @comment.save
        result = generate_comment(@comment, 'moment')
        respond_to do |format|
          format.html { render json: result }
          format.json { render json: result }
        end
      end
    end

    def can_delete_comment?
      return false unless comment.present?

      moment = Moment.find_by(id: comment.commented_on)
      user_moment = moment.userid == current_user.id
      user_viewer = moment.viewers.include? current_user.id

      current_user_comment? && user_viewer || user_moment
    end
  end
end
