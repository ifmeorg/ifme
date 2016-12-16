# helper for _viewers_indicators partial
module ViewersHelper
  def number_of_viewers(current_user_id, strategy_owner_id, viewers)
    if strategy_owner_id == current_user_id
      viewer_names = viewers.map { |id| User.where(id: id).first.name }
      t('shared.viewers_indicator.viewers_html',
        count: viewers.count,
        names: viewer_names.to_sentence)
    else
      t('shared.viewers_indicator.you_are_viewer_html', count: viewers.length)
    end
  end

  def viewers_hover(data, link)
    result = {:class => 'yes_title'}
    if data.blank? || data.length == 0
      viewers = link ? t('shared.viewers.you_link') : t('shared.viewers.you')
    else
      viewer_names = data.to_a.map { |user_id| User.find(user_id).name }.to_sentence()
      viewers = link ? t('shared.viewers.many', viewers: viewer_names) : viewer_names
    end
    result[:title] = viewers
    if link
      content_tag(:span, result) do
        link_to link.name, (link.class.link + link.id.to_s)
      end
    else
      result[:class] += ' small_margin_right'
      content_tag(:span, tag(:i, :class => 'fa fa-lock'), result)
    end
  end

  def get_viewers_for(data, data_type)
    result = Array.new

    if data && (data_type == 'category' || data_type == 'mood' || data_type == 'strategy')
      Moment.where(userid: data.userid).all.order("created_at DESC").each do |moment|
        item = moment.send(data_type)
        if item.include?(data.id)
          result += moment.viewers
        end
      end

      if (data_type == 'category')
        Strategy.where(userid: data.userid).all.order("created_at DESC").each do |strategy|
          if strategy.category.include?(data.id)
            result += strategy.viewers
          end
        end
      end
    end

    return result.uniq
  end
end
