require 'net/http'

class SentimentAnalysis
  attr_reader :language, :id, :text

  def initialize(language:, id:, text:)
    @language = language
    @id = id
    @text = text
  end

  def get_sentiment
    uri = URI('https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
    uri.query = URI.encode_www_form({})

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = ENV["OCP_APM_SUBSCRIPTION_KEY"]
    request.body = {
      "documents": [
        {
          "language": language,
          "id": id,
          "text": text
        }
      ]
    }

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end

    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts response.body
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  end
end
