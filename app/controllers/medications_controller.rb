require 'google/api_client'

class MedicationsController < ApplicationController
  include CollectionPageSetup
  include ReminderHelper
  helper_method :save_refill_to_google_calendar
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  def index
    page_collection('@medications', 'medication')
  end

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

  def new
    @medication = Medication.new
    @medication.build_take_medication_reminder
    @medication.build_refill_reminder
  end

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

  def create
    @medication = Medication.new(medication_params)

    respond_to do |format|
      if @medication.save
        save_refill_to_google_calendar(@medication)
        format.html { redirect_to medication_path(@medication) }
        format.json { render :show, status: :created, location: @medication }
      else
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @medication.update(medication_params)
        save_refill_to_google_calendar(@medication)
        format.html { redirect_to medication_path(@medication) }
        format.json { render :show, status: :ok, location: @medication }
      else
        format.html { render :edit }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @medication.destroy

    respond_to_nothing(medications_path)
  end

  # Save refill date to Google calendar
  def save_refill_to_google_calendar(medication)
    if current_user.google_oauth2_enabled? && medication.add_to_google_cal
      summary = "Refill for " + medication.name
      date = medication.refill
      CalendarUploader.new(summary: summary, date: date, access_token: current_user.token, email: current_user.email).upload_event
    end
  end

  private

  def set_medication
    @medication = Medication.find(params[:id])
  rescue
    respond_to_nothing(medications_path) if @medication.blank?
  end

  def medication_params
    params.require(:medication).permit(
      :name, :dosage, :refill, :userid, :total, :strength,
      :dosage_unit, :total_unit, :strength_unit, :comments, :add_to_google_cal,
      take_medication_reminder_attributes: [:active, :id],
      refill_reminder_attributes: [:active, :id]
    )
  end
end
