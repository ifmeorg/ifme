require 'openssl'
require 'multi_json'

module Pusher
  # Delegates operations for a specific channel from a client
  class Channel
    attr_reader :name
    INVALID_CHANNEL_REGEX = /[^A-Za-z0-9_\-=@,.;]/

    def initialize(_, name, client = Pusher)
      if Pusher::Channel::INVALID_CHANNEL_REGEX.match(name)
        raise Pusher::Error, "Illegal channel name '#{name}'"
      elsif name.length > 200
        raise Pusher::Error, "Channel name too long (limit 164 characters) '#{name}'"
      end
      @name = name
      @client = client
    end

    # Trigger event asynchronously using EventMachine::HttpRequest
    #
    # [Deprecated] This method will be removed in a future gem version. Please
    # switch to Pusher.trigger_async or Pusher::Client#trigger_async instead
    #
    # @param (see #trigger!)
    # @return [EM::DefaultDeferrable]
    #   Attach a callback to be notified of success (with no parameters).
    #   Attach an errback to be notified of failure (with an error parameter
    #   which includes the HTTP status code returned)
    # @raise [LoadError] unless em-http-request gem is available
    # @raise [Pusher::Error] unless the eventmachine reactor is running. You
    #   probably want to run your application inside a server such as thin
    #
    def trigger_async(event_name, data, socket_id = nil)
      params = {}
      if socket_id
        validate_socket_id(socket_id)
        params[:socket_id] = socket_id
      end
      @client.trigger_async(name, event_name, data, params)
    end

    # Trigger event
    #
    # [Deprecated] This method will be removed in a future gem version. Please
    # switch to Pusher.trigger or Pusher::Client#trigger instead
    #
    # @example
    #   begin
    #     Pusher['my-channel'].trigger!('an_event', {:some => 'data'})
    #   rescue Pusher::Error => e
    #     # Do something on error
    #   end
    #
    # @param data [Object] Event data to be triggered in javascript.
    #   Objects other than strings will be converted to JSON
    # @param socket_id Allows excluding a given socket_id from receiving the
    #   event - see http://pusher.com/docs/publisher_api_guide/publisher_excluding_recipients for more info
    #
    # @raise [Pusher::Error] on invalid Pusher response - see the error message for more details
    # @raise [Pusher::HTTPError] on any error raised inside http client - the original error is available in the original_error attribute
    #
    def trigger!(event_name, data, socket_id = nil)
      params = {}
      if socket_id
        validate_socket_id(socket_id)
        params[:socket_id] = socket_id
      end
      @client.trigger(name, event_name, data, params)
    end

    # Trigger event, catching and logging any errors.
    #
    # [Deprecated] This method will be removed in a future gem version. Please
    # switch to Pusher.trigger or Pusher::Client#trigger instead
    #
    # @note CAUTION! No exceptions will be raised on failure
    # @param (see #trigger!)
    #
    def trigger(event_name, data, socket_id = nil)
      trigger!(event_name, data, socket_id)
    rescue Pusher::Error => e
      Pusher.logger.error("#{e.message} (#{e.class})")
      Pusher.logger.debug(e.backtrace.join("\n"))
    end

    # Request info for a channel
    #
    # @param info [Array] Array of attributes required (as lowercase strings)
    # @return [Hash] Hash of requested attributes for this channel
    # @raise [Pusher::Error] on invalid Pusher response - see the error message for more details
    # @raise [Pusher::HTTPError] on any error raised inside http client - the original error is available in the original_error attribute
    #
    def info(attributes = [])
      @client.channel_info(name, :info => attributes.join(','))
    end

    # Request users for a presence channel
    # Only works on presence channels (see: http://pusher.com/docs/client_api_guide/client_presence_channels and https://pusher.com/docs/rest_api)
    #
    # @example Response
    #   [{"id"=>"4"}]
    #
    # @param params [Hash] Hash of parameters for the API - see REST API docs
    # @return [Hash] Array of user hashes for this channel
    # @raise [Pusher::Error] on invalid Pusher response - see the error message for more details
    # @raise [Pusher::HTTPError] on any error raised inside Net::HTTP - the original error is available in the original_error attribute
    #
    def users(params = {})
      @client.channel_users(name, params)[:users]
    end

    # Compute authentication string required as part of the authentication
    # endpoint response. Generally the authenticate method should be used in
    # preference to this one
    #
    # @param socket_id [String] Each Pusher socket connection receives a
    #   unique socket_id. This is sent from pusher.js to your server when
    #   channel authentication is required.
    # @param custom_string [String] Allows signing additional data
    # @return [String]
    #
    def authentication_string(socket_id, custom_string = nil)
      validate_socket_id(socket_id)

      unless custom_string.nil? || custom_string.kind_of?(String)
        raise Error, 'Custom argument must be a string'
      end

      string_to_sign = [socket_id, name, custom_string].
        compact.map(&:to_s).join(':')
      Pusher.logger.debug "Signing #{string_to_sign}"
      token = @client.authentication_token
      digest = OpenSSL::Digest::SHA256.new
      signature = OpenSSL::HMAC.hexdigest(digest, token.secret, string_to_sign)

      return "#{token.key}:#{signature}"
    end

    # Generate the expected response for an authentication endpoint.
    # See http://pusher.com/docs/authenticating_users for details.
    #
    # @example Private channels
    #   render :json => Pusher['private-my_channel'].authenticate(params[:socket_id])
    #
    # @example Presence channels
    #   render :json => Pusher['private-my_channel'].authenticate(params[:socket_id], {
    #     :user_id => current_user.id, # => required
    #     :user_info => { # => optional - for example
    #       :name => current_user.name,
    #       :email => current_user.email
    #     }
    #   })
    #
    # @param socket_id [String]
    # @param custom_data [Hash] used for example by private channels
    #
    # @return [Hash]
    #
    # @private Custom data is sent to server as JSON-encoded string
    #
    def authenticate(socket_id, custom_data = nil)
      custom_data = MultiJson.encode(custom_data) if custom_data
      auth = authentication_string(socket_id, custom_data)
      r = {:auth => auth}
      r[:channel_data] = custom_data if custom_data
      r
    end

    private

    def validate_socket_id(socket_id)
      unless socket_id && /\A\d+\.\d+\z/.match(socket_id)
        raise Pusher::Error, "Invalid socket ID #{socket_id.inspect}"
      end
    end
  end
end
