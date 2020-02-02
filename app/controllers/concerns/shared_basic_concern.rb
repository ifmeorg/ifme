# frozen_string_literal: true
module SharedBasicConcern
  extend ActiveSupport::Concern
  include Shared

  def shared_quick_create_basic(model_class, params)
    model_name = model_class.name.downcase
    model_object = model_class.new(
      user_id: current_user.id,
      name: params[model_name][:name],
      description: params[model_name][:description]
    )
    shared_quick_create(model_object)
  end
end
