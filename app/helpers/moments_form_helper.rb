# frozen_string_literal: true
module MomentsFormHelper
  include MoodsHelper
  include CategoriesHelper
  include StrategiesHelper
  include FormHelper

  def new_moment_props
    new_form_props(moment_form_inputs, moments_path)
  end

  def edit_moment_props
    edit_form_props(moment_form_inputs(true), moment_path(@moment))
  end

  private

  def base_input_props(field, type, label, group: false)
    FormInput.new(
      id: "moment_#{field}",
      type: type,
      name: "moment[#{field}]#{group ? '[]' : ''}",
      label: t(label)
    )
  end

  def text_input_props(field, type, label, required: false)
    base_input_props(field, type, label)
      .with_value(@moment[field])
      .with_attributes(required: required, dark: true)
  end

  def switch_input_props(field, label, options = {})
    switch = base_input_props(field, 'switch', label)
      .with_attributes(
        value: '0',          # Checked state
        unchecked_value: '1', # Unchecked state
        checked: options[:checked],
        dark: true,
        info: options[:info]
      )
    hidden = FormInput.new(
      id: "moment_#{field}_hidden",
      type: 'hidden',
      name: "moment[#{field}]",
      label: nil
    ).with_attributes(value: '0')
    [hidden, switch]
  end

  def quick_create_input_props(model_relation, form_props)
    model_name = model_relation.name.downcase
    base_input_props(model_name, 'quickCreate', "#{model_name.pluralize}.plural", group: true)
      .with_attributes(
        placeholder: t('common.form.search_by_keywords'),
        checkboxes: checkboxes_for(model_relation),
        form_props: form_props
      )
  end

  def moment_name
    text_input_props('name', 'text', 'common.name', required: true)
  end

  def moment_why
    label_key = @moment.fix.present? ? 'why_legacy' : 'why'
    input = text_input_props('why', 'textareaTemplate', "moments.form.#{label_key}", required: true)
    @moment.fix.present? ? input : input.with_attributes(options: options_for_templates(current_user.moment_templates))
  end

  def moment_fix
    @moment.fix.present? ? text_input_props('fix', 'textarea', 'moments.form.fix_legacy') : FormInput.empty
  end

  def moment_category
    quick_create_input_props(@categories, quick_create_category_props)
  end

  def moment_mood
    quick_create_input_props(@moods, quick_create_mood_props)
  end

  def moment_strategy
    quick_create_input_props(@strategies, quick_create_strategy_props)
  end

  def moment_comment
    switch_input_props('comment', 'comment.allow_comments',
      checked: @moment.comment,
      info: t('comment.hint')
    )
  end

  def moment_publishing(edit)
    switch_input_props('publishing', 'moments.form.draft_question',
      checked: edit ? !@moment.published? : true  
    ).map do |input|
      input.with_attributes(value: '0', unchecked_value: '1') 
    end
  end

  def moment_bookmarked
    checked = params[:bookmarked] ? true : @moment.bookmarked
    switch_input_props('bookmarked', 'moments.form.bookmarked_question',
      checked: checked,
      info: t('moments.form.bookmarked_info')
    )
  end

  def moment_display_resources
    switch_input_props('resource_recommendations', 'moments.form.resource_recommendations_question',
      checked: @moment.resource_recommendations
    )
  end

  def moment_form_inputs(edit = false)
    inputs = [
      moment_name,
      moment_why,
      moment_fix,
      moment_category,
      moment_mood,
      moment_strategy,
      get_viewers_input(@viewers, 'moment', 'moments', @moment),
      moment_comment,
      moment_publishing(edit),
      moment_bookmarked,
      moment_display_resources
    ]
    inputs.flatten.map(&:to_h)
  end

  def checkboxes_for(data)
    data.map do |item|
      { id: item.slug, label: item.name, value: item.id, checked: data_for(item)&.include?(item.id) }
    end
  end

  def data_for(item)
    case item.class.name
    when 'Category'
      ids = @moment.categories.pluck(:id)
      if params[:category].present? && ids.empty?
        category = Category.friendly.find_by(slug: params[:category])
        ids << category.id if category
      end
      ids
    when 'Mood'
      @moment.moods.pluck(:id)
    when 'Strategy'
      @moment.strategies.pluck(:id)
    end
  end

  def options_for_templates(data)
    data.map { |item| { id: item.slug, label: item.name, value: item.description } }
  end
end

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