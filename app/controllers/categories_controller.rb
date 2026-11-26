# frozen_string_literal: true

class CategoriesController < ApplicationController
  include CollectionPageSetupConcern
  include CategoriesHelper
  include SharedBasicConcern
  include TagsHelper
  find_resource_by_slug :category, redirect_to: :categories_path
  before_action :set_category, only: %i[show edit update destroy]
  respond_to :json, only: [:index]

  # GET /categories
  # GET /categories.json
  def index
    page_collection('@categories', 'category')
    shared_index_response(@categories)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    setup_stories
    redirect_unless_owner!(@category, categories_path)
    @page_new_buttons = [
      { text: t('moments.new'), path: new_moment_path(category: @category.slug) },
      { text: t('strategies.new'), path: new_strategy_path(category: @category.slug) }
    ]
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    redirect_unless_owner!(@category, category_path(@category))
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

  def category_params
    params.require(:category).permit(:name, :description, :visible)
  end
end
