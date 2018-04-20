require 'faraday'
require 'logger'

module OAuth2
  # The OAuth2::Client class
  class Client # rubocop:disable Metrics/ClassLength
    attr_reader :id, :secret, :site
    attr_accessor :options
    attr_writer :connection

    # Instantiate a new OAuth 2.0 client using the
    # Client ID and Client Secret registered to your
    # application.
    #
    # @param [String] client_id the client_id value
    # @param [String] client_secret the client_secret value
    # @param [Hash] opts the options to create the client with
    # @option opts [String] :site the OAuth2 provider site host
    # @option opts [String] :redirect_uri the absolute URI to the Redirection Endpoint for use in authorization grants and token exchange
    # @option opts [String] :authorize_url ('/oauth/authorize') absolute or relative URL path to the Authorization endpoint
    # @option opts [String] :token_url ('/oauth/token') absolute or relative URL path to the Token endpoint
    # @option opts [Symbol] :token_method (:post) HTTP method to use to request token (:get or :post)
    # @option opts [Symbol] :auth_scheme (:basic_auth) HTTP method to use to authorize request (:basic_auth or :request_body)
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @option opts [Boolean] :raise_errors (true) whether or not to raise an OAuth2::Error
    #  on responses with 400+ status codes
    # @yield [builder] The Faraday connection builder
    def initialize(client_id, client_secret, options = {}, &block)
      opts = options.dup
      @id = client_id
      @secret = client_secret
      @site = opts.delete(:site)
      ssl = opts.delete(:ssl)
      @options = {:authorize_url    => '/oauth/authorize',
                  :token_url        => '/oauth/token',
                  :token_method     => :post,
                  :auth_scheme      => :request_body,
                  :connection_opts  => {},
                  :connection_build => block,
                  :max_redirects    => 5,
                  :raise_errors     => true}.merge(opts)
      @options[:connection_opts][:ssl] = ssl if ssl
    end

    # Set the site host
    #
    # @param [String] the OAuth2 provider site host
    def site=(value)
      @connection = nil
      @site = value
    end

    # The Faraday connection object
    def connection
      @connection ||= begin
        conn = Faraday.new(site, options[:connection_opts])
        if options[:connection_build]
          conn.build do |b|
            options[:connection_build].call(b)
          end
        end
        conn
      end
    end

    # The authorize endpoint URL of the OAuth2 provider
    #
    # @param [Hash] params additional query parameters
    def authorize_url(params = {})
      params = (params || {}).merge(redirection_params)
      connection.build_url(options[:authorize_url], params).to_s
    end

    # The token endpoint URL of the OAuth2 provider
    #
    # @param [Hash] params additional query parameters
    def token_url(params = nil)
      connection.build_url(options[:token_url], params).to_s
    end

    # Makes a request relative to the specified site root.
    #
    # @param [Symbol] verb one of :get, :post, :put, :delete
    # @param [String] url URL path of request
    # @param [Hash] opts the options to make the request with
    # @option opts [Hash] :params additional query parameters for the URL of the request
    # @option opts [Hash, String] :body the body of the request
    # @option opts [Hash] :headers http request headers
    # @option opts [Boolean] :raise_errors whether or not to raise an OAuth2::Error on 400+ status
    #   code response for this request.  Will default to client option
    # @option opts [Symbol] :parse @see Response::initialize
    # @yield [req] The Faraday request
    def request(verb, url, opts = {}) # rubocop:disable CyclomaticComplexity, MethodLength, Metrics/AbcSize
      connection.response :logger, ::Logger.new($stdout) if ENV['OAUTH_DEBUG'] == 'true'

      url = connection.build_url(url, opts[:params]).to_s

      response = connection.run_request(verb, url, opts[:body], opts[:headers]) do |req|
        yield(req) if block_given?
      end
      response = Response.new(response, :parse => opts[:parse])

      case response.status
      when 301, 302, 303, 307
        opts[:redirect_count] ||= 0
        opts[:redirect_count] += 1
        return response if opts[:redirect_count] > options[:max_redirects]
        if response.status == 303
          verb = :get
          opts.delete(:body)
        end
        request(verb, response.headers['location'], opts)
      when 200..299, 300..399
        # on non-redirecting 3xx statuses, just return the response
        response
      when 400..599
        error = Error.new(response)
        raise(error) if opts.fetch(:raise_errors, options[:raise_errors])
        response.error = error
        response
      else
        error = Error.new(response)
        raise(error, "Unhandled status code value of #{response.status}")
      end
    end

    # Initializes an AccessToken by making a request to the token endpoint
    #
    # @param [Hash] params a Hash of params for the token endpoint
    # @param [Hash] access token options, to pass to the AccessToken object
    # @param [Class] class of access token for easier subclassing OAuth2::AccessToken
    # @return [AccessToken] the initalized AccessToken
    def get_token(params, access_token_opts = {}, access_token_class = AccessToken) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      params = Authenticator.new(id, secret, options[:auth_scheme]).apply(params)
      opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
      headers = params.delete(:headers) || {}
      if options[:token_method] == :post
        opts[:body] = params
        opts[:headers] = {'Content-Type' => 'application/x-www-form-urlencoded'}
      else
        opts[:params] = params
        opts[:headers] = {}
      end
      opts[:headers].merge!(headers)
      response = request(options[:token_method], token_url, opts)
      if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])
        error = Error.new(response)
        raise(error)
      end
      access_token_class.from_hash(self, response.parsed.merge(access_token_opts))
    end

    # The Authorization Code strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.1
    def auth_code
      @auth_code ||= OAuth2::Strategy::AuthCode.new(self)
    end

    # The Implicit strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-26#section-4.2
    def implicit
      @implicit ||= OAuth2::Strategy::Implicit.new(self)
    end

    # The Resource Owner Password Credentials strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.3
    def password
      @password ||= OAuth2::Strategy::Password.new(self)
    end

    # The Client Credentials strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.4
    def client_credentials
      @client_credentials ||= OAuth2::Strategy::ClientCredentials.new(self)
    end

    def assertion
      @assertion ||= OAuth2::Strategy::Assertion.new(self)
    end

    # The redirect_uri parameters, if configured
    #
    # The redirect_uri query parameter is OPTIONAL (though encouraged) when
    # requesting authorization. If it is provided at authorization time it MUST
    # also be provided with the token exchange request.
    #
    # Providing the :redirect_uri to the OAuth2::Client instantiation will take
    # care of managing this.
    #
    # @api semipublic
    #
    # @see https://tools.ietf.org/html/rfc6749#section-4.1
    # @see https://tools.ietf.org/html/rfc6749#section-4.1.3
    # @see https://tools.ietf.org/html/rfc6749#section-4.2.1
    # @see https://tools.ietf.org/html/rfc6749#section-10.6
    # @return [Hash] the params to add to a request or URL
    def redirection_params
      if options[:redirect_uri]
        {'redirect_uri' => options[:redirect_uri]}
      else
        {}
      end
    end
  end
end
