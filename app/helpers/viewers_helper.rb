# frozen_string_literal: true

module ViewersHelper
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

  # rubocop:disable MethodLength
  def get_viewers_input(viewers, name, translation_name, obj)
    input = {}
    if viewers.present?
      input = {
        id: "#{name}_viewers",
        name: "#{name}[viewers][]",
        type: 'tag',
        checkboxes: checkboxes_viewers_input(viewers, name, obj),
        label: t('shared.viewers.plural'),
        dark: true,
        accordion: true,
        placeholder: t("#{translation_name}.form.viewers_hint")
      }
    end
    input
  end
  # rubocop:enable MethodLength

  def checkboxes_viewers_input(viewers, name, obj)
    checkboxes = []
    viewers.each do |item|
      checkboxes.push(
        id: "#{name}_viewers_#{item.id}",
        value: item.id,
        checked: obj.viewers.include?(item.id),
        label: User.find(item.id).name
      )
    end
    checkboxes
  end
end
