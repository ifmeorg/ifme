# frozen_string_literal: true

class CategoriesController < ApplicationController
  include CollectionPageSetup
  include QuickCreate
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  # GET /categories.json

  def index
    page_collection('@categories', 'category')
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if @category.userid == current_user.id
      @page_edit = edit_category_path(@category)
      @page_tooltip = t('categories.edit_category')
    else
      redirect_to_path(categories_path)
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    return if @category.userid == current_user.id

    redirect_to_path(category_path(@category))
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
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
    Category.create(userid: current_user.id, name: t('categories.index.premade1_name'), description: t('categories.index.premade1_description'))
    Category.create(userid: current_user.id, name: t('categories.index.premade2_name'), description: t('categories.index.premade2_description'))
    Category.create(userid: current_user.id, name: t('categories.index.premade3_name'), description: t('categories.index.premade3_description'))
    Category.create(userid: current_user.id, name: t('categories.index.premade4_name'), description: t('categories.index.premade4_description'))

    redirect_to_path(categories_path)
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
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
    @moments = Moment.where(userid: current_user.id).all

    @moments.each do |item|
      item.category.delete(@category.id)
      the_moment = Moment.find_by(id: item.id)
      the_moment.update(category: item.category)
    end

    @category.destroy

    redirect_to_path(categories_path)
  end

  def quick_create
    category = Category.new(userid: current_user.id, name: params[:category][:name], description: params[:category][:description])

    if category.save
      tag = params[:category][:tag].to_s
      result = render_checkbox(category, 'category', tag)
    else
      result = { error: 'error' }
    end

    respond_with_json(result)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  rescue
    redirect_to_path(categories_path)
  end

  def category_params
    params.require(:category).permit(:name, :description, :userid)
  end
end
