module PageToolTip
  def set(collection, model_name)
    name = params[:search]
    ClassName = Object.const_get(model_name.capitalize)
    search = ClassName.where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      instance_variable_set("#{collection}", search.order("created_at DESC").page(params[:page]))
    else
      instance_variable_set("#{collection}", ClassName.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page])
    end
    page_tooltip = t("#{model_name.pluralize}.new")
  end
end