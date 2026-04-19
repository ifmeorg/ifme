# frozen_string_literal: true

class FormInput
  attr_reader :attributes

  def self.empty
    new(id: nil, type: nil, name: nil, label: nil).freeze
  end

  def initialize(id:, type:, name:, label:, attributes: {})
    @attributes = { id: id, type: type, name: name, label: label }.merge(attributes)
  end

  def with_value(value)
    with_attributes(value: value || nil)
  end

  def with_attributes(new_attrs)
    self.class.new(
      id: @attributes[:id],
      type: @attributes[:type],
      name: @attributes[:name],
      label: @attributes[:label],
      attributes: @attributes.merge(new_attrs)
    )
  end

  def to_h
    @attributes
  end
end
