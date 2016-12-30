module Comments
  class MeetingService < BaseService
    def delete
      is_my_comment = comment.comment_by == current_user.id

      if comment.present?
        meeting_id = comment.commented_on
        is_my_meeting = klass.where(meetingid: meeting_id, userid: current_user.id, leader: true).exists?
        is_member = klass.where(meetingid: meeting_id, userid: current_user.id).exists?
      else
        is_my_meeting = false
        is_member = false
      end

      if comment.present? && ((is_my_comment && is_member) || is_my_meeting)
        comment.destroy

        public_id = "comment_on_meeting_#{comment.id}"
        Notification.where(uniqueid: public_id).destroy_all
      end
    end

    def klass
      MeetingMember
    end
  end
end
