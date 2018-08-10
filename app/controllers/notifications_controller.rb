# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy]

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    notification = Notification.find_by(
      id: params[:id],
      user_id: current_user.id
    )

    notification.destroy if notification.present?

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
    result = {
      fetch_notifications: Notification.where(user_id: current_user.id)
                                       .order(:created_at)
    }
    respond_with_json(result)
  end

  def signed_in
    respond_with_json(signed_in: current_user.id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # rubocop:disable RescueStandardError
  def set_notification
    @notification = Notification.find(params[:id])
  rescue
    respond_to do |format|
      format.html { redirect_back(fallback_location: notifications_path) }
      format.json { head :no_content }
    end
  end
  # rubocop:enable RescueStandardError
end
