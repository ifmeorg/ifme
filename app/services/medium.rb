# frozen_string_literal: true

require 'open-uri'
require 'json'

class Medium
  def posts
    content_hash['items']
  end

  private

  def content_hash
    JSON.parse(content)
  end

  def content
    content = ''
    URI.open('https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/ifme') do |file|
      file.each_line { |line| content += line }
    end
    content
  end
end
