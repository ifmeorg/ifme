# frozen_string_literal: true

class CommentViewersService
  attr_reader :comment, :owner, :current_user, :commentable_viewers, :commentable

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
    @comment = comment
    @commentable = get_commentable(comment)
    # Use &. to avoid crashes if commentable or user is nil
    @owner = User.find_by(id: @commentable.try(:user_id))
    @commentable_viewers = @commentable.try(:viewers) || @commentable.try(:members)&.pluck(:id) || []
    @current_user = current_user
  end

  def viewers
    # Added visibility check for "all" to return nil (matches generate_comments expectation)
    return if @comment.visibility == 'all'
    return unless viewable?

    # Ensure we have an "other_person" to show in the string
    person = other_person
    return unless person

    I18n.t('shared.comments.visible_only_between_you_and',
           name: person.name)
  end

  def viewable?
    # Defensive check for nil comment_by or user
    return false if user_banned?

    current_user_comment? || commentable_owner? || viewer?
  end

  def deletable?
    # Defensive check
    return false if user_banned?

    current_user_comment? || commentable_owner?
  end

  private

  def user_banned?
    # Added &. to prevent NoMethodError on nil user
    User.find_by(id: @comment.comment_by)&.banned || false
  end

  def other_person
    # If I am the owner of the Moment/Strategy
    if commentable_owner?
      # Show the name of the person who commented (if private)
      # or the person targeted in the private viewers list
      target_id = @comment.viewers&.first || @comment.comment_by
      User.find_by(id: target_id)
    else
      # If I am a viewer, the "other person" in a private chat is the owner
      @owner
    end
  end

  def commentable_owner?
    return false unless @current_user && (@owner || @commentable)

    # Case-insensitive check for 'Meeting'
    if @comment.commentable_type.casecmp?('meeting')
      return @commentable.respond_to?(:led_by?) && @commentable.led_by?(@current_user)
    end

    @owner&.id == @current_user.id
  end

  def current_user_comment?
    @comment.comment_by == @current_user.id
  end

  def comment_viewer?
    # Ensure viewers is an array before calling include?
    Array(@comment.viewers).include?(@current_user.id)
  end

  def commentable_viewer?
    @comment.visibility == 'all' &&
      @commentable_viewers.include?(@current_user.id)
  end

  def viewer?
    comment_viewer? || commentable_viewer?
  end

  def get_commentable(comment)
    # Memoize so we don't hit the DB repeatedly
    @get_commentable ||= begin
      model = comment.commentable_type.classify.constantize
      model.find_by(id: comment.commentable_id)
    end
  end
end
