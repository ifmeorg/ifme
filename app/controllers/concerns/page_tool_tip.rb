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
    check_blank_name(name, search)
    @page_tooltip = t("#{model_name.pluralize}.new")
  end

  def check_blank_name(name,search)
      if !name.blank? && search.exists?
      instance_variable_set(
        collection.to_s,
        search.order('created_at DESC').page(params[:page])
      )
    else
      instance_variable_set(
        collection.to_s,
        user.all.order('created_at DESC').page(params[:page])
      )
    end
  end
end
