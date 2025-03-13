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
      FormInput.new("moment_#{field}", type, "moment[#{field}]#{group ? '[]' : ''}", t(label)).to_h
    end
  
    def moment_text_input_props(field, type, label, required = false)
      moment_input_props(field, type, label)
        .merge(value: @moment[field] || nil, required: required, dark: true)
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
      FormInput.new('moment_publishing', 'switch', 'publishing', t('moments.form.draft_question'), '0', false, true, nil, nil, nil, { uncheckedValue: '1', checked: edit ? !@moment.published? : @moment.published? }).to_h
    end
  
    def moment_bookmarked
      FormInput.new('bookmarked', 'switch', 'moment[bookmarked]', t('moments.form.bookmarked_question'), true, false, true, nil, nil, nil, { uncheckedValue: false, checked: params[:bookmarked] ? true : @moment.bookmarked, info: t('moments.form.bookmarked_info') }).to_h
    end
  
    def moment_display_resources
      FormInput.new('resource_recommendations', 'switch', 'moment[resource_recommendations]', t('moments.form.resource_recommendations_question'), true, false, true, nil, nil, nil, { uncheckedValue: false, checked: @moment.resource_recommendations }).to_h
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
      data.map do |item|
        { id: item.slug, label: item.name, value: item.description }
      end
    end
  end
  
  class FormInput
    attr_reader :id, :type, :name, :label, :value, :required, :dark, :options, :placeholder, :checkboxes, :form_props
  
    def initialize(id, type, name, label, value = nil, required = false, dark = false, options = nil, placeholder = nil, checkboxes = nil, form_props = nil)
      @id = id
      @type = type
      @name = name
      @label = label
      @value = value
      @required = required
      @dark = dark
      @options = options
      @placeholder = placeholder
      @checkboxes = checkboxes
      @form_props = form_props
    end
  
    def to_h
      {
        id: @id,
        type: @type,
        name: @name,
        label: @label,
        value: @value,
        required: @required,
        dark: @dark,
        options: @options,
        placeholder: @placeholder,
        checkboxes: @checkboxes,
        formProps: @form_props
      }
    end
  end
