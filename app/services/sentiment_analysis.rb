require 'net/http'
require_relative 'sentimental'

class SentimentAnalysis
  attr_reader :language, :id, :text

  def initialize(language:, id:, text:)
    @language = language
    @id = id
    @text = text
  end

  # TODO: put this back in place
  # def get_sentiment
  #   uri = URI('https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  #   uri.query = URI.encode_www_form({})
  #
  #   request = Net::HTTP::Post.new(uri.request_uri)
  #   request['Content-Type'] = 'application/json'
  #   request['Ocp-Apim-Subscription-Key'] = ENV["OCP_APM_SUBSCRIPTION_KEY"]
  #   request.body = {
  #     "documents": [
  #       {
  #         "language": language,
  #         "id": id,
  #         "text": text
  #       }
  #     ]
  #   }.to_json
  #
  #   response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  #     http.request(request)
  #   end
  #
  #   puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  #   puts response.body
  #   puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  # end

  # TODO: figure out how to properly base class in Ruby
  def get_sentiment
    # Create an instance for usage
    analyzer = Sentimental.new

    # Load the default sentiment dictionaries
    analyzer.load_defaults

    # And/or load your own dictionaries
    # analyzer.load_senti_file('path/to/your/file.txt')

    # Set a global threshold
    analyzer.threshold = 0.5

    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts analyzer.sentiment(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts analyzer.explain(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  end
end
