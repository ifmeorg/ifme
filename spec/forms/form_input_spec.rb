# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FormInput, type: :model do
  it 'builds with basic attributes' do
    input = FormInput.new(id: 'test', type: 'text', name: 'form[test]', label: 'Test')
    expect(input.to_h).to include(id: 'test', type: 'text', name: 'form[test]', label: 'Test')
  end

  it 'returns a new input with additional attributes' do
    input = FormInput.new(id: 'test', type: 'text', name: 'form[test]', label: 'Test')
    updated_input = input.with_attributes(placeholder: 'Enter text')
    expect(updated_input.to_h[:placeholder]).to eq('Enter text')
  end

  it 'provides an empty input' do
    empty_input = FormInput.empty
    expect(empty_input.to_h.values).to all(be_nil)
  end

  it 'returns a new input with a value' do
    input = FormInput.new(id: 'test', type: 'text', name: 'form[test]', label: 'Test')
    valued_input = input.with_value('hello')
    expect(valued_input.to_h[:value]).to eq('hello')
  end

  it 'does not mutate the original input when using with_attributes' do
    input = FormInput.new(id: 'test', type: 'text', name: 'form[test]', label: 'Test')
    input.with_attributes(placeholder: 'Enter text')
    expect(input.to_h).not_to have_key(:placeholder)
  end
end
