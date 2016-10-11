require "google/api_client"

class MedicationsController < ApplicationController
  helper_method :print_reminders
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  # GET /medications
  # GET /medications.json
  def index
    name = params[:search]
    search = Medication.where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      @medications = search.order("created_at DESC").page(params[:page])
    else
      @medications = Medication.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page])
    end
    @page_tooltip = t('medications.new')
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
    if @medication.userid == current_user.id
      @page_edit = edit_medication_path(@medication)
      @page_tooltip = t('medications.edit_medication')
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
    @medication.build_take_medication_reminder
    @medication.build_refill_reminder
  end

  # GET /medications/1/edit
  def edit
    TakeMedicationReminder.find_or_initialize_by(medication_id: @medication.id)
    RefillReminder.find_or_initialize_by(medication_id: @medication.id)
    if @medication.userid != current_user.id
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
    respond_to do |format|
      if @medication.save
        # Save refill date to Google calendar
        if current_user.google_oauth2_enabled? && params[:add_to_google_cal]
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

  def print_reminders(medication)
    return_this = ''

    if medication.active_reminders.any?
      return_this += '<div class="small_margin_top">'
      return_this += '<i class="fa fa-bell small_margin_right"></i>'
      reminder_names = medication.active_reminders.map(&:name)
      return_this += reminder_names.to_sentence(two_words_connector: t('support.array.words_connector'))
      return_this += '</div>'
    end

    return return_this.html_safe
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

  def medication_params
    params.require(:medication).permit(
      :name, :dosage, :refill, :userid, :total, :strength, :dosage_unit,
      :total_unit, :strength_unit, :comments, :add_to_google_cal,
      { take_medication_reminder_attributes: [:active, :id] },
      { refill_reminder_attributes: [:active, :id] }
    )
  end
end
