# frozen_string_literal: true

class CommentNotificationsService
  attr_reader :comment_id, :model_name

  def initialize(comment_id:, model_name:)
    @comment_id = comment_id
    @model_name = model_name
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
