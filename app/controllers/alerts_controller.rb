class AlertsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.where(:userid => current_user.id).all
    @page_title = "Alerts"
    @page_new = new_alert_path
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show
    if current_user.id == @alert.userid
      @page_title = @alert.name
      @page_edit = edit_alert_path(@alert)
    else 
      respond_to do |format|
        format.html { redirect_to alerts_path }
        format.json { head :no_content }
      end
    end
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
    @page_title = "New Alert"
  end

  # GET /alerts/1/edit
  def edit
    if current_user.id == @alert.userid
      @page_title = "Edit " + @alert.name 
    else 
      respond_to do |format|
        format.html { redirect_to alert_path(@alert) }
        format.json { head :no_content }
      end
    end
  end

  # POST /alerts
  # POST /alerts.json
  def create
    @alert = Alert.new(alert_params)

    respond_to do |format|
      if @alert.save

        AlertMailer.alert_email(current_user).deliver
        format.html { redirect_to alert_path(@alert), notice: 'Alert was successfully created.' }
        format.json { render :show, status: :created, location: @alert }
      else
        format.html { render :new }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alerts/1
  # PATCH/PUT /alerts/1.json
  def update
    respond_to do |format|
      if @alert.update(alert_params)
        format.html { redirect_to alert_path(@alert), notice: 'Alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @alert }
      else
        format.html { render :edit }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to alerts_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      begin
        @alert = Alert.find(params[:id])
      rescue
        if @alert.blank?
          respond_to do |format|
            format.html { redirect_to alerts_path }
            format.json { head :no_content }
          end
        end 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_params
      params.require(:alert).permit(:userid, :trigger, :medication, :message, :means, :days, :name, :time_hour, :time_minute, :time_period)
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
