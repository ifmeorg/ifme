class NotificationsController < ApplicationController
  before_action :set_notification, only: :destroy

  def destroy
    notification = current_user.notifications.find_by(id: params[:id])
    notification.destroy if notification.present?

    respond_to_nothing
  end

  def clear
    current_user.notifications.destroy_all

    render nothing: true
  end

  def fetch_notifications
    result = {
      fetch_notifications: current_user.notifications.order(created_at: :asc)
    }

    respond_with_json(result)
  end

  def signed_in
    respond_with_json(signed_in: current_user.id)
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  rescue
    respond_to_nothing if @notification.blank?
  end

  def notification_params
    params.require(:notification).permit(:name, :description, :userid)
  end

  def respond_with_json(result)
    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end
end
