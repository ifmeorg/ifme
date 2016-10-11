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
      html.concat spacer_tag?(index, data.size)
    end

    html.html_safe
  end

  private

  def valid_hash?(d)
    check = [d['name'], d['link'], d['image_link']].all? { |e| e.is_a?(String) }

    d.is_a?(Hash) && check
  end

  def spacer_tag?(index, size)
    content_tag(:div, class: 'spacer') if index + 1 != size
  end
end
