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
    if data && %w[categories moods strategies].include?(data_type)
      result += get_viewers(data, data_type, Moment)
      if data_type == 'categories'
        result += get_viewers(data, data_type, Strategy)
      end
    end
    result.uniq
  end

  def element_visibility_based_props(element)
    {
      dark: true,
      actions: {
        delete: {
          name: t('common.actions.delete'),
          link: url_for(element),
          dataConfirm: t('common.actions.confirm'),
          dataMethod: 'delete'
        },
        edit: {
          name: t('common.actions.edit'),
          link: url_for([:edit, element])
        },
        not_visible: !element.visible && get_visible(element.visible),
        viewers: element.respond_to?(:viewers) &&
          get_viewer_list(element.viewers, nil),
        visible: element.visible && get_visible(element.visible)
      }.delete_if { |_, value| value == false },
      storyName: element.name
    }
  end

  private

  def get_link(link)
    link_to(
      link.name,
      link.model_name.to_s.classify.constantize.find(link.id)
    )
  end

  def only_you_as_viewer(link)
    link ? t('shared.viewers.you_link') : t('shared.viewers.you')
  end

  def get_viewer_list(data, link)
    return only_you_as_viewer(link) if data.blank?

    names = data.to_a.map { |id| User.find_by(id: id).name }.to_sentence
    link ? t('shared.viewers.many', viewers: names) : names
  end

  def get_viewers(data, data_type, obj)
    objs = obj.where(user_id: data.user_id).all.order('created_at DESC')
    objs.each do |ob|
      item = ob.send(data_type).pluck(:id)
      return ob.viewers if item.include?(data.id)
    end
    []
  end

  def get_viewers_input(viewers, name, translation_name, obj)
    return {} if viewers.blank?

    {
      id: "#{name}_viewers",
      name: "#{name}[viewers][]",
      type: 'tag',
      checkboxes: checkboxes_viewers_input(viewers, name, obj),
      label: t('shared.viewers.plural'),
      placeholder: t("#{translation_name}.form.viewers_hint")
    }.merge(dark: true, accordion: true)
  end

  def checkboxes_viewers_input(viewers, name, obj)
    checkboxes = []
    viewers.each do |item|
      user = User.find(item.id)
      checkboxes.push(
        id: "#{name}_viewers_#{item.id}",
        value: item.id,
        checked: obj.viewers.include?(item.id),
        label: sanitize(user.name).presence || user.email
      )
    end
    checkboxes
  end
end
