# frozen_string_literal: true

# rubocop:disable ClassLength
class CategoriesController < ApplicationController
  include CollectionPageSetup
  include Shared
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  # GET /categories.json

  def index
    page_collection('@categories', 'category')
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
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
  # rubocop:disable MethodLength
  def create
    @category = Category.new(category_params.merge(user_id: current_user.id))
    shared_create(@category, 'category')
  end
  # rubocop:enable MethodLength

  # POST /categories
  # POST /categories.json
  # rubocop:disable MethodLength
  def premade
    Category.create(
      user_id: current_user.id,
      name: t('categories.index.premade1_name'),
      description: t('categories.index.premade1_description')
    )
    Category.create(
      user_id: current_user.id,
      name: t('categories.index.premade2_name'),
      description: t('categories.index.premade2_description')
    )
    Category.create(
      user_id: current_user.id,
      name: t('categories.index.premade3_name'),
      description: t('categories.index.premade3_description')
    )
    Category.create(
      user_id: current_user.id,
      name: t('categories.index.premade4_name'),
      description: t('categories.index.premade4_description')
    )

    redirect_to_path(categories_path)
  end
  # rubocop:enable MethodLength

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    shared_update(@category, 'category', category_params)
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    shared_destroy(@category, 'category')
  end

  # rubocop:disable MethodLength
  def quick_create
    category = Category.new(
      user_id: current_user.id,
      name: params[:category][:name],
      description: params[:category][:description]
    )
    shared_quick_create(category)
  end
  # rubocop:enable MethodLength

  private

  # Use callbacks to share common setup or constraints between actions.
  # rubocop:disable RescueStandardError
  def set_category
    @category = Category.friendly.find(params[:id])
  rescue
    redirect_to_path(categories_path)
  end
  # rubocop:enable RescueStandardError

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
# rubocop:enable ClassLength
