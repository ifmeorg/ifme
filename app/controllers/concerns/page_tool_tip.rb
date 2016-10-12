module PageToolTip
  def set(collection, model_name)
    name = params[:search]
    Object.const_get(model_name.capitalize)
    search = Object.const_get(model_name.capitalize).where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      instance_variable_set("#{collection}", search.order("created_at DESC").page(params[:page]))
    else
      instance_variable_set("#{collection}", Object.const_get(model_name.capitalize).where(:userid => current_user.id).all.order("created_at DESC").page(params[:page]))
    end
    @page_tooltip = t("#{model_name.pluralize}.new")
  end
end