# frozen_string_literal: true
module CollectionPageSetupConcern
  extend ActiveSupport::Concern

  included do
    helper_method :page_collection, :setup_collection
  end

  def page_collection(collection, model_name)
    name = params[:search]
    model = Object.const_get(model_name.capitalize)
    search = model.where(
      'name ilike ? AND user_id = ?',
      "%#{name}%",
      current_user.id
    ).all
    user = model.where(user_id: current_user.id)
    setup_collection(collection, user, search, name)
    @page_new = t("#{model_name.pluralize}.new")
  end

  def setup_collection(collection, user, search, name)
    search_query = search.exists? && name.present? ? search : user.all
    instance_variable_set(
      collection.to_s,
      search_query.order('created_at DESC').page(params[:page])
    )
  end
end
