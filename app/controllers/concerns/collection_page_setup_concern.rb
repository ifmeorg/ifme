# frozen_string_literal: true
module CollectionPageSetupConcern
  extend ActiveSupport::Concern

  included do
    helper_method :page_collection, :setup_collection
  end

  def page_collection(collection, model_name, filters_model = {})
    name = params[:search]
    search_filters = params[:filters]
    model = Object.const_get(model_name.capitalize)
    search = model.where(
      'name ilike ? AND user_id = ?',
      "%#{name}%",
      current_user.id
    ).all
    user = model.where(user_id: current_user.id)
    user = apply_filters(user, search_filters, filters_model[:filters]) if search_filters.present?
    setup_collection(collection, user, search, name)
    @multiselect_checkboxes = filters_model[:checkboxes]
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

  def apply_filters(user, search_filters, filters_model)
    filtered_user = user
    search_filters.each do |filter|
      filtered_user = filtered_user.where(filters_model[filter])
    end
    filtered_user.count > 0 ? filtered_user : user
  end
end
