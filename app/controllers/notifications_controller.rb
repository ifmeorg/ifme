class NotificationsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_notification, only: [:destroy]

  # GET /notifications/new
  def new
    @notification = Notification.new
    @page_title = "New Notification"
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)
    @page_title = "New Notification"
    respond_to do |format|
      if @notification.save
        format.html { redirect_to params[:refresh] }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to params[:refresh] }
      format.json { head :no_content }
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
            format.html { redirect_to params[:refresh] }
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
end
