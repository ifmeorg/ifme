# frozen_string_literal: true
module MoodsHelper
  include FormHelper
  include CategoriesHelper

  def new_mood_props
    new_form_props(mood_form_inputs, moods_path)
  end

  def quick_create_mood_props
    quick_create_form_props(mood_form_inputs, quick_create_moods_path)
  end

  def edit_mood_props
    edit_form_props(mood_form_inputs, mood_path(@mood))
  end

  private

  def mood_form_inputs
    taggable_form_inputs('mood', @mood)
  end
end
