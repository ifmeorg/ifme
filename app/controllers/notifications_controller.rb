# frozen_string_literal: true

class NotificationsController < ApplicationController
  include NotificationsHelper
  before_action :set_notification, only: [:destroy]

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy if @notification.present?

    respond_to do |format|
      format.html { redirect_back(fallback_location: notifications_path) }
      format.json { head :no_content }
    end
  end

  def clear
    Notification.where(user_id: current_user.id).destroy_all
    head :ok
  end

  def fetch_notifications
    result = Notification.where(user_id: current_user.id)
                         .order(:created_at)
    respond_with_json(
      fetch_notifications: result.map { |item| render_notification(item) }
    )
  end

  def signed_in
    respond_with_json(signed_in: current_user.id)
  end

  private

  def convert_to_hash(string_obj)
    hash = {}
    JSON.parse(string_obj).each do |item|
      hash[item.first.to_sym] = item.second
    end
    hash
  end

  # rubocop:disable MethodLength
  def render_notification(notification)
    uniqueid = notification[:uniqueid]
    data = convert_to_hash(notification[:data])
    if data[:type].include? 'comment'
      comment_link(uniqueid, data)
    elsif data[:type].include? 'accepted_ally_request'
      accepted_ally_link(uniqueid, data)
    elsif data[:type].include? 'new_ally_request'
      new_ally_request_link(uniqueid, data)
    elsif data[:type].include? 'group'
      group_link(uniqueid, data)
    elsif data[:type].include? 'meeting'
      meeting_link(uniqueid, data)
    end
  end
  # rubocop:enable MethodLength

  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find_by(
      id: params[:id],
      user_id: current_user.id
    )
  end
end
