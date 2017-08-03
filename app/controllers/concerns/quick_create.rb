module QuickCreate
  extend ActiveSupport::Concern

  included do
    helper_method :render_checkbox
  end

  def render_checkbox(data, dataType, createType)
    checkbox = "<input type=\"checkbox\" value=\"#{data.id.to_s}\" name=\"#{createType}[#{dataType}][]\" id=\"#{createType}_#{dataType}_#{data.id.to_s}\">"
    label = "<span>#{data.name}</span><br>"
    wrapper_id = "#{dataType}_name_#{data.id.to_s}"
    autocomplete_id = "#{createType}_#{dataType}_name"
    {
      checkbox: checkbox,
      label: label,
      wrapper_id: wrapper_id,
      autocomplete_id: autocomplete_id,
      name: data.name,
      id: data.id
    }
  end
end
