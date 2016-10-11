module PagesHelper
  def print_contributors(contributors)
    contributors.map do |c|
      if c.is_a?(Hash) && c['name'].is_a?(String) && c['link'].is_a?(String)
        link_to c['name'], c['link'], target: 'blank'
      end
    end.to_sentence.html_safe
  end

  def print_partners(data)
    return_this = ''
    data.each_with_index do |d, index|
      if d.is_a?(Hash) && d['name'].is_a?(String) && d['link'].is_a?(String) && d['image_link'].is_a?(String)
        image = image_tag(d['image_link'], alt: d['name'])
        return_this += '<div class="partner">'
        return_this += link_to image, d['link'], target: 'blank'
        return_this += '</div>'

        return_this += '<div class="spacer"></div>' if index + 1 != data.length
      else
        break
      end
    end

    return_this.html_safe
  end
end
