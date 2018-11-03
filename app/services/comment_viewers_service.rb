# frozen_string_literal: true

class CommentViewersService
  attr_reader :comment, :owner, :current_user, :commentable_viewers

  def self.viewers(comment, current_user)
    new(comment, current_user).viewers
  end

  def self.viewable?(comment, current_user)
    new(comment, current_user).viewable?
  end

  def self.deletable?(comment, current_user)
    new(comment, current_user).deletable?
  end

  def initialize(comment, current_user)
    commentable = get_commentable(comment)
    @comment = comment
    @owner = commentable[:user_id] && User.find(commentable[:user_id])
    @commentable_viewers =
      unless commentable.nil?
        commentable[:viewers] || commentable.members&.pluck(:id)
      end
    @current_user = current_user
  end

  def viewers
    return unless @comment.visibility == 'private' && viewable?

    I18n.t('shared.comments.visible_only_between_you_and',
           name: other_person.name)
  end

  def viewable?
    !user_banned? &&
      (current_user_comment? || commentable_owner? ||
        viewer?)
  end

  def deletable?
    current_user_comment? || commentable_owner?
  end

  private

  def user_banned?
    User.find_by(id: @comment.comment_by).banned
  end

  def other_person
    return @owner unless commentable_owner?

    User.find_by(id: @comment.viewers.first) ||
      User.find_by(id: @comment.comment_by)
  end

  def commentable_owner?
    if @comment.commentable_type == 'meeting'
      meeting = Meeting.find_by(id: @comment.commentable_id)
      return meeting&.led_by?(current_user)
    end

    @owner.id == @current_user.id
  end

  def current_user_comment?
    @comment.comment_by == @current_user.id
  end

  def comment_viewer?
    @comment.viewers.present? && @comment.viewers.include?(@current_user.id)
  end

  def commentable_viewer?
    @comment.visibility == 'all' &&
      @commentable_viewers.include?(@current_user.id)
  end

  def viewer?
    comment_viewer? || commentable_viewer?
  end

  def get_commentable(comment)
    model = comment.commentable_type.classify.constantize
    model.find(comment.commentable_id)
  end
end
