require 'open-uri'
require 'json'

class Medium
  def posts
    payload = JSON.parse(content[16..-1])['payload']
    payload['references']['Post']
  end

  private

  def content
    content = ''
    open('https://medium.com/ifme?format=json') do |file|
      file.each_line { |line| content << line }
    end
    content
 end
end
