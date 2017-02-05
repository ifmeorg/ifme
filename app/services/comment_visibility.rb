class CommentVisibility
  attr_reader :comment, :owner, :current_user

  def self.build(comment, commented_on, current_user)
    new(comment, commented_on, current_user).build
  end

  def initialize(comment, commented_on, current_user)
    @comment = comment
    @owner = User.find(commented_on.userid)
    @current_user = current_user
  end

  def build
    return unless should_show_visibility?
    I18n.t('shared.comments.visible_only_between_you_and',
           name: other_person.name)
  end

  private

  def should_show_visibility?
    @comment.visibility == 'private' && logged_in_user_can_view_comment?
  end

  def other_person
    if logged_in_as_owner?
      if (viewer = User.where(id: @comment.viewers[0]).first)
        # you are logged in as owner, you made the comment,
        # and it is visible to a viewer
        viewer
      else
        # you are logged in as owner, and comment was made by somebody else
        User.find(@comment.comment_by)
      end
    else
      # you are logged in as comment maker, and it is visible to you and owner
      @owner
    end
  end

  def logged_in_as_owner?
    @owner.id == @current_user.id
  end

  def logged_in_user_made_comment?
    @comment.comment_by == @current_user.id
  end

  def logged_in_user_is_viewer?
    !@comment.viewers.blank? && @comment.viewers.include?(@current_user.id)
  end

  def logged_in_user_can_view_comment?
    logged_in_user_made_comment? || logged_in_as_owner? ||
      logged_in_user_is_viewer?
  end
end
