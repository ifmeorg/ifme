# frozen_string_literal: true

require 'open-uri'
require 'json'

class Medium
  def posts
    content_hash['payload']['references']['Post']
  end

  private

  def content_hash
    JSON.parse(content[16..-1])
  end

  def content
    content = ''
    open('https://medium.com/ifme?format=json') do |file|
      file.each_line { |line| content += line }
    end
    content
  end
end
