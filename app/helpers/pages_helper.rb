# frozen_string_literal: true

module PagesHelper
  include ApplicationHelper

  def print_contributors(contributors)
    contributors.map do |c|
      if c.is_a?(Hash) && c['name'].is_a?(String) && c['link'].is_a?(String)
        link_to c['name'], c['link'], target: 'blank'
      end
    end.to_sentence.html_safe
  end

  def print_partners(data)
    html = ''
    data.each_with_index do |d, index|
      break unless valid_hash?('partners', d)

      image = image_tag(d['image_link'], alt: d['name'])
      link = link_to(image, d['link'], target: 'blank')

      html += content_tag(:div, link, class: 'partner') +
              spacer_tag?(index, data.size)
    end

    html.html_safe
  end

  def print_resources(data_type, data)
    html = ''
    resource_items = fetch_resource_items(data_type, data)
    if resource_items.length.positive?
      html = fetch_resources(data_type, resource_items)
    end
    html.html_safe
  end

  private

  def fetch_resources(data_type, resource_items)
    resource_title_class = 'resources'
    if params[:resource] == data_type
      resource_title_class = 'resources page_anchor'
    end
    resource_title = content_tag(:h1, t("pages.resources.#{data_type}"),
                                 id: data_type, class: resource_title_class)
    resource_list = content_tag(:div, resource_items.html_safe,
                                id: "#{data_type}_list", class: 'resource_list')
    resource_title + resource_list
  end

  def fetch_resource_items(data_type, data)
    resource_items = ''
    data.each do |d|
      break unless valid_hash?('resources', d) && data_type.is_a?(String)
      name_link = link_to(d['name'], d['link'], target: 'blank')
      languages = fetch_items('languages', d)
      tags = fetch_items('tags', d)
      resource = name_link + languages + tags
      resource_items += content_tag(:div, resource.html_safe, class: 'resource')
    end
    resource_items
  end

  def fetch_items(item_type, items)
    list = ''
    items[item_type].each do |i|
      list += fetch_item(item_type, i)
    end
    return list unless list.length.positive?
    list += content_tag(:div, '', class: 'clear') if item_type == 'languages'
    content_tag(:div, list.html_safe, class: "resource_#{item_type}")
  end

  def fetch_item(item_type, item)
    if item_type == 'tags'
      resource_key = "pages.resources.tags.#{item}"
      resource_class = 'resource_tag'
    elsif item_type == 'languages'
      resource_key = "languages.#{item}"
      resource_class = 'resource_language'
    end
    return '' unless i18n_set? resource_key
    content_tag(:span, t(resource_key), class: resource_class)
  end

  def valid_hash?(data_type, data)
    basic_check = data.is_a?(Hash) && data['name'].is_a?(String) &&
                  data['link'].is_a?(String)
    return false unless basic_check
    data_type_check(data_type, data)
  end

  def data_type_check(data_type, data)
    if data_type == 'partners'
      data_type_check = data['image_link'].is_a?(String)
    elsif data_type == 'resources'
      data_type_check = data['tags'].is_a?(Array) &&
                        data['languages'].is_a?(Array)
    end
    data_type_check
  end

  def spacer_tag?(index, size)
    return '' unless index + 1 != size
    content_tag(:div, '', class: 'spacer')
  end
end
