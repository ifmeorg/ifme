# frozen_string_literal: true

module Shared
  extend ActiveSupport::Concern

  included do
    helper_method :shared_create, :shared_update
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

  private

  def redirect_path(model_object, model_name)
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
    format.html { redirect_to redirect_path(model_object, model_name) }
  end

  def format_json_failure(format, model_object)
    format.json do
      render json: model_object.errors, status: :unprocessable_entity
    end
  end
end
