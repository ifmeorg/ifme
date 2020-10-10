# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.build_csv_rows(objects)
    return [] if objects.blank?
    klass = objects.klass
    data = [["#{klass.name.underscore}_info"]]
    diplay_attributes = klass.const_defined?("DISPLAY_ATTRIBUTES") ? klass.const_get("DISPLAY_ATTRIBUTES") : klass.column_names
    data << diplay_attributes
    objects.each do |object|
      data << diplay_attributes.map { |attribute| object.send(attribute.to_sym) }
    end
    return data
  end

end
