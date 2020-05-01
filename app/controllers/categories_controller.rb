# frozen_string_literal: true

class CategoriesController < ApplicationController
  include CollectionPageSetupConcern
  include CategoriesHelper
  include SharedBasicConcern
  include TagsHelper
  before_action :set_category, only: %i[show edit update destroy]
  respond_to :json, only: [:index]

  # GET /categories
  # GET /categories.json
  def index
    page_collection('@categories', 'category')
    respond_to do |format|
      format.json do
        render json: {
          data: categories_or_moods_props(@categories),
          lastPage: @categories.last_page?
        }
      end
      format.html
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    setup_stories
    redirect_to_path(categories_path) if @category.user_id != current_user.id
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    return if @category.user_id == current_user.id

    redirect_to_path(category_path(@category))
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params.merge(user_id: current_user.id))
    shared_create(@category)
  end

  # POST /categories
  # POST /categories.json
  def premade
    shared_add_premade(Category, 4)
    redirect_to_path(categories_path)
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    shared_update(@category, category_params)
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    shared_destroy(@category)
  end

  def quick_create
    shared_quick_create_basic(Category, params)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_path(categories_path)
  end

  def category_params
    params.require(:category).permit(:name, :description, :visible)
  end
end
