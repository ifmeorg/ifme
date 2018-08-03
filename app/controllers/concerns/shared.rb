# frozen_string_literal: true

module Shared
  extend ActiveSupport::Concern

  included do
    helper_method :shared_create, :shared_update, :shared_destroy
  end

  def shared_create(model_object, model_name)
    respond_to do |format|
      if model_object.save
        format_html_success(format, model_object, model_name)
        format.json { render :show, status: :created, location: model_object }
      else
        format.html { render :new }
        format_json_failure(format, model_object)
      end
    end
  end

  def shared_update(model_object, model_name, model_params)
    respond_to do |format|
      if model_object.update(model_params)
        format_html_success(format, model_object, model_name)
        format.json { render :show, status: :ok, location: model_object }
      else
        format.html { render :edit }
        format_json_failure(format, model_object)
      end
    end
  end

  def shared_destroy(model_object, model_name)
    moments = current_user.moments.all
    moments.each do |moment|
      update_moment(model_object, model_name, moment)
    end
    model_object.destroy
    redirect_to_path(index_path(model_name))
  end

  private

  def update_moment(model_object, model_name, moment)
    moment[model_name].delete(model_object.id)
    params = {}
    params[model_name] = moment[model_name]
    Moment.find_by(id: moment.id).update(params)
  end

  def index_path(model_name)
    case model_name
    when 'mood'
      moods_path
    when 'category'
      categories_path
    when 'moment'
      moments_path
    else
      strategies_path
    end
  end

  def show_path(model_object, model_name)
    case model_name
    when 'mood'
      mood_path(model_object)
    when 'category'
      category_path(model_object)
    when 'moment'
      moment_path(model_object)
    else
      strategy_path(model_object)
    end
  end

  def format_html_success(format, model_object, model_name)
    format.html { redirect_to show_path(model_object, model_name) }
  end

  def format_json_failure(format, model_object)
    format.json do
      render json: model_object.errors, status: :unprocessable_entity
    end
  end
end
