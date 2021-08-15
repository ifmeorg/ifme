# frozen_string_literal: true
module CollectionPageSetupConcern
  extend ActiveSupport::Concern

  included do
    helper_method :page_collection, :setup_collection
  end

  def page_collection(collection, model_name, filters_model = {})
    name = params[:search]
    selected_filters = params[:filters]
    model = Object.const_get(model_name.capitalize)
    search = model.where(
      'name ilike ? AND user_id = ?',
      "%#{name}%",
      current_user.id
    ).all
    user = model.where(user_id: current_user.id)
    if selected_filters.present?
      user = apply_filters(user, selected_filters, filters_model[:filters])
    end
    setup_collection(collection, user, search, name)
    @options_for_multiselect = filters_model[:options]
    @page_new = t("#{model_name.pluralize}.new")
  end

  def setup_collection(collection, user, search, name)
    search_query = search.exists? && name.present? ? search : user.all
    instance_variable_set(
      collection.to_s,
      search_query.order('created_at DESC').page(params[:page])
    )
  end

  private

  def apply_filters(user, selected_filters, filters_model)
    filters_list = selected_filters.split(',')

    filters_list.each do |filter|
      user = user.where(filters_model[filter.to_i])
    end
    user
  end
end
