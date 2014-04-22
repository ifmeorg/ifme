class TriggersController < ApplicationController
  before_action :set_trigger, only: [:show, :edit, :update, :destroy]

  # GET /triggers
  # GET /triggers.json
  def index
    @triggers = Trigger.where(:userid => current_user.id).all
    @page_title = "Triggers"
  end

  # GET /triggers/1
  # GET /triggers/1.json
  def show
    if hide_page && @trigger.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to triggers_url }
        format.json { head :no_content }
      end
    else 
      @page_title = @trigger.name
    end 
  end

  # GET /triggers/new
  def new
    @viewers = Array.new
    if Ally.where(:userid => current_user.id).exists?
      User.where.not(:id => current_user.id).all.each do |item|
        if Ally.where(:userid => item.id).exists? && Ally.where(:userid => item.id).first.allies.include?(current_user.id.to_s) && Ally.where(:userid => current_user.id).first.allies.include?(item.id.to_s)
          @viewers.push(item.id)
        end
      end
    end 
    @trigger = Trigger.new
    @page_title = "New Trigger"
  end

  # GET /triggers/1/edit
  def edit
    if @trigger.userid == current_user.id
      @viewers = Array.new
      if Ally.where(:userid => current_user.id).exists?
        User.where.not(:id => current_user.id).all.each do |item|
          if Ally.where(:userid => item.id).exists? && Ally.where(:userid => item.id).first.allies.include?(current_user.id.to_s) && Ally.where(:userid => current_user.id).first.allies.include?(item.id.to_s)
            @viewers.push(item.id)
          end
        end
      end 
      @page_title = "Edit " + @trigger.name
    else 
      respond_to do |format|
        format.html { redirect_to triggers_url }
        format.json { head :no_content }
      end
    end 
  end

  # POST /triggers
  # POST /triggers.json
  def create
    @trigger = Trigger.new(trigger_params)
    respond_to do |format|
      if @trigger.save
        format.html { redirect_to @trigger, notice: 'Trigger was successfully created.' }
        format.json { render :show, status: :created, location: @trigger }
      else
        format.html { render :new }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /triggers/1
  # PATCH/PUT /triggers/1.json
  def update
    respond_to do |format|
      if @trigger.update(trigger_params)
        format.html { redirect_to @trigger, notice: 'Trigger was successfully updated.' }
        format.json { render :show, status: :ok, location: @trigger }
      else
        format.html { render :edit }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /triggers/1
  # DELETE /triggers/1.json
  def destroy
    @trigger.destroy
    respond_to do |format|
      format.html { redirect_to triggers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trigger
      @trigger = Trigger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trigger_params
      params.require(:trigger).permit(:name, :why, :fix, :userid, {:category => []}, {:mood => []}, {:viewers => []})
    end

    def hide_page 
      if Trigger.where(:userid => @trigger.userid).exists?
        Trigger.where(:userid => @trigger.userid).all.each do |item|
          if item.viewers.include?(current_user.id.to_s) 
            return false
          end
        end
      end
      return true
    end 
end
