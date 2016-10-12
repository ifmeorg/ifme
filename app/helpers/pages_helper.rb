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
      break unless valid_hash? d

      image = image_tag(d['image_link'], alt: d['name'])
      link = link_to(image, d['link'], target: 'blank')

      html.concat(content_tag(:div, link, class: 'partner'))
          .concat(spacer_tag?(index, data.size))
    end

    html.html_safe
  end

  private

  def valid_hash?(d)
    d.is_a?(Hash) && d['name'].is_a?(String) && d['link'].is_a?(String) &&
      d['image_link'].is_a?(String)
  end

  def spacer_tag?(index, size)
    return '' unless index + 1 != size

    tag :div, class: 'spacer'
  end
end
