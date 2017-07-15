# frozen_string_literal: true

module PagesHelper
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
      break unless valid_partners_hash? d

      image = image_tag(d['image_link'], alt: d['name'])
      link = link_to(image, d['link'], target: 'blank')

      html += content_tag(:div, link, class: 'partner') +
              spacer_tag?(index, data.size)
    end

    html.html_safe
  end

  def print_resources(data_type, data)
    resource_items = ''
    data.each do |d|
      break unless valid_resources_hash? d
      name_link = link_to(d['name'], d['link'], target: 'blank')
      tags_list = ''
      d['tags'].each do |t|
        if i18n_set? "pages.resources.tags.#{t}"
          tags_list += content_tag(:span, t("pages.resources.tags.#{t}"), class: 'resource_tag')
        end
      end
      tags = content_tag(:div, tags_list.html_safe, class: "resource_tags")
      resource = name_link + tags
      resource_items += content_tag(:div, resource.html_safe, class: 'resource')
    end

    resource_title = content_tag(:h1, t("pages.resources.#{data_type}"), id: data_type, class: 'resources')
    resource_list = content_tag(:div, resource_items.html_safe, id: "#{data_type}_list", class: "resource_list")
    html = resource_title + resource_list
    html.html_safe
  end

  private

  def valid_partners_hash?(d)
    d.is_a?(Hash) && d['name'].is_a?(String) && d['link'].is_a?(String) &&
      d['image_link'].is_a?(String)
  end

  def spacer_tag?(index, size)
    return '' unless index + 1 != size

    content_tag(:div, '', class: 'spacer')
  end

  def valid_resources_hash?(d)
    d.is_a?(Hash) && d['name'].is_a?(String) && d['link'].is_a?(String) &&
      d['tags'].is_a?(Array)
  end
end
