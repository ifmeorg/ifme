module Comments
  class MomentService < BaseService
    def initialize(params = {})
      super(params)

      @klass = Moment
      @keys = %w(comment_on_moment comment_on_moment_private)
    end

    def create
      can_add_comment_to

      @comment.save
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
