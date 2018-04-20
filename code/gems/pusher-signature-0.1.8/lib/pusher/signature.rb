require 'openssl'

require 'pusher/signature/query_encoder'

module Pusher
  module Signature
    class AuthenticationError < RuntimeError; end

    class Token
      attr_reader :key, :secret

      def initialize(key, secret)
        @key, @secret = key, secret
      end

      def sign(request)
        request.sign(self)
      end
    end

    class Request
      attr_accessor :path, :query_hash

      include QueryEncoder

      # http://www.w3.org/TR/NOTE-datetime
      ISO8601 = "%Y-%m-%dT%H:%M:%SZ"

      def initialize(method, path, query)
        raise ArgumentError, "Expected string" unless path.kind_of?(String)
        raise ArgumentError, "Expected hash" unless query.kind_of?(Hash)

        query_hash = {}
        auth_hash = {}
        query.each do |key, v|
          k = key.to_s.downcase
          k[0..4] == 'auth_' ? auth_hash[k] = v : query_hash[k] = v
        end

        @method = method.upcase
        @path, @query_hash, @auth_hash = path, query_hash, auth_hash
        @signed = false
      end

      # Sign the request with the given token, and return the computed
      # authentication parameters
      #
      def sign(token)
        @auth_hash = {
          :auth_version => "1.0",
          :auth_key => token.key,
          :auth_timestamp => Time.now.to_i.to_s
        }
        @auth_hash[:auth_signature] = signature(token)

        @signed = true

        return @auth_hash
      end

      # Authenticates the request with a token
      #
      # Raises an AuthenticationError if the request is invalid.
      # AuthenticationError exception messages are designed to be exposed to API
      # consumers, and should help them correct errors generating signatures
      #
      # Timestamp: Unless timestamp_grace is set to nil (which allows this check
      # to be skipped), AuthenticationError will be raised if the timestamp is
      # missing or further than timestamp_grace period away from the real time
      # (defaults to 10 minutes)
      #
      # Signature: Raises AuthenticationError if the signature does not match
      # the computed HMAC. The error contains a hint for how to sign.
      #
      def authenticate_by_token!(token, timestamp_grace = 600)
        # Validate that your code has provided a valid token. This does not
        # raise an AuthenticationError since passing tokens with empty secret is
        # a code error which should be fixed, not reported to the API's consumer
        if token.secret.nil? || token.secret.empty?
          raise "Provided token is missing secret"
        end

        validate_version!
        validate_timestamp!(timestamp_grace)
        validate_signature!(token)
        true
      end

      # Authenticate the request with a token, but rather than raising an
      # exception if the request is invalid, simply returns false
      #
      def authenticate_by_token(token, timestamp_grace = 600)
        authenticate_by_token!(token, timestamp_grace)
      rescue AuthenticationError
        false
      end

      # Authenticate a request
      #
      # Takes a block which will be called with the auth_key from the request,
      # and which should return a Signature::Token (or nil if no token can be
      # found for the key)
      #
      # Raises errors in the same way as authenticate_by_token!
      #
      def authenticate(timestamp_grace = 600)
        raise ArgumentError, "Block required" unless block_given?
        key = @auth_hash['auth_key']
        raise AuthenticationError, "Missing parameter: auth_key" unless key
        token = yield key
        unless token
          raise AuthenticationError, "Unknown auth_key"
        end
        authenticate_by_token!(token, timestamp_grace)
        return token
      end

      # Authenticate a request asynchronously
      #
      # This method is useful it you're running a server inside eventmachine and
      # need to lookup the token asynchronously.
      #
      # The block is passed an auth key and a deferrable which should succeed
      # with the token, or fail if the token cannot be found
      #
      # This method returns a deferrable which succeeds with the valid token, or
      # fails with an AuthenticationError which can be used to pass the error
      # back to the user
      #
      def authenticate_async(timestamp_grace = 600)
        raise ArgumentError, "Block required" unless block_given?
        df = EM::DefaultDeferrable.new

        key = @auth_hash['auth_key']

        unless key
          df.fail(AuthenticationError.new("Missing parameter: auth_key"))
          return
        end

        token_df = yield key
        token_df.callback { |token|
          begin
            authenticate_by_token!(token, timestamp_grace)
            df.succeed(token)
          rescue AuthenticationError => e
            df.fail(e)
          end
        }
        token_df.errback {
          df.fail(AuthenticationError.new("Unknown auth_key"))
        }
      ensure
        return df
      end

      # Expose the authentication parameters for a signed request
      #
      def auth_hash
        raise "Request not signed" unless @signed
        @auth_hash
      end

      # Query parameters merged with the computed authentication parameters
      #
      def signed_params
        @query_hash.merge(auth_hash)
      end

      private

        def signature(token)
          digest = OpenSSL::Digest::SHA256.new
          OpenSSL::HMAC.hexdigest(digest, token.secret, string_to_sign)
        end

        def string_to_sign
          [@method, @path, parameter_string].join("\n")
        end

        def parameter_string
          param_hash = @query_hash.merge(@auth_hash || {})

          # Convert keys to lowercase strings
          hash = {}; param_hash.each { |k,v| hash[k.to_s.downcase] = v }

          # Exclude signature from signature generation!
          hash.delete("auth_signature")

          hash.sort.map do |k, v|
            QueryEncoder.encode_param_without_escaping(k, v)
          end.join('&')
        end

        def validate_version!
          version = @auth_hash["auth_version"]
          raise AuthenticationError, "Version required" unless version
          raise AuthenticationError, "Version not supported" unless version == '1.0'
        end

        def validate_timestamp!(grace)
          return true if grace.nil?

          timestamp = @auth_hash["auth_timestamp"]
          error = (timestamp.to_i - Time.now.to_i).abs
          raise AuthenticationError, "Timestamp required" unless timestamp
          if error >= grace
            raise AuthenticationError, "Timestamp expired: Given timestamp "\
              "(#{Time.at(timestamp.to_i).utc.strftime(ISO8601)}) "\
              "not within #{grace}s of server time "\
              "(#{Time.now.utc.strftime(ISO8601)})"
          end
          return true
        end

        def validate_signature!(token)
          unless identical? @auth_hash["auth_signature"], signature(token)
            raise AuthenticationError, "Invalid signature: you should have "\
              "sent HmacSHA256Hex(#{string_to_sign.inspect}, your_secret_key)"\
              ", but you sent #{@auth_hash["auth_signature"].inspect}"
          end
          return true
        end

        # Constant time string comparison
        def identical?(a, b)
          return true if a.nil? && b.nil?
          return false if a.nil? || b.nil?
          return false unless a.bytesize == b.bytesize
          a.bytes.zip(b.bytes).reduce(0) { |memo, (a, b)| memo += a ^ b } == 0
        end
    end
  end
end