# frozen_string_literal: true

module Allyships
  class AllianceNotifier
    attr_reader :pusher_type, :ally_id, :current_user

    def initialize(args = {})
      @ally_id = args[:ally_id]
      @current_user = args[:current_user]
      @pusher_type = args[:pusher_type]
    end

    def self.perform(args = {})
      new(args).perform
    end

    def perform
      create_notification
      trigger_pusher
      send_notification_mailer
    end

    def unique_id
      "#{pusher_type}_#{current_user.id}"
    end

    def notifications
      @notifications ||= Notification.where(user_id: ally_id).order(:created_at)
    end

    def send_notification_mailer
      NotificationMailer
        .notification_email(ally_id, notification_data)
        .deliver_now
    end

    def trigger_pusher
      Pusher["private-#{ally_id}"]
        .trigger('new_notification', notifications: notifications)
    end

    def create_notification
      Notification.create(
        user_id: ally_id,
        uniqueid: unique_id,
        data: notification_data
      )
    end

    def notification_data
      { **user_data, **pusher_data }.to_json
    end

    def pusher_data
      {
        type: pusher_type,
        uniqueid: unique_id
      }
    end

    def user_data
      {
        user: current_user.name,
        user_id: current_user.id,
        uid: current_user.uid
      }
    end
  end
end
