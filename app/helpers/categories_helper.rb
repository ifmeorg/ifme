# frozen_string_literal: true
module CategoriesHelper
  include FormHelper

  def new_category_props
    new_form_props(category_form_inputs, categories_path)
  end

  def quick_create_category_props
    quick_create_form_props(category_form_inputs, quick_create_categories_path)
  end

  def edit_category_props
    edit_form_props(category_form_inputs, category_path(@category))
  end

  private

  # rubocop:disable MethodLength
  def category_form_inputs
    [
      {
        id: 'category_name',
        type: 'text',
        name: 'category[name]',
        label: t('common.name'),
        value: @category.name || nil,
        required: true,
        info: t('categories.form.name_hint'),
        dark: true
      },
      {
        id: 'category_description',
        type: 'textarea',
        name: 'category[description]',
        label: t('common.form.description'),
        value: @category.description || nil,
        dark: true
      }
    ]
  end
  # rubocop:enable MethodLength
end
