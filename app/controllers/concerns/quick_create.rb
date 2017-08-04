# frozen_string_literal: true

module QuickCreate
  extend ActiveSupport::Concern

  included do
    helper_method :render_checkbox
  end

  def render_checkbox(data, data_type, create_type)
    {
      checkbox: checkbox(data, data_type, create_type),
      label: label(data),
      wrapper_id: wrapper_id(data, data_type),
      autocomplete_id: autocomplete_id(data_type, create_type),
      name: data.name,
      id: data.id
    }
  end

  private

  def checkbox(data, data_type, create_type)
    "<input type=\"checkbox\" value=\"#{data.id}\"
    name=\"#{create_type}[#{data_type}][]\"
    id=\"#{create_type}_#{data_type}_#{data.id}\">"
  end

  def label(data)
    "<span>#{data.name}</span><br>"
  end

  def wrapper_id(data, data_type)
    "#{data_type}_name_#{data.id}"
  end

  def autocomplete_id(data_type, create_type)
    "#{create_type}_#{data_type}_name"
  end
end
