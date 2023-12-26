# frozen_string_literal: true

require 'open-uri'
require 'json'

class Medium
  def posts
    content_hash['payload']['references']['Post']
  end

  private

  def content_hash
    JSON.parse(content[16..])
  end

  def content
    content = ''
    URI.open('https://medium.com/ifme?format=json', 'User-Agent' => 'if-me.org') do |file|
      file.each_line { |line| content += line }
    end
    content
  end
end
