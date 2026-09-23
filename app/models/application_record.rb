# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.build_csv_rows(objects)
    return if objects.blank?

    klass = objects.klass
    attributes = if klass.const_defined?(:USER_DATA_ATTRIBUTES)
                   klass.const_get(:USER_DATA_ATTRIBUTES)
                 else
                   klass.column_names
                 end
    yield ["#{klass.name.underscore}_info"]
    yield attributes
    objects.find_each { |object| yield attributes.map { |attribute| object.send(attribute.to_sym) } }
  end
end
