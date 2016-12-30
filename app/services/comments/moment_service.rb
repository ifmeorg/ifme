module Comments
  class MomentService < BaseService
    def delete
      is_my_comment = comment.comment_by == current_user.id

      if comment.present?
        moment_id = comment.commented_on
        is_my_moment = klass.where(id: moment_id, userid: current_user.id).exists?
        is_a_viewer = is_viewer(klass.find_by(id: moment_id).viewers)
      else
        is_my_moment = false
        is_a_viewer = false
      end

      if comment.present? && ((is_my_comment && is_a_viewer) || is_my_moment)
        comment.destroy

        public_id = "comment_on_moment_#{comment.id}"
        private_id = "comment_on_moment_private_#{comment.id}"

        Notification.where(uniqueid: [private_id, public_id]).destroy_all
      end
    end

    def klass
      Moment
    end

    private

    def is_viewer(viewers)
      return true if viewers.include? current_user.id

      false
    end
  end
end
