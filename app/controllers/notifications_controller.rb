class NotificationsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_notification, only: [:destroy]
  before_action :ensure_user_owns_notification!, only: [:destroy]

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
    Notification.where(userid: current_user.id).destroy_all if !Notification.where(userid: current_user.id).nil?
    render :nothing => true
  end

  def fetch_notifications
    result = { fetch_notifications: Notification.where(userid: current_user.id).order("created_at ASC").all }
    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  def signed_in
    if !user_signed_in?
      signed_in = -1
    else
      signed_in = current_user.id
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
      begin
        @notification = Notification.find(params[:id])
      rescue
        if @notification.blank?
          respond_to do |format|
            format.html { redirect_to :back }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:name, :description, :userid)
    end

    def if_not_signed_in
      if !user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
          format.json { head :no_content }
        end
      end
    end

    # Stops here if the signed in user is not the owner of
    # the notification set by :set_notification.
    def ensure_user_owns_notification!
      unless @notification.user == current_user
        render :nothing => true
      end
    end
end
