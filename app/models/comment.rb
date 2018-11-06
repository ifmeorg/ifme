# frozen_string_literal: true
# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  comment_by       :integer
#  comment          :text
#  created_at       :datetime
#  updated_at       :datetime
#  visibility       :string
#  viewers          :text
#

class Comment < ApplicationRecord
  serialize :viewers, Array
  belongs_to :commentable, polymorphic: true

  validates :comment, length: { minimum: 0, maximum: 1000 }, presence: true
  validates :commentable_type, inclusion: %w[moment strategy meeting]
  validates :commentable_id, :comment_by, presence: true
  validates :visibility, inclusion: %w[all private]

  before_save :array_data

  def array_data
    return unless viewers.is_a?(Array)

    self.viewers = viewers.collect(&:to_i)
  end

  class << self
    def create_from!(params)
      viewers = params[:viewers].blank? ? [] : [params[:viewers].to_i]
      params[:visibility] = 'all' if params[:visibility].blank?
      Comment.create!(
        commentable_type: params[:commentable_type],
        commentable_id: params[:commentable_id],
        comment_by: params[:comment_by],
        comment: params[:comment],
        visibility: viewers.any? ? 'private' : params[:visibility],
        viewers: viewers
      )
    end

    def comments_from(data)
      Comment.where(
        commentable_id: data.id,
        commentable_type: data.class.name.downcase
      )
    end
  end

  # Notify commentable_id user that they have a new comment
  def notify_of_creation!(creator)
    association = associated_record
    return handle_meeting(association, creator) if commentable_type == 'meeting'
    return unless notify_of_creation?(association)

    send_notification!(creator, association, user_to_notify(association))
  end

  private

  def associated_record
    commentable_type.classify.constantize.find(commentable_id)
  end

  # Notify MeetingMembers except for commenter that there is a new comment
  def handle_meeting(association, creator)
    MeetingMember.where(meeting_id: commentable_id)
                 .where.not(user_id: creator.id)
                 .find_each do |member|
      data = notification_data(creator, association, type, unique_id(type))
      send_notification(data, notifications!(data, member.user_id),
                        member.user_id)
    end
  end

  def notification_data(creator, association, type, unique_id)
    {
      user: creator.name,
      commentid: id,
      comment: comment[0..80],
      cutoff: comment.length > 80,
      type: type,
      typeid: association.id,
      uniqueid: unique_id,
      typename: association.name
    }.to_json
  end

  def notifications!(data, user_id)
    Notification.create!(
      user_id: user_id,
      uniqueid: unique_id(type),
      data: data
    )
    model_data = Notification.where(user_id: user_id)
    model_data.order('created_at')
  end

  def notify_of_creation?(association)
    association.user_id != comment_by && association.viewers.include?(
      comment_by
    )
  end

  def send_notification(data, notifications, user_id)
    Pusher["private-#{user_id}"]
      .trigger('new_notification', notifications: notifications)
    NotificationMailer.notification_email(user_id, data).deliver_now
  end

  def send_notification!(creator, association, user_id)
    return if User.find(user_id).nil?

    data = notification_data(creator, association, type, unique_id(type))
    send_notification(data, notifications!(data, user_id), user_id)
  end

  def type
    "comment_on_#{commentable_type}#{visibility == 'private' ? '_private' : ''}"
  end

  def unique_id(type)
    "#{type}_#{id}"
  end

  def user_to_notify(association)
    association.user_id == comment_by ? viewers.first : association.user_id
  end
end
