# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
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
  validates :commentable_type, :commentable_id, :comment_by, presence: true
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
        commentable_type: params[:commentable_type],
        commentable_id: params[:commentable_id],
        comment_by: params[:comment_by],
        comment: params[:comment],
        visibility: viewers.any? ? 'private' : params[:visibility],
        viewers: viewers
      )
    end
  end

  # Notify commentable_id user that they have a new comment
  def notify_of_creation!(creator)
    association = associated_record

    if commentable_type == 'meeting'
      handle_for_meeting(association, creator)
    else
      return unless notify_of_creation?(association)

      send_notification!(
        commentable_type,
        creator,
        association,
        association.userid == comment_by ? viewers.first : association.userid,
        private: association.userid == comment_by
      )
    end
  end

  private

  def associated_record
    commentable_type.classify.constantize.find(commentable_id)
  end

  def notify_of_creation?(association)
    association.userid != comment_by && association.viewers.include?(comment_by)
  end

  def send_notification!(commentable_type, creator, association, user_id,
                         private: false)
    return if User.find(user_id).nil?

    type = "comment_on_#{commentable_type}#{private ? '_private' : ''}"
    unique_id = "#{type}_#{id}"
    data = notification_data(creator, association, type, unique_id)

    Notification.create!(userid: user_id, uniqueid: unique_id, data: data)

    notifications = Notification.where(userid: user_id).order(:created_at)
    Pusher["private-#{user_id}"]
      .trigger('new_notification', notifications: notifications)

    NotificationMailer.notification_email(user_id, data).deliver_now
  end

  def notification_data(creator, association, type, unique_id)
    json = {
      user: creator.name,
      commentid: id,
      comment: comment[0..80],
      cutoff: comment.length > 80,
      type: type,
      uniqueid: unique_id
    }
    case commentable_type
    when 'moment'
      json[:momentid] = association.id
      json[:moment] = association.name
    when 'strategy'
      json[:strategyid] = association.id
      json[:strategy] = association.name
    else
      json[:meetingid] = association.id
      json[:meeting] = association.name
    end
    JSON.generate(json)
  end

  # TODO: More reactoring
  # Notify MeetingMembers except for commenter that there is a new comment
  def handle_for_meeting(association, creator)
    MeetingMember.where(meetingid: commentable_id).all.each do |member|
      next if member.userid == creator.id

      meeting_name = Meeting.where(id: commentable_id).first.name
      cutoff = false
      cutoff = true if comment.length > 80
      uniqueid = "comment_on_meeting_#{id.to_s}"

      data = notification_data(creator, association, 'comment_on_meeting', uniqueid)

      Notification.create(userid: member.userid, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: member.userid).order('created_at ASC').all
      Pusher["private-#{member.userid.to_s}"].trigger('new_notification', notifications: notifications)

      NotificationMailer.notification_email(member.userid, data).deliver_now
    end
  end
end
