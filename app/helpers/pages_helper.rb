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
      tags_list = fetch_tags(d)
      tags = content_tag(:div, tags_list.html_safe, class: 'resource_tags')
      resource = name_link + tags
      resource_items += content_tag(:div, resource.html_safe, class: 'resource')
    end
    resource_items
  end

  def fetch_tags(resource_item)
    tags_list = ''
    resource_item['tags'].each do |t|
      if i18n_set? "pages.resources.tags.#{t}"
        tags_list += content_tag(:span, t("pages.resources.tags.#{t}"),
                                 class: 'resource_tag')
      end
    end
    tags_list
  end

  def valid_hash?(data_type, data)
    basic_check = data.is_a?(Hash) && data['name'].is_a?(String) &&
                  data['link'].is_a?(String)
    return false unless basic_check
    if data_type == 'partners'
      data_type_check = data['image_link'].is_a?(String)
    elsif data_type == 'resources'
      data_type_check = data['tags'].is_a?(Array)
    end
    data_type_check
  end

  def spacer_tag?(index, size)
    return '' unless index + 1 != size
    content_tag(:div, '', class: 'spacer')
  end
end
