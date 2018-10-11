# frozen_string_literal: true

class CommentService
  attr_reader :comment, :current_user

  def self.create(comment, current_user)
    new(comment, current_user).create
  end

  def self.delete(comment, current_user)
    new(comment, current_user).delete
  end

  def initialize(comment, current_user)
    @comment = comment
    @current_user = current_user
  end

  def create
    comment = Comment.create_from!(@comment)
    comment.notify_of_creation!(@current_user)
    comment[:id]
  end

  def delete
    if !@comment.nil? &&
       CommentViewersService.deletable(@comment, @current_user)
      CommentNotificationsService.remove(comment_id: @comment[:id],
                                         model_name:
                                          @comment[:commentable_type])
      @comment[:id]
    else
      raise ArgumentError
    end
  end
end
