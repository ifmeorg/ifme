class CategoriesController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(:userid => current_user.id).all.order("created_at DESC")
    @page_title = "Categories"
    @page_new = new_category_path
    @page_tooltip = "New category"
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if @category.userid == current_user.id || is_viewer(params[:moment], params[:strategy], @category)
      @page_title = @category.name
      if @category.userid == current_user.id
        @page_edit = edit_category_path(@category)
        @page_tooltip = "Edit category"
      else
        link_url = "/profile?userid=" + @category.userid.to_s
        the_link = link_to User.where(:id => @category.userid).first.name, link_url
        @page_author = the_link.html_safe
      end
    else
      respond_to do |format|
        format.html { redirect_to categories_path }
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
        format.html { redirect_to category_path(@category) }
        format.json { head :no_content }
      end
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @page_title = "New Category"
    respond_to do |format|
      if @category.save
        format.html { redirect_to category_path(@category) }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /categories
  # POST /categories.json
  def premade
    premade1 = Category.create(userid: current_user.id, name: t('categories.index.premade1_name'), description: t('categories.index.premade1_description'))
    premade2 = Category.create(userid: current_user.id, name: t('categories.index.premade2_name'), description: t('categories.index.premade2_description'))
    premade3 = Category.create(userid: current_user.id, name: t('categories.index.premade3_name'), description: t('categories.index.premade3_description'))
    premade4 = Category.create(userid: current_user.id, name: t('categories.index.premade4_name'), description: t('categories.index.premade4_description'))

    respond_to do |format|
      format.html { redirect_to categories_path }
      format.json { render :no_content }
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @page_title = "Edit " + @category.name
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_path(@category) }
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
    # Remove categories from existing moments
    @moments = Moment.where(:userid => current_user.id).all

    @moments.each do |item|
      new_category = item.category.delete(@category.id)
      the_moment = Moment.find_by(id: item.id)
      the_moment.update(category: item.category)
    end

    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_path }
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
            format.html { redirect_to categories_path }
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

    def is_viewer(moment, strategy, category)
      if !strategy.blank? && Strategy.where(id: strategy).exists? && Strategy.where(id: strategy).first.viewers.include?(current_user.id)
        return true
      elsif !moment.blank?
        if Moment.where(id: moment).exists? && Moment.where(id: moment).first.category.include?(category.id) && Moment.where(id: moment).first.viewers.include?(current_user.id)
          return true
        end
      end

      return false
    end
end
