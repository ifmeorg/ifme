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

  private

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
