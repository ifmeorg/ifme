# frozen_string_literal: true
module CategoriesHelper
  include FormHelper

  def new_category_props(category)
    new_form_props(category_form_inputs(category), categories_path)
  end

  def quick_create_category_props(category)
    quick_create_form_props(
      category_form_inputs(category), quick_create_categories_path
    )
  end

  def edit_category_props(category)
    edit_form_props(category_form_inputs(category), category_path(@category))
  end

  private

  def category_form_inputs(category)
    [
      category_name(category&.name),
      category_description(category&.description)
    ]
  end

  def category_name(name)
    {
      id: 'category_name',
      type: 'text',
      name: 'category[name]',
      label: t('common.name'),
      value: name || nil,
      required: true,
      info: t('categories.form.name_hint'),
      dark: true
    }
  end

  def category_description(description)
    {
      id: 'category_description',
      type: 'textarea',
      name: 'category[description]',
      label: t('common.form.description'),
      value: description || nil,
      dark: true
    }
  end
end
