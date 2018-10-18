# frozen_string_literal: true

describe CategoriesHelper do
  subject { TestClass.new(build_stubbed(:category, id: 999)) }

  class TestClass
    include CategoriesHelper
    include Rails.application.routes.url_helpers

    def initialize(category)
      @category = category
    end

    def t(*args)
      I18n.t(*args)
    end
  end

  let(:category_form_inputs_res) do
    [
      {
        id: 'category_name',
        type: 'text',
        name: 'category[name]',
        label: 'Name',
        value: 'Test Category',
        required: true,
        info: 'Categorize recurring people, places, things, activities, and more',
        dark: true
      },
      {
        id: 'category_description',
        type: 'textarea',
        name: 'category[description]',
        label: 'Description',
        value: 'Test description category',
        dark: true
      }
    ]
  end

  describe '#new_category_props' do
    it 'call method with correct params' do
      expect(subject).to receive(:new_form_props).with(category_form_inputs_res, '/categories')
      subject.new_category_props
    end
  end

  describe '#quick_create_category_props' do
    it 'call method with correct params' do
      expect(subject).to receive(:quick_create_form_props).with(category_form_inputs_res, '/categories/quick_create')
      subject.quick_create_category_props
    end
  end

  describe '#edit_category_props' do
    it 'call method with correct params' do
      expect(subject).to receive(:edit_form_props).with(category_form_inputs_res, '/categories/999')
      subject.edit_category_props
    end
  end
end
