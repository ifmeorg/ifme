# frozen_string_literal: true

class CommentViewers
  attr_reader :comment, :owner, :current_user, :data_viewers

  def self.build(comment, data, current_user)
    new(comment, data, current_user).build
  end

  def self.current_user_viewable(comment, data, current_user)
    new(comment, data, current_user).current_user_viewable
  end

  def initialize(comment, data, current_user)
    @comment = comment
    @owner = data[:user_id] && User.find(data[:user_id])
    @data_viewers = data[:viewers]
    @current_user = current_user
  end

  def build
    return unless should_show_visibility?

    I18n.t('shared.comments.visible_only_between_you_and',
           name: other_person.name)
  end

  def current_user_viewable
    logged_in_user_can_view_comment?
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

  def logged_in_user_is_comment_viewer?
    @comment.viewers.present? && @comment.viewers.include?(@current_user.id)
  end

  def logged_in_user_is_data_viewer?
    @comment.visibility == 'all' && @data_viewers.include?(@current_user.id)
  end

  def logged_in_user_is_viewer?
    logged_in_user_is_comment_viewer? || logged_in_user_is_data_viewer?
  end

  def logged_in_user_can_view_comment?
    logged_in_user_made_comment? || logged_in_as_owner? ||
      logged_in_user_is_viewer?
  end
end
