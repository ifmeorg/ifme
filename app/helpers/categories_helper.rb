# frozen_string_literal: true
module CategoriesHelper
  include FormHelper

  def new_category_props
    new_form_props(category_form_inputs, categories_path)
  end

  def quick_create_category_props
    quick_create_form_props(
      category_form_inputs, quick_create_categories_path
    )
  end

  def edit_category_props
    edit_form_props(category_form_inputs, category_path(@category))
  end

  def categories_or_moods_props(elements)
    elements.map { |element| present_category_or_mood(element) }
  end

  def present_category_or_mood(element)
    url_helper = mood_path(element)
    url_helper = category_path(element) if element.class.name == 'Category'
    {
      name: element.name,
      link: url_helper,
      actions: actions_setup(element, url_helper)
    }
  end

  private

  def actions_setup(element, url_helper)
    link = edit_mood_path(element)
    link = edit_category_path(element) if element.class.name == 'Category'
    {
      edit: {
        name: t('common.actions.edit'),
        link: link
      },
      delete: action_delete(url_helper)
    }
  end

  def action_delete(url_helper)
    {
      name: t('common.actions.delete'),
      link: url_helper,
      dataConfirm: t('common.actions.confirm'),
      dataMethod: 'delete'
    }
  end

  def category_form_inputs
    [
      category_name(@category&.name),
      category_description(@category&.description)
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
