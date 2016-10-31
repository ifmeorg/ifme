class NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy]

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def clear
    Notification.where(userid: current_user.id)&.destroy_all
    render nothing: true
  end

  def fetch_notifications
    result = { fetch_notifications: Notification.where(userid: current_user.id).order('created_at ASC').all }
    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  def signed_in
    signed_in = if !user_signed_in?
                  -1
                else
                  current_user.id
                end
    result = { signed_in: signed_in }
    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  rescue
    if @notification.blank?
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end
  end

  def notification_params
    params.require(:notification).permit(:name, :description, :userid)
  end
end
