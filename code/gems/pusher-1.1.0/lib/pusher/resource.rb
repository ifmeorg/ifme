module Pusher
  class Resource
    def initialize(client, path)
      @client = client
      @path = path
    end

    def get(params)
      create_request(:get, params).send_sync
    end

    def get_async(params)
      create_request(:get, params).send_async
    end

    def post(params)
      body = MultiJson.encode(params)
      create_request(:post, {}, body).send_sync
    end

    def post_async(params)
      body = MultiJson.encode(params)
      create_request(:post, {}, body).send_async
    end

    private

    def create_request(verb, params, body = nil)
      Request.new(@client, verb, url, params, body)
    end

    def url
      @_url ||= @client.url(@path)
    end
  end
end
