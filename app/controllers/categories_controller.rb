class CategoriesController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(:userid => current_user.id).all
    @page_title = "Categories"
    @page_new = new_category_path
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if @category.userid == current_user.id || is_viewer(params[:trigger], @category)
      @page_title = @category.name
      @page_edit = edit_category_path(@category)
    else 
      respond_to do |format|
        format.html { redirect_to categories_url }
        format.json { head :no_content }
      end
    end 
  end

  # GET /categories/new
  def new
    @category = Category.new
    @page_title = "New Category"
  end

  # GET /categories/1/edit
  def edit
    if @category.userid == current_user.id
      @page_title = "Edit " + @category.name
    else 
      respond_to do |format|
        format.html { redirect_to categories_url }
        format.json { head :no_content }
      end
    end 
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    # Remove categories from existing triggers
    @triggers = Trigger.where(:userid => current_user.id).all

    @triggers.each do |item|
      new_category = item.category.delete(@category.id.to_s)
      the_trigger = Trigger.find_by(id: item.id)
      the_trigger.update(category: item.category)
    end

    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      begin
        @category = Category.find(params[:id])
      rescue
        if @category.blank?
          respond_to do |format|
            format.html { redirect_to categories_url }
            format.json { head :no_content }
          end
        end 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description, :userid)
    end

    def if_not_signed_in
      if !user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
          format.json { head :no_content }
        end
      end
    end

    def is_viewer(trigger, category)
      if trigger.blank?
        return false
      else
        if Trigger.where(:id => trigger).exists? && Trigger.where(:id => trigger).first.category.include?(category.id.to_s) && Trigger.where(:id => trigger).first.viewers.include?(current_user.id.to_s)
          return true
        end
      end 
      return false
    end
end
