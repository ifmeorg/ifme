# frozen_string_literal: true

class AlliesController < ApplicationController
  # GET /allies
  # GET /allies.json
  def index
    @page_search = true
    @accepted_allies = current_user.allies_by_status(:accepted)
                                   .sort_by! { |n| n.name.downcase }
    @incoming_ally_requests = current_user.allies_by_status(:pending_from_user)
                                          .sort_by! { |n| n.name.downcase }
    @outgoing_ally_requests = current_user.allies_by_status(:pending_from_ally)
                                          .sort_by! { |n| n.name.downcase }
  end

  def add
    ally_id = params[:ally_id]
    allyship = Allyship.find_by(
      user_id: current_user.id, ally_id: ally_id
    )

    if allyship
      allyship.update(status: User::ALLY_STATUS[:accepted])

      # Notify the user who made the request
      pusher_type = 'accepted_ally_request'

      # Get rid of original new_ally_request notification
      Notification.where(
        userid: current_user.id,
        uniqueid: "new_ally_request_#{ally_id}"
      ).destroy_all
    else
      Allyship.create(
        user_id: current_user.id,
        ally_id: ally_id,
        status: User::ALLY_STATUS[:pending_from_ally]
      )

      # Notify the user the request has been made to
      pusher_type = 'new_ally_request'
    end

    uniqueid = "#{pusher_type}_#{current_user.id}"
    data = JSON.generate(
      user: current_user.name,
      userid: current_user.id,
      uid: current_user.uid,
      type: pusher_type,
      uniqueid: uniqueid
    )

    Notification.create(
      userid: ally_id,
      uniqueid: uniqueid,
      data: data
    )

    notifications = Notification.where(userid: ally_id).order(:created_at)
    Pusher["private-#{ally_id}"]
      .trigger('new_notification', notifications: notifications)

    NotificationMailer.notification_email(ally_id, data).deliver_now

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def remove
    user_id = current_user.id
    ally_id = params[:ally_id].to_i

    # Destroy allyship
    Allyship.where(user_id: user_id, ally_id: ally_id).destroy_all

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
