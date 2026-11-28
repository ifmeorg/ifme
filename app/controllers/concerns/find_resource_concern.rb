# frozen_string_literal: true
module FindResourceConcern
  extend ActiveSupport::Concern

  class_methods do
    # Defines a `set_<name>` method that loads `@<name>` via
    # `<Name>.friendly.find(params[:id])`, redirecting to `redirect_to`
    # when the slug doesn't resolve to a record.
    def find_resource_by_slug(name, redirect_to:)
      define_method(:"set_#{name}") do
        model = name.to_s.camelize.constantize
        instance_variable_set(:"@#{name}", model.friendly.find(params[:id]))
      rescue ActiveRecord::RecordNotFound
        redirect_to_path(send(redirect_to))
      end
    end
  end
end
