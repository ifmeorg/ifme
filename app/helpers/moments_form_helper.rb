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

  def moment_input_props(field, type, label, group = false)
    { id: "moment_#{field}", type:,
      name: "moment[#{field}]#{group ? '[]' : ''}", label: t(label) }
  end

  def moment_text_input_props(field, type, label, required = false)
    moment_input_props(field, type, label)
      .merge(value: @moment[field] || nil, required:, dark: true)
  end

  def moment_name
    moment_text_input_props('name', 'text', 'common.name', true)
  end

  def moment_why
    props = moment_text_input_props(
      'why', 'textareaTemplate',
      "moments.form.#{@moment.fix.present? ? 'why_legacy' : 'why'}", true
    )

    return props if @moment.fix.present?

    props.merge(options: options_for_templates(current_user.moment_templates))
  end

  def moment_fix
    if @moment.fix.present?
      return moment_text_input_props(
        'fix', 'textarea', 'moments.form.fix_legacy'
      )
    end
    {}
  end

  def quick_create_props(model_relation, form_props)
    model_name = model_relation.name.downcase
    moment_input_props(
      model_name, 'quickCreate', "#{model_name.pluralize}.plural", true
    ).merge(placeholder: t('common.form.search_by_keywords'),
            checkboxes: checkboxes_for(model_relation), formProps: form_props)
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
      .merge(value: true, uncheckedValue: false, checked: @moment.comment,
             info: t('comment.hint'), dark: true)
  end

  def moment_publishing(edit)
    { id: 'moment_publishing', type: 'switch',
      label: t('moments.form.draft_question'), dark: true, name: 'publishing',
      value: '0', uncheckedValue: '1',
      checked: edit ? !@moment.published? : @moment.published? }
  end

  def moment_bookmarked
    moment_input_props(
      'bookmarked', 'switch', 'moments.form.bookmarked_question'
    ).merge(
      value: true, uncheckedValue: false,
      checked: params[:bookmarked] ? true : @moment.bookmarked,
      dark: true,
      info: t('moments.form.bookmarked_info')
    )
  end

  def moment_display_resources
    moment_input_props('resource_recommendations', 'switch',
                       'moments.form.resource_recommendations_question')
      .merge(value: true, uncheckedValue: false,
             checked: @moment.resource_recommendations, dark: true)
  end

  def moment_form_inputs(edit = false)
    [
      moment_name, moment_why, moment_fix, moment_category, moment_mood,
      moment_strategy, get_viewers_input(
        @viewers, 'moment', 'moments', @moment
      ), moment_comment, moment_publishing(edit), moment_bookmarked,
      moment_display_resources
    ]
  end

  def checkboxes_for(data)
    data.map do |item|
      {
        id: item.slug, label: item.name, value: item.id,
        checked: data_for(item)&.include?(item.id)
      }
    end
  end

  def data_for(item)
    case item.class.name
    when 'Category'
      @moment.categories.pluck(:id)
    when 'Mood'
      @moment.moods.pluck(:id)
    when 'Strategy'
      @moment.strategies.pluck(:id)
    end
  end

  def options_for_templates(data)
    data.map do |item|
      { id: item.slug, label: item.name, value: item.description }
    end
  end
end
