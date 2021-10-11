# frozen_string_literal: true

module FormHelper
  def edit_form_props(inputs, action)
    return nil unless form_validation(inputs, action)

    props = form_props(inputs, action)
    props[:inputs].push(update_input).push(submit_field)
    props[:inputs] = props[:inputs].reject(&:empty?)
    props
  end

  def new_form_props(inputs, action)
    return nil unless form_validation(inputs, action)

    props = form_props(inputs, action)
    props[:inputs].push(submit_field)
    props[:inputs] = props[:inputs].reject(&:empty?)
    props
  end

  def quick_create_form_props(inputs, action)
    return nil unless form_validation(inputs, action)

    new_form_props(inputs, action)
  end

  private

  def form_props(inputs, action)
    props = { inputs: inputs }
    props[:action] = action
    props
  end

  def submit_field
    {
      id: 'submit',
      name: 'commit',
      type: 'submit',
      value: t('common.actions.submit'),
      dark: true
    }
  end

  def update_input
    { id: '_method', name: '_method', type: 'hidden', value: 'patch' }
  end

  def form_validation(inputs, action)
    inputs.instance_of?(Array) && action
  end
end
