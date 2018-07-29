# frozen_string_literal: true

module Shared
  extend ActiveSupport::Concern

  included do
    helper_method :shared_create, :shared_update, :delete_notifications
  end

  def shared_create(model_object, model_name)
    respond_to do |format|
      if model_object.save
        format.html { redirect_to redirect_path(model_object, model_name) }
        format.json { render :show, status: :created, location: model_object }
      else
        format.html { render :new }
        format.json do
          render json: model_object.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def shared_update(model_object, model_name, model_params)
    respond_to do |format|
      if model_object.update(model_params)
        format.html { redirect_to redirect_path(model_object, model_name) }
        format.json { render :show, status: :ok, location: model_object }
      else
        format.html { render :edit }
        format.json do
          render json: model_object.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def delete_notifications(commentid, model_name)
    Comment.find(commentid).destroy
    public_uniqueid = "comment_on_#{model_name}_#{commentid.to_s}"
    Notification.where(uniqueid: public_uniqueid).destroy_all
    private_uniqueid = "comment_on_#{model_name}_private_#{commentid.to_s}"
    Notification.where(uniqueid: private_uniqueid).destroy_all
  end

  private

  def redirect_path(model_object, model_name)
    if model_name == 'mood'
      mood_path(model_object)
    elsif model_name == 'category'
      category_path(model_object)
    elsif model_name == 'moment'
      moment_path(model_object)
    else
      strategy_path(model_object)
    end
  end
end
