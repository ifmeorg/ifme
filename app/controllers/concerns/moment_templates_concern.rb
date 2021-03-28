# frozen_string_literal: true
module MomentTemplatesConcern
  extend ActiveSupport::Concern

  def create_response_object(moment_template)
    return unless moment_template.save!

    { id: moment_template.id,
      name: moment_template.name, description: moment_template.description }
  end

  def update_response_object(moment_template)
    return unless moment_template.update!(moment_template_params)

    { id: moment_template.id,
      name: moment_template.name, description: moment_template.description }
  end
end
