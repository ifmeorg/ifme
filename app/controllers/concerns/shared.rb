# frozen_string_literal: true
module Shared
  extend ActiveSupport::Concern

  included do
    helper_method :shared_add_premade, :shared_create,
                  :shared_update, :shared_destroy
  end

  def shared_add_premade(model_class, total)
    (1..total).each do |num|
      model_name_plural = model_class.name.pluralize.downcase
      key = "#{model_name_plural}.index.premade#{num}"
      model_class.create(
        user_id: current_user.id,
        name: I18n.t("#{key}_name"),
        description: I18n.t("#{key}_description")
      )
    end
  end

  def shared_quick_create(model_object)
    render json: shared_quick_create_result(model_object)
  end

  def shared_create(model_object)
    action = model_object.save
    create_or_update(action, model_object, false)
  end

  def shared_update(model_object, model_params)
    action = model_object.update(model_params)
    create_or_update(action, model_object, true)
  end

  def shared_destroy(model_object)
    current_user.moments.each do |m|
      update_object(model_object, m)
    end
    if model_object.class == Category
      current_user.strategies.each do |s|
        update_object(model_object, s)
      end
    end
    model_object.destroy
    redirect_to_path(index_path(model_object))
  end

  private

  def index_path(model_object)
    case model_object.class.name
    when 'Mood'
      moods_path
    when 'Category'
      categories_path
    when 'Moment'
      moments_path
    else
      strategies_path
    end
  end

  def show_path(model_object)
    case model_object.class.name
    when 'Mood'
      mood_path(model_object)
    when 'Category'
      category_path(model_object)
    when 'Moment'
      moment_path(model_object)
    else
      strategy_path(model_object)
    end
  end

  def update_object(model_object, object)
    model_name = model_object.class.name.downcase
    object[model_name].delete(model_object.id)
    params = { "#{model_name}": object[model_name] }
    object.class.find_by(id: object.id).update(params)
  end

  def format_success(format, model_object, is_update)
    path = show_path(model_object)
    format.html { redirect_to path }
    status = is_update ? :ok : :created
    format.json { render :show, status: status, location: model_object }
  end

  def format_failure(format, model_object, is_update)
    format.html { render is_update ? :edit : :new }
    format.json do
      render json: model_object.errors, status: :unprocessable_entity
    end
  end

  def create_or_update(action, model_object, is_update)
    respond_to do |format|
      if action
        format_success(format, model_object, is_update)
      else
        format_failure(format, model_object, is_update)
      end
    end
  end

  def shared_quick_create_result(model_object)
    return { success: false } unless model_object.save

    {
      success: true,
      id: model_object.id,
      name: model_object.name,
      slug: model_object.slug
    }
  end
end
