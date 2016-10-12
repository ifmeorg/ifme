module PageToolTip
  def set(collection, model_name)
    name = params[:search]
    model = Object.const_get(model_name.capitalize)
    search = model.where(
      'name ilike ? AND userid = ?',
      "%#{name}%",
      current_user.id
    ).all
    user = model.where(userid: current_user.id)
    set_collection(collection, user, search, name)
    @page_tooltip = t("#{model_name.pluralize}.new")
  end

  def set_collection(collection, user, search, name)
    search_query = search.exists? && !name.blank? ? search : user.all
    instance_variable_set(
      collection.to_s,
      search_query.order('created_at DESC').page(params[:page])
    )
  end
end


