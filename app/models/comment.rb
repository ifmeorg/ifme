# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment_type :string
#  commented_on :integer
#  comment_by   :integer
#  comment      :text
#  created_at   :datetime
#  updated_at   :datetime
#  visibility   :string
#  viewers      :text
#

class Comment < ApplicationRecord
  serialize :viewers, Array
  validates :comment, length: { minimum: 0, maximum: 1000 }
  validates :comment_type, :commented_on, :comment_by, :comment, presence: true
  validates :comment_type, inclusion: %w[moment strategy meeting]
  validates :visibility, inclusion: %w[all private]
  before_save :array_data

  def array_data
    return unless viewers.is_a?(Array)
    self.viewers = viewers.collect(&:to_i)
  end

  class << self
    def create_from!(params)
      viewers = params[:viewers].blank? ? [] : [params[:viewers].to_i]

      Comment.create!(
        comment_type: params[:comment_type],
        commented_on: params[:commented_on],
        comment_by: params[:comment_by],
        comment: params[:comment],
        visibility: viewers.any? ? 'private' : params[:visibility],
        viewers: viewers
      )
    end
  end

  # Notify commented_on user that they have a new comment
  def notify_of_creation!(creator)
    association = associated_record
    return unless notify_of_creation?(association)

    send_notification!(
      comment_type,
      creator,
      association,
      association.userid == comment_by ? viewers.first : association.userid,
      private: association.userid == comment_by
    )
  end

  private

  def associated_record
    comment_type.classify.constantize.find(commented_on)
  end

  def notify_of_creation?(association)
    association.userid != comment_by || viewers.first
  end

  def send_notification!(comment_type, creator, association, user_id,
                         private: false)
    return unless User.find_by(id: user_id).exists?

    type = "comment_on_#{comment_type}#{private ? '_private' : ''}"
    unique_id = "#{type}_#{id}"
    data = notification_data(creator, association, type, unique_id)

    Notification.create!(userid: user_id, uniqueid: unique_id, data: data)

    notifications = Notification.where(userid: user_id).order(:created_at)
    Pusher["private-#{userid}"]
      .trigger('new_notification', notifications: notifications)

    NotificationMailer.notification_email(user_id, data).deliver_now
  end

  def notification_data(creator, association, type, unique_id)
    JSON.generate(
      user: creator.name,
      momentid: association.id,
      moment: association.name,
      commentid: id,
      comment: comment[0..80],
      cutoff: comment.length > 80,
      type: type,
      uniqueid: unique_id
    )
  end
end
