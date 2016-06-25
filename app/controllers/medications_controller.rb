require "google/api_client"

class MedicationsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  # GET /medications
  # GET /medications.json
  def index
    name = params[:search]
    search = Medication.where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      @medications = search.order("created_at DESC").page(params[:page]).per($per_page)
    else
      @medications = Medication.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page]).per($per_page)
    end
    @page_title = "Medications"
    @page_new = new_medication_path
    @page_tooltip = "New medication"
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
    if @medication.userid == current_user.id
      @page_title = @medication.name
      @page_edit = edit_medication_path(@medication)
      @page_tooltip = "Edit medication"
    else
      respond_to do |format|
        format.html { redirect_to medications_path }
        format.json { head :no_content }
      end
    end
  end

  # GET /medications/new
  def new
    @medication = Medication.new
    @page_title = "New Medication"
  end

  # GET /medications/1/edit
  def edit
    if @medication.userid == current_user.id
      @page_title = "Edit " + @medication.name
    else
      respond_to do |format|
        format.html { redirect_to medication_path(@medication) }
        format.json { head :no_content }
      end
    end
  end

  # POST /medications
  # POST /medications.json
  def create
    @medication = Medication.new(medication_params)
    @page_title = "New Medication"
    respond_to do |format|
      if @medication.save

        # Save refill date to Google calendar
        if (!current_user.token.blank?) && params[:add_to_google_cal]
          summary = "Refill for " + @medication.name
          date = @medication.refill
          CalendarUploader.new(summary: summary, date: date, access_token: current_user.token, email: current_user.email).upload_event
        end

        format.html { redirect_to medication_path(@medication) }
        format.json { render :show, status: :created, location: @medication }
      else
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medications/1
  # PATCH/PUT /medications/1.json
  def update
    @page_title = "Edit " + @medication.name
    respond_to do |format|
      if @medication.update(medication_params)
        format.html { redirect_to medication_path(@medication) }
        format.json { render :show, status: :ok, location: @medication }
      else
        format.html { render :edit }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    @medication.destroy
    respond_to do |format|
      format.html { redirect_to medications_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medication
      begin
        @medication = Medication.find(params[:id])
      rescue
        if @medication.blank?
          respond_to do |format|
            format.html { redirect_to medications_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medication_params
      params.require(:medication).permit(:name, :dosage, :refill, :userid, :total, :strength,
                                         :dosage_unit, :total_unit, :strength_unit, :comments, :add_to_google)
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
