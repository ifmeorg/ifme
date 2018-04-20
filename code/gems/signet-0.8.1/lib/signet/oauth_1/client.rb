# Copyright (C) 2010 Google Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'faraday'
#require 'faraday/utils'

require 'stringio'
require 'addressable/uri'
require 'signet'
require 'signet/errors'
require 'signet/oauth_1'
require 'signet/oauth_1/credential'

module Signet
  module OAuth1
    class Client
      ##
      # Creates an OAuth 1.0 client.
      #
      # @param [Hash] options
      #   The configuration parameters for the client.
      #   - <code>:temporary_credential_uri</code> -
      #     The OAuth temporary credentials URI.
      #   - <code>:authorization_uri</code> -
      #     The OAuth authorization URI.
      #   - <code>:token_credential_uri</code> -
      #     The OAuth token credentials URI.
      #   - <code>:client_credential_key</code> -
      #     The OAuth client credential key.
      #   - <code>:client_credential_secret</code> -
      #     The OAuth client credential secret.
      #   - <code>:callback</code> -  The OAuth callback.  Defaults to 'oob'.
      #
      # @example
      #   client = Signet::OAuth1::Client.new(
      #     :temporary_credential_uri =>
      #       'https://www.google.com/accounts/OAuthGetRequestToken',
      #     :authorization_uri =>
      #       'https://www.google.com/accounts/OAuthAuthorizeToken',
      #     :token_credential_uri =>
      #       'https://www.google.com/accounts/OAuthGetAccessToken',
      #     :client_credential_key => 'anonymous',
      #     :client_credential_secret => 'anonymous'
      #   )
      def initialize(options={})
        self.update!(options)
      end

      ##
      # Updates an OAuth 1.0 client.
      #
      # @param [Hash] options
      #   The configuration parameters for the client.
      #   - <code>:temporary_credential_uri</code> -
      #     The OAuth temporary credentials URI.
      #   - <code>:authorization_uri</code> -
      #     The OAuth authorization URI.
      #   - <code>:token_credential_uri</code> -
      #     The OAuth token credentials URI.
      #   - <code>:client_credential_key</code> -
      #     The OAuth client credential key.
      #   - <code>:client_credential_secret</code> -
      #     The OAuth client credential secret.
      #   - <code>:callback</code> -  The OAuth callback.  Defaults to 'oob'.
      #
      # @example
      #   client.update!(
      #     :temporary_credential_uri =>
      #       'https://www.google.com/accounts/OAuthGetRequestToken',
      #     :authorization_uri =>
      #       'https://www.google.com/accounts/OAuthAuthorizeToken',
      #     :token_credential_uri =>
      #       'https://www.google.com/accounts/OAuthGetAccessToken',
      #     :client_credential_key => 'anonymous',
      #     :client_credential_secret => 'anonymous'
      #   )
      #
      # @see Signet::OAuth1::Client#initialize
      def update!(options={})
        # Normalize key to String to allow indifferent access.
        options = options.inject({}) { |accu, (k, v)| accu[k.to_s] = v; accu }
        self.temporary_credential_uri = options["temporary_credential_uri"]
        self.authorization_uri = options["authorization_uri"]
        self.token_credential_uri = options["token_credential_uri"]
        # Technically... this would allow you to pass in a :client key...
        # But that would be weird.  Don't do that.
        self.client_credential_key =
          Signet::OAuth1.extract_credential_key_option("client", options)
        self.client_credential_secret =
          Signet::OAuth1.extract_credential_secret_option("client", options)
        self.temporary_credential_key =
          Signet::OAuth1.extract_credential_key_option("temporary", options)
        self.temporary_credential_secret =
          Signet::OAuth1.extract_credential_secret_option("temporary", options)
        self.token_credential_key =
          Signet::OAuth1.extract_credential_key_option("token", options)
        self.token_credential_secret =
          Signet::OAuth1.extract_credential_secret_option("token", options)
        self.callback = options["callback"]
        self.two_legged = options["two_legged"] || false
        return self
      end

      ##
      # Returns the temporary credentials URI for this client.
      #
      # @return [Addressable::URI] The temporary credentials URI.
      def temporary_credential_uri
        return @temporary_credential_uri
      end
      alias_method :request_token_uri, :temporary_credential_uri

      ##
      # Sets the temporary credentials URI for this client.
      #
      # @param [Addressable::URI, String, #to_str]
      #   new_temporary_credential_uri
      #   The temporary credentials URI.
      def temporary_credential_uri=(new_temporary_credential_uri)
        if new_temporary_credential_uri != nil
          new_temporary_credential_uri =
            Addressable::URI.parse(new_temporary_credential_uri)
          @temporary_credential_uri = new_temporary_credential_uri
        else
          @temporary_credential_uri = nil
        end
      end
      alias_method :request_token_uri=, :temporary_credential_uri=

      ##
      # Returns the authorization URI that the user should be redirected to.
      #
      # @return [Addressable::URI] The authorization URI.
      #
      # @see Signet::OAuth1.generate_authorization_uri
      def authorization_uri(options={})
        options = options.merge(
          :temporary_credential_key => self.temporary_credential_key,
          :callback => self.callback
        )
        return nil if @authorization_uri == nil
        return Addressable::URI.parse(
          ::Signet::OAuth1.generate_authorization_uri(
            @authorization_uri, options
          )
        )
      end

      ##
      # Sets the authorization URI for this client.
      #
      # @param [Addressable::URI, String, #to_str] new_authorization_uri
      #   The authorization URI.
      def authorization_uri=(new_authorization_uri)
        if new_authorization_uri != nil
          new_authorization_uri = Addressable::URI.send(
            new_authorization_uri.kind_of?(Hash) ? :new : :parse,
            new_authorization_uri
          )
          @authorization_uri = new_authorization_uri
        else
          @authorization_uri = nil
        end
      end

      ##
      # Returns the token credential URI for this client.
      #
      # @return [Addressable::URI] The token credential URI.
      def token_credential_uri
        return @token_credential_uri
      end
      alias_method :access_token_uri, :token_credential_uri

      ##
      # Sets the token credential URI for this client.
      #
      # @param [Addressable::URI, Hash, String, #to_str] new_token_credential_uri
      #   The token credential URI.
      def token_credential_uri=(new_token_credential_uri)
        if new_token_credential_uri != nil
          new_token_credential_uri = Addressable::URI.send(
            new_token_credential_uri.kind_of?(Hash) ? :new : :parse,
            new_token_credential_uri
          )
          @token_credential_uri = new_token_credential_uri
        else
          @token_credential_uri = nil
        end
      end
      alias_method :access_token_uri=, :token_credential_uri=

      # Lots of duplicated code here, but for the sake of auto-generating
      # documentation, we're going to let it slide.  Oh well.

      ##
      # Returns the client credential for this client.
      #
      # @return [Signet::OAuth1::Credential] The client credentials.
      def client_credential
        if self.client_credential_key && self.client_credential_secret
          return ::Signet::OAuth1::Credential.new(
            self.client_credential_key,
            self.client_credential_secret
          )
        elsif !self.client_credential_key && !self.client_credential_secret
          return nil
        else
          raise ArgumentError,
            "The client credential key and secret must be set."
        end
      end
      alias_method :consumer_token, :client_credential

      ##
      # Sets the client credential for this client.
      #
      # @param [Signet::OAuth1::Credential] new_client_credential
      #   The client credentials.
      def client_credential=(new_client_credential)
        if new_client_credential != nil
          if !new_client_credential.kind_of?(::Signet::OAuth1::Credential)
            raise TypeError,
              "Expected Signet::OAuth1::Credential, " +
              "got #{new_client_credential.class}."
          end
          @client_credential_key = new_client_credential.key
          @client_credential_secret = new_client_credential.secret
        else
          @client_credential_key = nil
          @client_credential_secret = nil
        end
      end
      alias_method :consumer_token=, :client_credential=

      ##
      # Returns the client credential key for this client.
      #
      # @return [String] The client credential key.
      def client_credential_key
        return @client_credential_key
      end
      alias_method :consumer_key, :client_credential_key

      ##
      # Sets the client credential key for this client.
      #
      # @param [String, #to_str] new_client_credential_key
      #   The client credential key.
      def client_credential_key=(new_client_credential_key)
        if new_client_credential_key != nil
          if !new_client_credential_key.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_client_credential_key.class} into String."
          end
          new_client_credential_key = new_client_credential_key.to_str
          @client_credential_key = new_client_credential_key
        else
          @client_credential_key = nil
        end
      end
      alias_method :consumer_key=, :client_credential_key=

      ##
      # Returns the client credential secret for this client.
      #
      # @return [String] The client credential secret.
      def client_credential_secret
        return @client_credential_secret
      end
      alias_method :consumer_secret, :client_credential_secret

      ##
      # Sets the client credential secret for this client.
      #
      # @param [String, #to_str] new_client_credential_secret
      #   The client credential secret.
      def client_credential_secret=(new_client_credential_secret)
        if new_client_credential_secret != nil
          if !new_client_credential_secret.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_client_credential_secret.class} " +
              "into String."
          end
          new_client_credential_secret = new_client_credential_secret.to_str
          @client_credential_secret = new_client_credential_secret
        else
          @client_credential_secret = nil
        end
      end
      alias_method :consumer_secret=, :client_credential_secret=

      ##
      # Returns the temporary credential for this client.
      #
      # @return [Signet::OAuth1::Credential] The temporary credentials.
      def temporary_credential
        if self.temporary_credential_key && self.temporary_credential_secret
          return ::Signet::OAuth1::Credential.new(
            self.temporary_credential_key,
            self.temporary_credential_secret
          )
        elsif !self.temporary_credential_key &&
            !self.temporary_credential_secret
          return nil
        else
          raise ArgumentError,
            "The temporary credential key and secret must be set."
        end
      end
      alias_method :request_token, :temporary_credential

      ##
      # Sets the temporary credential for this client.
      #
      # @param [Signet::OAuth1::Credential] new_temporary_credential
      #   The temporary credentials.
      def temporary_credential=(new_temporary_credential)
        if new_temporary_credential != nil
          if !new_temporary_credential.kind_of?(::Signet::OAuth1::Credential)
            raise TypeError,
              "Expected Signet::OAuth1::Credential, " +
              "got #{new_temporary_credential.class}."
          end
          @temporary_credential_key = new_temporary_credential.key
          @temporary_credential_secret = new_temporary_credential.secret
        else
          @temporary_credential_key = nil
          @temporary_credential_secret = nil
        end
      end
      alias_method :request_token=, :temporary_credential=

      ##
      # Returns the temporary credential key for this client.
      #
      # @return [String] The temporary credential key.
      def temporary_credential_key
        return @temporary_credential_key
      end
      alias_method :request_token_key, :temporary_credential_key

      ##
      # Sets the temporary credential key for this client.
      #
      # @param [String, #to_str] new_temporary_credential_key
      #   The temporary credential key.
      def temporary_credential_key=(new_temporary_credential_key)
        if new_temporary_credential_key != nil
          if !new_temporary_credential_key.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_temporary_credential_key.class} " +
              "into String."
          end
          new_temporary_credential_key = new_temporary_credential_key.to_str
          @temporary_credential_key = new_temporary_credential_key
        else
          @temporary_credential_key = nil
        end
      end
      alias_method :request_token_key=, :temporary_credential_key=

      ##
      # Returns the temporary credential secret for this client.
      #
      # @return [String] The temporary credential secret.
      def temporary_credential_secret
        return @temporary_credential_secret
      end
      alias_method :request_token_secret, :temporary_credential_secret

      ##
      # Sets the temporary credential secret for this client.
      #
      # @param [String, #to_str] new_temporary_credential_secret
      #   The temporary credential secret.
      def temporary_credential_secret=(new_temporary_credential_secret)
        if new_temporary_credential_secret != nil
          if !new_temporary_credential_secret.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_temporary_credential_secret.class} " +
              "into String."
          end
          new_temporary_credential_secret =
            new_temporary_credential_secret.to_str
          @temporary_credential_secret = new_temporary_credential_secret
        else
          @temporary_credential_secret = nil
        end
      end
      alias_method :request_token_secret=, :temporary_credential_secret=

      ##
      # Returns the token credential for this client.
      #
      # @return [Signet::OAuth1::Credential] The token credentials.
      def token_credential
        if self.token_credential_key && self.token_credential_secret
          return ::Signet::OAuth1::Credential.new(
            self.token_credential_key,
            self.token_credential_secret
          )
        elsif !self.token_credential_key &&
            !self.token_credential_secret
          return nil
        else
          raise ArgumentError,
            "The token credential key and secret must be set."
        end
      end
      alias_method :access_token, :token_credential

      ##
      # Sets the token credential for this client.
      #
      # @param [Signet::OAuth1::Credential] new_token_credential
      #   The token credentials.
      def token_credential=(new_token_credential)
        if new_token_credential != nil
          if !new_token_credential.kind_of?(::Signet::OAuth1::Credential)
            raise TypeError,
              "Expected Signet::OAuth1::Credential, " +
              "got #{new_token_credential.class}."
          end
          @token_credential_key = new_token_credential.key
          @token_credential_secret = new_token_credential.secret
        else
          @token_credential_key = nil
          @token_credential_secret = nil
        end
      end
      alias_method :access_token=, :token_credential=

      ##
      # Returns the token credential key for this client.
      #
      # @return [String] The token credential key.
      def token_credential_key
        return @token_credential_key
      end
      alias_method :access_token_key, :token_credential_key

      ##
      # Sets the token credential key for this client.
      #
      # @param [String, #to_str] new_token_credential_key
      #   The token credential key.
      def token_credential_key=(new_token_credential_key)
        if new_token_credential_key != nil
          if !new_token_credential_key.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_token_credential_key.class} " +
              "into String."
          end
          new_token_credential_key = new_token_credential_key.to_str
          @token_credential_key = new_token_credential_key
        else
          @token_credential_key = nil
        end
      end
      alias_method :access_token_key=, :token_credential_key=

      ##
      # Returns the token credential secret for this client.
      #
      # @return [String] The token credential secret.
      def token_credential_secret
        return @token_credential_secret
      end
      alias_method :access_token_secret, :token_credential_secret

      ##
      # Sets the token credential secret for this client.
      #
      # @param [String, #to_str] new_token_credential_secret
      #   The token credential secret.
      def token_credential_secret=(new_token_credential_secret)
        if new_token_credential_secret != nil
          if !new_token_credential_secret.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_token_credential_secret.class} " +
              "into String."
          end
          new_token_credential_secret =
            new_token_credential_secret.to_str
          @token_credential_secret = new_token_credential_secret
        else
          @token_credential_secret = nil
        end
      end
      alias_method :access_token_secret=, :token_credential_secret=

      ##
      # Returns the callback for this client.
      #
      # @return [String] The OAuth callback.
      def callback
        return @callback || ::Signet::OAuth1::OUT_OF_BAND
      end

      ##
      # Sets the callback for this client.
      #
      # @param [String, #to_str] new_callback
      #   The OAuth callback.
      def callback=(new_callback)
        if new_callback != nil
          if !new_callback.respond_to?(:to_str)
            raise TypeError,
              "Can't convert #{new_callback.class} into String."
          end
          new_callback = new_callback.to_str
          @callback = new_callback
        else
          @callback = nil
        end
      end

      ##
      # Returns whether the client is in two-legged mode.
      #
      # @return [TrueClass, FalseClass]
      #   <code>true</code> for two-legged mode, <code>false</code> otherwise.
      def two_legged
        return @two_legged ||= false
      end

      ##
      # Sets the client for two-legged mode.
      #
      # @param [TrueClass, FalseClass] new_two_legged
      #   <code>true</code> for two-legged mode, <code>false</code> otherwise.
      def two_legged=(new_two_legged)
        if new_two_legged != true && new_two_legged != false
          raise TypeError,
            "Expected true or false, got #{new_two_legged.class}."
        else
          @two_legged = new_two_legged
        end
      end

      ##
      # Serialize the client object to JSON.
      #
      # @note A serialized client contains sensitive information. Persist or transmit with care.
      #
      # @return [String] A serialized JSON representation of the client.
      def to_json
        return MultiJson.dump({
          'temporary_credential_uri' => self.temporary_credential_uri,
          'authorization_uri' => self.authorization_uri,
          'token_credential_uri' => self.token_credential_uri,
          'callback' => self.callback,
          'two_legged' => self.two_legged,
          'client_credential_key' => self.client_credential_key,
          'client_credential_secret' => self.client_credential_secret,
          'temporary_credential_key' => self.temporary_credential_key,
          'temporary_credential_secret' => self.temporary_credential_secret,
          'token_credential_key' => self.token_credential_key,
          'token_credential_secret' => self.token_credential_secret
        })
      end

      ##
      # Generates a request for temporary credentials.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:additional_parameters</code> -
      #     Non-standard additional parameters.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #
      # @return [Array] The request object.
      def generate_temporary_credential_request(options={})
        verifications = {
          :temporary_credential_uri => 'Temporary credentials URI',
          :client_credential_key => 'Client credential key',
          :client_credential_secret => 'Client credential secret'
        }
        # Make sure all required state is set
        verifications.each do |(key, _value)|
          unless self.send(key)
            raise ArgumentError, "#{key} was not set."
          end
        end
        options = {
          :signature_method => 'HMAC-SHA1',
          :additional_parameters => [],
          :realm => nil,
          :connection => Faraday.default_connection
        }.merge(options)
        method = :post
        parameters = ::Signet::OAuth1.unsigned_temporary_credential_parameters(
          :client_credential_key => self.client_credential_key,
          :callback => self.callback,
          :signature_method => options[:signature_method],
          :additional_parameters => options[:additional_parameters]
        )
        signature = ::Signet::OAuth1.sign_parameters(
          method,
          self.temporary_credential_uri,
          parameters,
          self.client_credential_secret
        )
        parameters << ['oauth_signature', signature]
        authorization_header = [
          'Authorization',
          ::Signet::OAuth1.generate_authorization_header(
            parameters, options[:realm]
          )
        ]
        headers = [authorization_header]
        if method == :post
          headers << ['Content-Type', 'application/x-www-form-urlencoded']
          headers << ['Content-Length', '0']
        end
        return options[:connection].build_request(method.to_s.downcase.to_sym) do |req|
          req.url(Addressable::URI.parse(
            self.temporary_credential_uri.to_str
          ).normalize.to_s)
          req.headers = Faraday::Utils::Headers.new(headers)
        end
      end
      alias_method(
        :generate_request_token_request,
        :generate_temporary_credential_request
      )

      ##
      # Transmits a request for a temporary credential.  This method does not
      # have side-effects within the client.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:additional_parameters</code> -
      #     Non-standard additional parameters.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #   - <code>:connection</code> -
      #     The HTTP connection to use.
      #     Must be of type <code>Faraday::Connection</code>.
      #
      # @return [Signet::OAuth1::Credential] The temporary credential.
      #
      # @example
      #   temporary_credential = client.fetch_temporary_credential(
      #     :additional_parameters => {
      #       :scope => 'https://mail.google.com/mail/feed/atom'
      #     }
      #   )
      def fetch_temporary_credential(options={})
        options[:connection] ||= Faraday.default_connection
        request = self.generate_temporary_credential_request(options)
        request_env = request.to_env(options[:connection])
        request_env[:request] ||= request
        response = options[:connection].app.call(request_env)
        if response.status.to_i == 200
          return ::Signet::OAuth1.parse_form_encoded_credentials(response.body)
        elsif [400, 401, 403].include?(response.status.to_i)
          message = 'Authorization failed.'
          if response.body.to_s.strip.length > 0
            message += "  Server message:\n#{response.body.to_s.strip}"
          end
          raise ::Signet::AuthorizationError.new(
            message, :request => request, :response => response
          )
        else
          message = "Unexpected status code: #{response.status}."
          if response.body.to_s.strip.length > 0
            message += "  Server message:\n#{response.body.to_s.strip}"
          end
          raise ::Signet::AuthorizationError.new(
            message, :request => request, :response => response
          )
        end
      end
      alias_method(
        :fetch_request_token,
        :fetch_temporary_credential
      )

      ##
      # Transmits a request for a temporary credential.  This method updates
      # the client with the new temporary credential.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:additional_parameters</code> -
      #     Non-standard additional parameters.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #   - <code>:connection</code> -
      #     The HTTP connection to use.
      #     Must be of type <code>Faraday::Connection</code>.
      #
      # @return [Signet::OAuth1::Credential] The temporary credential.
      #
      # @example
      #   client.fetch_temporary_credential!(:additional_parameters => {
      #     :scope => 'https://mail.google.com/mail/feed/atom'
      #   })
      def fetch_temporary_credential!(options={})
        credential = self.fetch_temporary_credential(options)
        self.temporary_credential = credential
      end
      alias_method(
        :fetch_request_token!,
        :fetch_temporary_credential!
      )

      ##
      # Generates a request for token credentials.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:verifier</code> -
      #     The OAuth verifier provided by the server.  Required.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #
      # @return [Array] The request object.
      def generate_token_credential_request(options={})
        verifications = {
          :token_credential_uri => 'Token credentials URI',
          :client_credential_key => 'Client credential key',
          :client_credential_secret => 'Client credential secret',
          :temporary_credential_key => 'Temporary credential key',
          :temporary_credential_secret => 'Temporary credential secret'
        }
        # Make sure all required state is set
        verifications.each do |(key, _value)|
          unless self.send(key)
            raise ArgumentError, "#{key} was not set."
          end
        end
        options = {
          :signature_method => 'HMAC-SHA1',
          :realm => nil,
          :connection => Faraday.default_connection
        }.merge(options)
        method = :post
        parameters = ::Signet::OAuth1.unsigned_token_credential_parameters(
          :client_credential_key => self.client_credential_key,
          :temporary_credential_key => self.temporary_credential_key,
          :signature_method => options[:signature_method],
          :verifier => options[:verifier]
        )
        signature = ::Signet::OAuth1.sign_parameters(
          method,
          self.token_credential_uri,
          parameters,
          self.client_credential_secret,
          self.temporary_credential_secret
        )
        parameters << ['oauth_signature', signature]
        authorization_header = [
          'Authorization',
          ::Signet::OAuth1.generate_authorization_header(
            parameters, options[:realm]
          )
        ]
        headers = [authorization_header]
        headers << ['Cache-Control', 'no-store']
        if method == :post
          headers << ['Content-Type', 'application/x-www-form-urlencoded']
          headers << ['Content-Length', '0']
        end
        return options[:connection].build_request(method.to_s.downcase.to_sym) do |req|
          req.url(Addressable::URI.parse(
            self.token_credential_uri.to_str
          ).normalize.to_s)
          req.headers = Faraday::Utils::Headers.new(headers)
        end
      end
      alias_method(
        :generate_access_token_request,
        :generate_token_credential_request
      )

      ##
      # Transmits a request for a token credential.  This method does not
      # have side-effects within the client.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:verifier</code> -
      #     The OAuth verifier provided by the server.  Required.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #   - <code>:connection</code> -
      #     The HTTP connection to use.
      #     Must be of type <code>Faraday::Connection</code>.
      #
      # @return [Signet::OAuth1::Credential] The token credential.
      #
      # @example
      #   token_credential = client.fetch_token_credential(
      #     :verifier => '12345'
      #   )
      def fetch_token_credential(options={})
        options[:connection] ||= Faraday.default_connection
        request = self.generate_token_credential_request(options)
        request_env = request.to_env(options[:connection])
        request_env[:request] ||= request
        response = options[:connection].app.call(request_env)
        if response.status.to_i == 200
          return ::Signet::OAuth1.parse_form_encoded_credentials(response.body)
        elsif [400, 401, 403].include?(response.status.to_i)
          message = 'Authorization failed.'
          if response.body.to_s.strip.length > 0
            message += "  Server message:\n#{response.body.to_s.strip}"
          end
          raise ::Signet::AuthorizationError.new(
            message, :request => request, :response => response
          )
        else
          message = "Unexpected status code: #{response.status}."
          if response.body.to_s.strip.length > 0
            message += "  Server message:\n#{response.body.to_s.strip}"
          end
          raise ::Signet::AuthorizationError.new(
            message, :request => request, :response => response
          )
        end
      end
      alias_method(
        :fetch_access_token,
        :fetch_token_credential
      )

      ##
      # Transmits a request for a token credential.  This method updates
      # the client with the new token credential.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:additional_parameters</code> -
      #     Non-standard additional parameters.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #   - <code>:connection</code> -
      #     The HTTP connection to use.
      #     Must be of type <code>Faraday::Connection</code>.
      #
      # @return [Signet::OAuth1::Credential] The token credential.
      #
      # @example
      #   client.fetch_token_credential!(:verifier => '12345')
      def fetch_token_credential!(options={})
        credential = self.fetch_token_credential(options)
        self.token_credential = credential
      end
      alias_method(
        :fetch_access_token!,
        :fetch_token_credential!
      )

      ##
      # Generates an authenticated request for protected resources.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:request</code> -
      #     A pre-constructed request to sign.
      #   - <code>:method</code> -
      #     The HTTP method for the request.  Defaults to :get.
      #   - <code>:uri</code> -
      #     The URI for the request.
      #   - <code>:headers</code> -
      #     The HTTP headers for the request.
      #   - <code>:body</code> -
      #     The HTTP body for the request.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #
      # @return [Array] The request object.
      def generate_authenticated_request(options={})
        verifications = {
          :client_credential_key => 'Client credential key',
          :client_credential_secret => 'Client credential secret'
        }
        unless self.two_legged
          verifications.update(
            :token_credential_key => 'Token credential key',
            :token_credential_secret => 'Token credential secret'
          )
        end
        # Make sure all required state is set
        verifications.each do |(key, _value)|
          unless self.send(key)
            raise ArgumentError, "#{key} was not set."
          end
        end
        options = {
          :signature_method => 'HMAC-SHA1',
          :realm => nil,
          :connection => Faraday.default_connection
        }.merge(options)

        if options[:request].kind_of?(Faraday::Request)
          request = options[:request]
        else
          if options[:request].kind_of?(Array)
            method, uri, headers, body = options[:request]
          else
            method = options[:method] || :get
            uri = options[:uri]
            headers = options[:headers] || []
            body = options[:body] || ''
          end
          headers = headers.to_a if headers.kind_of?(Hash)
          request_components = {
            :method => method,
            :uri => uri,
            :headers => headers,
            :body => body
          }
          # Verify that we have all pieces required to return an HTTP request
          request_components.each do |(key, value)|
            unless value
              raise ArgumentError, "Missing :#{key} parameter."
            end
          end
          if !body.kind_of?(String) && body.respond_to?(:each)
            # Just in case we get a chunked body
            merged_body = StringIO.new
            body.each do |chunk|
              merged_body.write(chunk)
            end
            body = merged_body.string
          end
          if !body.kind_of?(String)
            raise TypeError, "Expected String, got #{body.class}."
          end
          method = method.to_s.downcase.to_sym
          request = options[:connection].build_request(method) do |req|
            req.url(Addressable::URI.parse(uri).normalize.to_s)
            req.headers = Faraday::Utils::Headers.new(headers)
            req.body = body
          end
        end

        parameters = ::Signet::OAuth1.unsigned_resource_parameters(
          :client_credential_key => self.client_credential_key,
          :token_credential_key => self.token_credential_key,
          :signature_method => options[:signature_method],
          :two_legged => self.two_legged
        )

        env = request.to_env(options[:connection])

        content_type = request['Content-Type'].to_s
        content_type = content_type.split(';', 2).first if content_type.index(';')
        if request.method == :post && content_type == 'application/x-www-form-urlencoded'
          # Serializes the body in case a hash/array was passed. Noop if already string like
          encoder = Faraday::Request::UrlEncoded.new(lambda { |_env| })
          encoder.call(env)
          request.body = env[:body]

          post_parameters = Addressable::URI.form_unencode(env[:body])
          parameters = parameters.concat(post_parameters)
        end

        # No need to attach URI query parameters, the .sign_parameters
        # method takes care of that automatically.
        signature = ::Signet::OAuth1.sign_parameters(
          env[:method],
          env[:url],
          parameters,
          self.client_credential_secret,
          self.token_credential_secret
        )

        parameters << ['oauth_signature', signature]
        request['Authorization'] =  ::Signet::OAuth1.generate_authorization_header(
            parameters, options[:realm])
        request['Cache-Control'] = 'no-store'
        return request
      end

      ##
      # Transmits a request for a protected resource.
      #
      # @param [Hash] options
      #   The configuration parameters for the request.
      #   - <code>:request</code> -
      #     A pre-constructed request to sign.
      #   - <code>:method</code> -
      #     The HTTP method for the request.  Defaults to :get.
      #   - <code>:uri</code> -
      #     The URI for the request.
      #   - <code>:headers</code> -
      #     The HTTP headers for the request.
      #   - <code>:body</code> -
      #     The HTTP body for the request.
      #   - <code>:signature_method</code> -
      #     The signature method.  Defaults to <code>'HMAC-SHA1'</code>.
      #   - <code>:realm</code> -
      #     The Authorization realm.  See RFC 2617.
      #   - <code>:connection</code> -
      #     The HTTP connection to use.
      #     Must be of type <code>Faraday::Connection</code>.
      #
      # @example
      #   # Using Net::HTTP
      #   response = client.fetch_protected_resource(
      #     :uri => 'http://www.example.com/protected/resource'
      #   )
      #
      # @example
      #   # Using Typhoeus
      #   response = client.fetch_protected_resource(
      #     :request => Typhoeus::Request.new(
      #       'http://www.example.com/protected/resource'
      #     ),
      #     :connection => connection
      #   )
      #
      # @return [Array] The response object.
      def fetch_protected_resource(options={})
        options[:connection] ||= Faraday.default_connection
        request = self.generate_authenticated_request(options)
        request_env = request.to_env(options[:connection])
        request_env[:request] ||= request
        response = options[:connection].app.call(request_env)
        if response.status.to_i == 401
          # When accessing a protected resource, we only want to raise an
          # error for 401 responses.
          message = 'Authorization failed.'
          if response.body.to_s.strip.length > 0
            message += "  Server message:\n#{response.body.to_s.strip}"
          end
          raise ::Signet::AuthorizationError.new(
            message, :request => request, :response => response
          )
        else
          return response
        end
      end
    end
  end
end
