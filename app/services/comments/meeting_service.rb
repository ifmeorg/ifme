module Comments
  class MeetingService < BaseService
    def initialize(params = {})
      super(params)

      @keys = %w(comment_on_meeting)
    end

    def create
      @comment = Comment.new(comment_type: params[:comment_type],
                             commented_on: params[:commented_on],
                             comment_by: params[:comment_by],
                             comment: params[:comment],
                             visibility: 'all')

      unless @comment.save
        result = { no_save: true }
        respond_to do |format|
          format.html { render json: result }
          format.json { render json: result }
        end
      end

      # Notify MeetingMembers except for commenter that there is a new comment
      MeetingMember.where(meetingid: @comment.commented_on).all.each do |member|
        next unless member.userid != current_user.id
        meeting_name = Meeting.where(id: @comment.commented_on).first.name
        cutoff = false
        cutoff = true if @comment.comment.length > 80
        uniqueid = 'comment_on_meeting' + '_' + @comment.id.to_s

        data = JSON.generate(user: current_user.name,
                             meetingid: @comment.commented_on,
                             meeting: meeting_name,
                             commentid: @comment.id,
                             comment: @comment.comment[0..80],
                             cutoff: cutoff,
                             type: 'comment_on_meeting',
                             uniqueid: uniqueid)

        Notification.create(userid: member.userid, uniqueid: uniqueid, data: data)
        notifications = Notification.where(userid: member.userid).order('created_at ASC').all
        Pusher['private-' + member.userid.to_s].trigger('new_notification', notifications: notifications)

        NotificationMailer.notification_email(member.userid, data).deliver_now
      end

      if @comment.save
        result = generate_comment(@comment, 'meeting')
        respond_to do |format|
          format.html { render json: result }
          format.json { render json: result }
        end
      end
    end

    def can_delete_comment?
      return false unless comment.present?

      meeting_id = comment.commented_on
      user_meetings = current_user.meeting_members.where(meetingid: meeting_id)
      is_my_meeting = user_meetings.where(leader: true).exists?

      current_user_comment? && user_meetings.exists? || is_my_meeting
    end
  end
end
