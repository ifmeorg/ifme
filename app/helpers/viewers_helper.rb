# frozen_string_literal: true

module ViewersHelper
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

  def viewers_hover(data, link)
    react_component(
      'Tooltip',
      props: {
        element: get_link(link),
        text: get_viewer_list(data, link),
        center: true
      }
    )
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

  private

  def get_link(link)
    link_to(
      link.name,
      link.model_name.to_s.classify.constantize.find(link.id)
    )
  end

  def get_viewer_list(data, link)
    if data.blank?
      link ? t('shared.viewers.you_link') : t('shared.viewers.you')
    else
      names = data.to_a.map { |id| User.find(id).name }.to_sentence
      link ? t('shared.viewers.many', viewers: names) : names
    end
  end

  def get_viewers(data, data_type, obj)
    objs = obj.where(user_id: data.user_id).all.order('created_at DESC')
    objs.each do |ob|
      item = ob.send(data_type)
      return ob.viewers if item.include?(data.id)
    end
    []
  end
end
