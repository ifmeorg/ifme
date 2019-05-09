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
    edit_form_props(moment_form_inputs, moment_path(@moment))
  end

  private

  def moment_input_props(field, type, label, group = false)
    { id: "moment_#{field}",
      type: type,
      name: "moment[#{field}]#{group ? '[]' : ''}",
      label: t(label) }
  end

  def moment_text_input_props(field, type, label, required = false)
    moment_input_props(field, type, label)
      .merge(value: @moment[field] || nil, required: required, dark: true)
  end

  def moment_name
    moment_text_input_props('name', 'text', 'common.name', true)
  end

  def moment_why
    moment_text_input_props('why', 'textarea', 'moments.form.why', true)
  end

  def moment_fix
    moment_text_input_props('fix', 'textarea', 'moments.form.fix')
  end

  def quick_create_props(model_relation, form_props)
    model_name = model_relation.name.downcase
    moment_input_props(
      model_name, 'quickCreate', "#{model_name.pluralize}.plural", true
    )
      .merge(placeholder: t('common.form.search_by_keywords'),
             checkboxes: checkboxes_for(model_relation),
             formProps: form_props)
  end

  def moment_category
    quick_create_props(@categories, quick_create_category_props)
  end

  def moment_mood
    quick_create_props(@moods, quick_create_mood_props)
  end

  def moment_strategy
    quick_create_props(@strategies, quick_create_strategy_props)
  end

  def moment_comment
    moment_input_props('comment', 'switch', 'comment.allow_comments')
      .merge(value: true,
             uncheckedValue: false,
             checked: @moment.comment,
             info: t('comment.hint'),
             dark: true)
  end

  def moment_publishing
    { id: 'moment_publishing',
      type: 'switch',
      label: t('moments.form.draft_question'),
      dark: true,
      name: 'publishing',
      value: '0',
      uncheckedValue: '1',
      checked: !@moment.published? }
  end

  def moment_form_inputs
    [
      moment_name, moment_why, moment_fix, moment_category, moment_mood,
      moment_strategy, get_viewers_input(
        @viewers, 'moment', 'moments', @moment
      ),
      moment_comment, moment_publishing
    ]
  end

  def checkboxes_for(data)
    checkboxes = []
    data.each do |item|
      checkboxes.push(id: item.slug,
                      label: item.name,
                      value: item.id,
                      checked: data_for(item)&.include?(item.id))
    end
    checkboxes
  end

  def data_for(item)
    case item.class.name
    when 'Category'
      @moment.category
    when 'Mood'
      @moment.mood
    when 'Strategy'
      @moment.strategy
    end
  end
end
