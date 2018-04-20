module Pusher
  module Signature
    # Query string encoding extracted with thanks from em-http-request
    module QueryEncoder
      class << self
        # URL encodes query parameters:
        # single k=v, or a URL encoded array, if v is an array of values
        def encode_param(k, v)
          if v.is_a?(Array)
            v.map { |e| escape(k) + "[]=" + escape(e) }.join("&")
          else
            escape(k) + "=" + escape(v)
          end
        end

        # Like encode_param, but doesn't url escape keys or values
        def encode_param_without_escaping(k, v)
          if v.is_a?(Array)
            v.map { |e| k + "[]=" + e }.join("&")
          else
            "#{k}=#{v}"
          end
        end

        private

        def escape(s)
          if defined?(EscapeUtils)
            EscapeUtils.escape_url(s.to_s)
          else
            s.to_s.gsub(/([^a-zA-Z0-9_.-]+)/n) {
              '%'+$1.unpack('H2'*bytesize($1)).join('%').upcase
            }
          end
        end

        if ''.respond_to?(:bytesize)
          def bytesize(string)
            string.bytesize
          end
        else
          def bytesize(string)
            string.size
          end
        end
      end
    end
  end
end