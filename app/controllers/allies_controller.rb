class AlliesController < ApplicationController
  before_action :set_ally, only: [:destroy]

  # GET /allies
  # GET /allies.json
  def index
    @allies = Ally.all
    @page_title = "Allies"
  end

  # GET /allies/new
  def new
    @ally = Ally.new
    @page_title = "New Ally"
  end

  # POST /allies
  # POST /allies.json
  def create
    @ally = Ally.new(ally_params)

    respond_to do |format|
      if @ally.save
        format.html { redirect_to @ally, notice: 'Ally was successfully created.' }
        format.json { render :show, status: :created, location: @ally }
      else
        format.html { render :new }
        format.json { render json: @ally.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allies/1
  # DELETE /allies/1.json
  def destroy
    @ally.destroy
    respond_to do |format|
      format.html { redirect_to allies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ally
      @ally = Ally.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ally_params
      params.require(:ally).permit(:userid, :allies)
    end
end
