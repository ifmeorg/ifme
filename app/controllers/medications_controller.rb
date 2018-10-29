# frozen_string_literal: true

class MedicationsController < ApplicationController
  include CollectionPageSetupConcern
  include ReminderHelper
  include MedicationRefillHelper
  before_action :set_medication, only: %i[show edit update destroy]

  # GET /medications
  # GET /medications.json
  def index
    page_collection('@medications', 'medication')
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
    redirect_to_path(medications_path) if @medication.user_id != current_user.id
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
    return if @medication.user_id == current_user.id

    redirect_to_medication(@medication)
  end

  # POST /medications
  # POST /medications.json
  def create
    @medication =
      Medication.new(medication_params.merge(user_id: current_user.id))
    return unless save_refill_to_google_calendar(@medication)

    if @medication.save
      redirect_to_medication(@medication)
    else
      render_unprocessable_medication
    end
  end

  # PATCH/PUT /medications/1
  # PATCH/PUT /medications/1.json
  def update
    return unless save_refill_to_google_calendar(@medication)

    if @medication.update(medication_params)
      redirect_to_medication(@medication)
    else
      render_unprocessable_medication
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    @medication.destroy
    redirect_to_path(medications_path)
  end

  def redirect_to_medication(medication)
    redirect_to_path(medication_path(medication))
  end

  def return_to_sign_in
    sign_out current_user
    redirect_to_path(new_user_session_path)
  end

  private

  def render_unprocessable_medication
    respond_to do |format|
      format.html { render :new }
      format.json do
        render(json: @medication.errors,
               status: :unprocessable_entity)
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_medication
    @medication = Medication.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(medications_path)
  end

  def medication_params
    params.require(:medication).permit(
      :name, :dosage, :refill,
      :total, :strength,
      :dosage_unit, :total_unit, :strength_unit,
      :comments, :add_to_google_cal,
      take_medication_reminder_attributes: %i[active id],
      refill_reminder_attributes: %i[active id],
      weekly_dosage: []
    )
  end
end
