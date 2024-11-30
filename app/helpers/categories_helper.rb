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

  def category_input_props(field, type, label, group = false)
    { id: "moment_#{field}", type:,
      name: "moment[#{field}]#{group ? '[]' : ''}", label: t(label) }
  end

  def category_form_inputs
    [
      category_name(@category&.name),
      category_description(@category&.description),
      category_visible(@category&.visible)
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

  def category_visible(visible)
    {
      id: 'category_visible',
      type: 'switch',
      label: t('shared.stats.make_visible_in_stats'),
      dark: true,
      name: 'category[visible]',
      value: true,
      uncheckedValue: false,
      checked: visible
    }
  end

  def quick_create_props(model_relation, form_props)
    model_name = model_relation.name.downcase
    category_input_props(
      model_name, 'quickCreate', "#{model_name.pluralize}.plural", true
    ).merge(placeholder: t('common.form.search_by_keywords'),
            checkboxes: checkboxes_for(model_relation), formProps: form_props)
  end

  def category_moment
    quick_create_props(@moments, quick_create_moment_props)
  end

  def category_strategy
    quick_create_props(@strategies, quick_create_strategy_props)
  end
end
