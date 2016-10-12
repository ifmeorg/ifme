module PageToolTip
  def set(tips, model_name)
    name = params[:search]
    ClassName = Object.const_get(model_name.capitalize)
    search = ClassName.where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      tips = search.order("created_at DESC").page(params[:page])
    else
      tips = ClassName.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page])
    end
    page_tooltip = t("#{model_name}.new")
  end
end