autoload 'Logger', 'logger'
require 'uri'
require 'forwardable'

require 'pusher/client'

# Used for configuring API credentials and creating Channel objects
#
module Pusher
  # All errors descend from this class so they can be easily rescued
  #
  # @example
  #   begin
  #     Pusher.trigger('channel_name', 'event_name, {:some => 'data'})
  #   rescue Pusher::Error => e
  #     # Do something on error
  #   end
  class Error < RuntimeError; end
  class AuthenticationError < Error; end
  class ConfigurationError < Error
    def initialize(key)
      super "missing key `#{key}' in the client configuration"
    end
  end
  class HTTPError < Error; attr_accessor :original_error; end

  class << self
    extend Forwardable

    def_delegators :default_client, :scheme, :host, :port, :app_id, :key, :secret, :http_proxy
    def_delegators :default_client, :scheme=, :host=, :port=, :app_id=, :key=, :secret=, :http_proxy=

    def_delegators :default_client, :authentication_token, :url
    def_delegators :default_client, :encrypted=, :url=, :cluster=
    def_delegators :default_client, :timeout=, :connect_timeout=, :send_timeout=, :receive_timeout=, :keep_alive_timeout=

    def_delegators :default_client, :get, :get_async, :post, :post_async
    def_delegators :default_client, :channels, :channel_info, :channel_users, :trigger, :trigger_async
    def_delegators :default_client, :authenticate, :webhook, :channel, :[]

    attr_writer :logger

    def logger
      @logger ||= begin
        log = Logger.new($stdout)
        log.level = Logger::INFO
        log
      end
    end

    def default_client
      @default_client ||= begin
        cli = Pusher::Client
        ENV['PUSHER_URL'] ? cli.from_env : cli.new
      end
    end
  end
end

require 'pusher/channel'
require 'pusher/request'
require 'pusher/resource'
require 'pusher/webhook'
