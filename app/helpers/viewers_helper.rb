# helper for _viewers_indicators partial
module ViewersHelper
  private def get_viewer_list(data, link)
    if data.blank?
      link ? t('shared.viewers.you_link') : t('shared.viewers.you')
    else
      names = data.to_a.map { |id| User.find(id).name }.to_sentence
      link ? t('shared.viewers.many', viewers: names) : names
    end
  end

  private def get_viewers(data, data_type, obj)
    objs = obj.where(userid: data.userid).all.order('created_at DESC')
    objs.each do |ob|
      item = ob.send(data_type)
      return ob.viewers if item.include?(data.id)
    end
  end

  def number_of_viewers(current_user_id, strategy_owner_id, viewers)
    if strategy_owner_id == current_user_id
      names = viewers.map { |id| User.where(id: id).first.name }
      t('shared.viewers_indicator.viewers_html',
        count: viewers.count,
        names: names.to_sentence)
    else
      t('shared.viewers_indicator.you_are_viewer_html', count: viewers.length)
    end
  end

  private def add_link(link, result)
    content_tag(:span, result) do
      link_to link.name, "/#{link.model_name.plural}/#{link.id}"
    end
  end

  private def no_link(result)
    result[:class] += ' small_margin_right'
    content_tag(:span,
                content_tag(:i, ''.html_safe, class: 'fa fa-lock'),
                result).html_safe
  end

  def viewers_hover(data, link)
    result = { class: 'yes_title', title: get_viewer_list(data, link) }
    if link
      add_link(link, result)
    else
      no_link(result)
    end
  end

  def get_viewers_for(data, data_type)
    result = []
    if data && %w[category mood strategy].include?(data_type)
      result += get_viewers(data, data_type, Moment)
      if data_type == 'category'
        result += get_viewers(data, data_type, Strategy)
      end
    end
    result.uniq
  end
end
