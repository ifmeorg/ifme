module Comments
  class MeetingService < BaseService
    def initialize(params = {})
      super(params)

      @klass = Meeting
      @keys = %w(comment_on_meeting)
    end

    def create
      @comment = Comment.new(params.merge(visibility: 'all'))

      # Notify MeetingMembers except for commenter that there is a new comment
      MeetingMember.where(meetingid: @comment.commented_on).all.each do |member|
        next unless member.userid != current_user.id

        do_the_job!(@keys.first, member.userid)
      end

      @comment.save
    end

    def can_delete_comment?
      return false unless comment.present?

      meeting_id = comment.commented_on
      user_meetings = current_user.meeting_members.where(meetingid: meeting_id)
      is_my_meeting = user_meetings.where(leader: true).exists?

      current_user_comment? && user_meetings.exists? || is_my_meeting
    end

    private

    def generate_data(name, uniqueid, type)
      JSON.generate(user: current_user.name,
                    meetingid: @comment.commented_on,
                    meeting: name,
                    commentid: @comment.id,
                    comment: @comment.comment[0..80],
                    cutoff: @comment.comment.size > 80,
                    type: type,
                    uniqueid: uniqueid)
    end
  end
end
