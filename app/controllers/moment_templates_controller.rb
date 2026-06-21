# frozen_string_literal: true
class MomentTemplatesController < ApplicationController
  include MomentTemplatesConcern

  def index
    @templates = current_user.moment_templates.order('LOWER(name)')
  end

  def create
    moment_template = MomentTemplate.new(
      moment_template_params.merge(user_id: current_user.id)
    )
    render json: create_response_object(moment_template)
  end

  def update
    moment_template = current_user.moment_templates.find_by(id: params[:id])
    render json: update_response_object(moment_template)
  end

  def destroy
    moment_template = current_user.moment_templates.find_by(id: params[:id])
    moment_template&.destroy
    redirect_to_path(moment_templates_path)
  end

  private

  def moment_template_params
    params.require(:moment_template).permit(:name, :description)
  end
end
