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
    result = ''

    if data.blank? || data.length == 0
      if link
        viewers = t('shared.viewers.you_link')
      else
        viewers = t('shared.viewers.you')
      end
    else
      viewer_names = data.to_a.map { |user_id| User.find(user_id).name }.to_sentence()
      if link
        viewers = t('shared.viewers.many', viewers: viewer_names)
      else
        viewers = viewer_names
      end
    end

    if link
      if link.class.name == 'Category'
        link_url = '/categories/' + link.id.to_s
      elsif link.class.name == 'Mood'
        link_url = '/moods/' + link.id.to_s
      elsif link.class.name == 'Strategy'
        link_url = '/strategies/' + link.id.to_s
      end

      result += '<span class="yes_title" title="' + viewers + '">'
      result += link_to link.name, link_url
      result += '</span>'
    else
      result += '<span class="yes_title small_margin_right" title="' + viewers + '"><i class="fa fa-lock"></i></span>'
    end

    return result.html_safe
  end
end
