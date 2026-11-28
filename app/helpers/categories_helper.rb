# frozen_string_literal: true
module CategoriesHelper
  include FormHelper
  include VisibleHelper

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
    url_helper = category_path(element) if element.instance_of?(Category)
    {
      name: element.name,
      link: url_helper,
      actions: actions_setup(element, url_helper)
    }
  end

  private

  def actions_setup(element, url_helper)
    link = edit_mood_path(element)
    link = edit_category_path(element) if element.instance_of?(Category)
    {
      edit: {
        name: t('common.actions.edit'),
        link:
      },
      delete: action_delete(url_helper),
      not_visible: !element.visible && get_visible(element.visible),
      visible: element.visible && get_visible(element.visible)
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
    taggable_form_inputs('category', @category, info: t('categories.form.name_hint'))
  end

  # Shared by CategoriesHelper and MoodsHelper: Category and Mood use the
  # same name/description/visible fields, differing only in the model name
  # and (for category) a name hint.
  def taggable_form_inputs(model_name, model, info: nil)
    [
      taggable_name(model_name, model&.name, info),
      taggable_description(model_name, model&.description),
      taggable_visible(model_name, model&.visible)
    ]
  end

  def taggable_name(model_name, name, info)
    {
      id: "#{model_name}_name",
      type: 'text',
      name: "#{model_name}[name]",
      label: t('common.name'),
      value: name || nil,
      required: true,
      dark: true
    }.tap { |input| input[:info] = info if info }
  end

  def taggable_description(model_name, description)
    {
      id: "#{model_name}_description",
      type: 'textarea',
      name: "#{model_name}[description]",
      label: t('common.form.description'),
      value: description || nil,
      dark: true
    }
  end

  def taggable_visible(model_name, visible)
    {
      id: "#{model_name}_visible",
      type: 'switch',
      label: t('shared.stats.make_visible_in_stats'),
      dark: true,
      name: "#{model_name}[visible]",
      value: true,
      uncheckedValue: false,
      checked: visible
    }
  end
end
