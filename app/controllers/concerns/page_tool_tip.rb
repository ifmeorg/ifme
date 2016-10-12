module PageToolTip
  def set(tips, mod_name)
    name = params[:search]
    capt_name = tips.capitalize
    ClassName = capt_name.constantize
    search = ClassName.where("name ilike ? AND userid = ?", "%#{name}%", current_user.id).all
    if !name.blank? && search.exists?
      tips = search.order("created_at DESC").page(params[:page])
    else
      tips = ClassName.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page])
    end
    page_tooltip = t("#{mod_name}.new")
  end
end