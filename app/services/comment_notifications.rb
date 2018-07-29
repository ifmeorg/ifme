# frozen_string_literal: true

class CommentNotifications
  attr_reader :comment_id, :model_name

  def initialize(args)
    @comment_id = args[:comment_id]
    @model_name = args[:model_name]
  end

  def self.remove(args = {})
    new(args).remove
  end

  def remove
    Comment.find(comment_id).destroy
    public_uniqueid = "comment_on_#{model_name}_#{comment_id}"
    Notification.where(uniqueid: public_uniqueid).destroy_all
    private_uniqueid = "comment_on_#{model_name}_private_#{comment_id}"
    Notification.where(uniqueid: private_uniqueid).destroy_all
  end
end
