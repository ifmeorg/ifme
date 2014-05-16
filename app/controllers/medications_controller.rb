class MedicationsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  # GET /medications
  # GET /medications.json
  def index
    @medications = Medication.where(:userid => current_user.id).all
    @page_title = "Medications"
    @page_new = new_medication_path
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
    if @medication.userid == current_user.id
      @page_title = @medication.name
      @page_edit = edit_medication_path(@medication)
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
        format.html { redirect_to medication_path(@medication), notice: 'Medication was successfully created.' }
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
    @page_title = @medication.name
    respond_to do |format|
      if @medication.update(medication_params)
        format.html { redirect_to medication_path(@medication), notice: 'Medication was successfully updated.' }
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
      params.require(:medication).permit(:name, :dosage, :refill, :userid)
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
