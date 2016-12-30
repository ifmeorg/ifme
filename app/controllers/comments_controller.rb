class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  # WIP
  def create
    parameters = {
      comment_type: params[:comment_type], commented_on: params[:commented_on],
      comment_by: params[:comment_by], comment: params[:comment]
    }

    if params[:viewers].blank?
      parameters[:visibility] = params[:visibility]
    else
      parameters[:visibility] = 'private'
      parameters[:viewers] = [params[:viewers].to_i]
    end

    @comment = Comment.new(parameters)

    unless @comment.save
      result = { no_save: true }

      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end

    # Notify commented_on user that they have a new comment
    # strategy_user = Strategy.where(id: @comment.commented_on).first.userid

    # if strategy_user != @comment.comment_by
    #   strategy_name = Strategy.where(id: @comment.commented_on).first.name
    #   cutoff = @comment.comment.length > 80
    #   uniqueid = "comment_on_strategy_#{@comment.id}"
    #
    #   data = JSON.generate(user: current_user.name,
    #                        strategyid: @comment.commented_on,
    #                        strategy: strategy_name,
    #                        commentid: @comment.id,
    #                        comment: @comment.comment[0..80],
    #                        cutoff: cutoff,
    #                        type: 'comment_on_strategy',
    #                        uniqueid: uniqueid)
    #
    #   Notification.create(userid: strategy_user, uniqueid: uniqueid, data: data)
    #   notifications = Notification.where(userid: strategy_user).order('created_at ASC').all
    #   Pusher['private-' + strategy_user.to_s].trigger('new_notification', notifications: notifications)
    #
    #   NotificationMailer.notification_email(strategy_user, data).deliver_now
    #
    #   # Notify viewer that they have a new comment
    # elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
    #   private_user = User.where(id: @comment.viewers[0]).first.id
    #   strategy_name = Strategy.where(id: @comment.commented_on).first.name
    #   cutoff = false
    #   cutoff = true if @comment.comment.length > 80
    #   uniqueid = 'comment_on_strategy_private' + '_' + @comment.id.to_s
    #
    #   data = JSON.generate(user: current_user.name,
    #                        strategyid: @comment.commented_on,
    #                        strategy: strategy_name,
    #                        commentid: @comment.id,
    #                        comment: @comment.comment[0..80],
    #                        cutoff: cutoff,
    #                        type: 'comment_on_strategy_private',
    #                        uniqueid: uniqueid)
    #
    #   Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
    #   notifications = Notification.where(userid: private_user).order('created_at ASC').all
    #   Pusher['private-' + private_user.to_s].trigger('new_notification', notifications: notifications)
    #
    #   NotificationMailer.notification_email(private_user, data).deliver_now
    # end

    if @comment.save
      # generate_comment(@comment, 'strategy')

      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end
  end

  def destroy
    klass = params.fetch(:comment_type, 'base').camelize
    klass = "Comments::#{klass}Service".constantize
    klass.new(comment: @comment).delete

    render nothing: true
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  rescue
    if @comment.blank?
      respond_to do |format|
        format.html { render nothing: true }
        format.json { head :no_content }
      end
    end
  end
  # ---------------
  #
  # def comment_moment
  #   if params[:viewers].blank?
  #     @comment = Comment.new(comment_type: params[:comment_type], commented_on: params[:commented_on], comment_by: params[:comment_by], comment: params[:comment], visibility: params[:visibility])
  #   else
  #     # Can only get here if comment is from Moment creator
  #     @comment = Comment.new(comment_type: params[:comment_type], commented_on: params[:commented_on], comment_by: params[:comment_by], comment: params[:comment], visibility: 'private', viewers: [params[:viewers].to_i])
  #   end
  #
  #   if !@comment.save
  #     result = { no_save: true }
  #     respond_to do |format|
  #       format.html { render json: result }
  #       format.json { render json: result }
  #     end
  #   end
  #
  #   # Notify commented_on user that they have a new comment
  #   moment_user = Moment.where(id: @comment.commented_on).first.userid
  #
  #   if (moment_user != @comment.comment_by)
  #     moment_name = Moment.where(id: @comment.commented_on).first.name
  #     cutoff = false
  #     if @comment.comment.length > 80
  #       cutoff = true
  #     end
  #     uniqueid = 'comment_on_moment' + '_' + @comment.id.to_s
  #
  #     data = JSON.generate({
  #                            user: current_user.name,
  #                            momentid: @comment.commented_on,
  #                            moment: moment_name,
  #                            commentid: @comment.id,
  #                            comment: @comment.comment[0..80],
  #                            cutoff: cutoff,
  #                            type: 'comment_on_moment',
  #                            uniqueid: uniqueid
  #                          })
  #
  #     Notification.create(userid: moment_user, uniqueid: uniqueid, data: data)
  #     notifications = Notification.where(userid: moment_user).order("created_at ASC").all
  #     Pusher['private-' + moment_user.to_s].trigger('new_notification', {notifications: notifications})
  #
  #     NotificationMailer.notification_email(moment_user, data).deliver_now
  #
  #     # Notify viewer that they have a new comment
  #   elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
  #     private_user = User.where(id: @comment.viewers[0]).first.id
  #     moment_name = Moment.where(id: @comment.commented_on).first.name
  #     cutoff = false
  #     if @comment.comment.length > 80
  #       cutoff = true
  #     end
  #     uniqueid = 'comment_on_moment_private' + '_' + @comment.id.to_s
  #
  #     data = JSON.generate({
  #                            user: current_user.name,
  #                            momentid: @comment.commented_on,
  #                            moment: moment_name,
  #                            commentid: @comment.id,
  #                            comment: @comment.comment[0..80],
  #                            cutoff: cutoff,
  #                            type: 'comment_on_moment_private',
  #                            uniqueid: uniqueid
  #                          })
  #
  #     Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
  #     notifications = Notification.where(userid: private_user).order("created_at ASC").all
  #     Pusher['private-' + private_user.to_s].trigger('new_notification', {notifications: notifications})
  #
  #     NotificationMailer.notification_email(private_user, data).deliver_now
  #   end
  #
  #   if @comment.save
  #     result = generate_comment(@comment, 'moment')
  #     respond_to do |format|
  #       format.html { render json: result }
  #       format.json { render json: result }
  #     end
  #   end
  # end
  #
  # def comment_meeting
  #   @comment = Comment.new(:comment_type => params[:comment_type], :commented_on => params[:commented_on], :comment_by => params[:comment_by], :comment => params[:comment], :visibility => 'all')
  #
  #   if !@comment.save
  #     result = { no_save: true }
  #     respond_to do |format|
  #       format.html { render json: result }
  #       format.json { render json: result }
  #     end
  #   end
  #
  #   # Notify MeetingMembers except for commenter that there is a new comment
  #   MeetingMember.where(meetingid: @comment.commented_on).all.each do |member|
  #     if member.userid != current_user.id
  #       meeting_name = Meeting.where(id: @comment.commented_on).first.name
  #       cutoff = false
  #       if @comment.comment.length > 80
  #         cutoff = true
  #       end
  #       uniqueid = 'comment_on_meeting' + '_' + @comment.id.to_s
  #
  #       data = JSON.generate({
  #                              user: current_user.name,
  #                              meetingid: @comment.commented_on,
  #                              meeting: meeting_name,
  #                              commentid: @comment.id,
  #                              comment: @comment.comment[0..80],
  #                              cutoff: cutoff,
  #                              type: 'comment_on_meeting',
  #                              uniqueid: uniqueid
  #                            })
  #
  #       Notification.create(userid: member.userid, uniqueid: uniqueid, data: data)
  #       notifications = Notification.where(userid: member.userid).order("created_at ASC").all
  #       Pusher['private-' + member.userid.to_s].trigger('new_notification', {notifications: notifications})
  #
  #       NotificationMailer.notification_email(member.userid, data).deliver_now
  #     end
  #   end
  #
  #   if @comment.save
  #     result = generate_comment(@comment, 'meeting')
  #     respond_to do |format|
  #       format.html { render json: result }
  #       format.json { render json: result }
  #     end
  #   end
  # end
  #
  # def comment_strategy
  #   if params[:viewers].blank?
  #     @comment = Comment.new(:comment_type => params[:comment_type], :commented_on => params[:commented_on], :comment_by => params[:comment_by], :comment => params[:comment], :visibility => params[:visibility])
  #   else
  #     # Can only get here if comment is from Strategy creator
  #     @comment = Comment.new(:comment_type => params[:comment_type], :commented_on => params[:commented_on], :comment_by => params[:comment_by], :comment => params[:comment], :visibility => 'private', :viewers => [params[:viewers].to_i])
  #   end
  #
  #   if !@comment.save
  #     result = { no_save: true }
  #     respond_to do |format|
  #       format.html { render json: result }
  #       format.json { render json: result }
  #     end
  #   end
  #
  #   # Notify commented_on user that they have a new comment
  #   strategy_user = Strategy.where(id: @comment.commented_on).first.userid
  #
  #   if (strategy_user != @comment.comment_by)
  #     strategy_name = Strategy.where(id: @comment.commented_on).first.name
  #     cutoff = false
  #     if @comment.comment.length > 80
  #       cutoff = true
  #     end
  #     uniqueid = 'comment_on_strategy' + '_' + @comment.id.to_s
  #
  #     data = JSON.generate({
  #                            user: current_user.name,
  #                            strategyid: @comment.commented_on,
  #                            strategy: strategy_name,
  #                            commentid: @comment.id,
  #                            comment: @comment.comment[0..80],
  #                            cutoff: cutoff,
  #                            type: 'comment_on_strategy',
  #                            uniqueid: uniqueid
  #                          })
  #
  #     Notification.create(userid: strategy_user, uniqueid: uniqueid, data: data)
  #     notifications = Notification.where(userid: strategy_user).order("created_at ASC").all
  #     Pusher['private-' + strategy_user.to_s].trigger('new_notification', {notifications: notifications})
  #
  #     NotificationMailer.notification_email(strategy_user, data).deliver_now
  #
  #     # Notify viewer that they have a new comment
  #   elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
  #     private_user = User.where(id: @comment.viewers[0]).first.id
  #     strategy_name = Strategy.where(id: @comment.commented_on).first.name
  #     cutoff = false
  #     if @comment.comment.length > 80
  #       cutoff = true
  #     end
  #     uniqueid = 'comment_on_strategy_private' + '_' + @comment.id.to_s
  #
  #     data = JSON.generate({
  #                            user: current_user.name,
  #                            strategyid: @comment.commented_on,
  #                            strategy: strategy_name,
  #                            commentid: @comment.id,
  #                            comment: @comment.comment[0..80],
  #                            cutoff: cutoff,
  #                            type: 'comment_on_strategy_private',
  #                            uniqueid: uniqueid
  #                          })
  #
  #     Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
  #     notifications = Notification.where(userid: private_user).order("created_at ASC").all
  #     Pusher['private-' + private_user.to_s].trigger('new_notification', {notifications: notifications})
  #
  #     NotificationMailer.notification_email(private_user, data).deliver_now
  #   end
  #
  #   if @comment.save
  #     result = generate_comment(@comment, 'strategy')
  #     respond_to do |format|
  #       format.html { render json: result }
  #       format.json { render json: result }
  #     end
  #   end
  # end
end
