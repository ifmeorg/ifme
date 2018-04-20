# Copyright 2015, Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

require 'faraday'
require 'googleauth/signet'
require 'memoist'

module Google
  # Module Auth provides classes that provide Google-specific authorization
  # used to access Google APIs.
  module Auth
    NO_METADATA_SERVER_ERROR = <<END.freeze
Error code 404 trying to get security access token
from Compute Engine metadata for the default service account. This
may be because the virtual machine instance does not have permission
scopes specified.
END
    UNEXPECTED_ERROR_SUFFIX = <<END.freeze
trying to get security access token from Compute Engine metadata for
the default service account
END

    # Extends Signet::OAuth2::Client so that the auth token is obtained from
    # the GCE metadata server.
    class GCECredentials < Signet::OAuth2::Client
      # The IP Address is used in the URIs to speed up failures on non-GCE
      # systems.
      COMPUTE_AUTH_TOKEN_URI = 'http://169.254.169.254/computeMetadata/v1/'\
      'instance/service-accounts/default/token'.freeze
      COMPUTE_CHECK_URI = 'http://169.254.169.254'.freeze

      class << self
        extend Memoist

        # Detect if this appear to be a GCE instance, by checking if metadata
        # is available
        def on_gce?(options = {})
          c = options[:connection] || Faraday.default_connection
          resp = c.get(COMPUTE_CHECK_URI) do |req|
            # Comment from: oauth2client/client.py
            #
            # Note: the explicit `timeout` below is a workaround. The underlying
            # issue is that resolving an unknown host on some networks will take
            # 20-30 seconds; making this timeout short fixes the issue, but
            # could lead to false negatives in the event that we are on GCE, but
            # the metadata resolution was particularly slow. The latter case is
            # "unlikely".
            req.options.timeout = 0.1
          end
          return false unless resp.status == 200
          return false unless resp.headers.key?('Metadata-Flavor')
          return resp.headers['Metadata-Flavor'] == 'Google'
        rescue Faraday::TimeoutError, Faraday::ConnectionFailed
          return false
        end

        memoize :on_gce?
      end

      # Overrides the super class method to change how access tokens are
      # fetched.
      def fetch_access_token(options = {})
        c = options[:connection] || Faraday.default_connection
        c.headers = { 'Metadata-Flavor' => 'Google' }

        retry_with_error do
          resp = c.get(COMPUTE_AUTH_TOKEN_URI)
          case resp.status
          when 200
            Signet::OAuth2.parse_credentials(resp.body,
                                             resp.headers['content-type'])
          when 404
            raise(Signet::AuthorizationError, NO_METADATA_SERVER_ERROR)
          else
            msg = "Unexpected error code #{resp.status}" \
              "#{UNEXPECTED_ERROR_SUFFIX}"
            raise(Signet::AuthorizationError, msg)
          end
        end
      end
    end
  end
end
