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

require 'signet/oauth_2/client'

module Signet
  # OAuth2 supports OAuth2 authentication.
  module OAuth2
    AUTH_METADATA_KEY = :authorization
    # Signet::OAuth2::Client creates an OAuth2 client
    #
    # This reopens Client to add #apply and #apply! methods which update a
    # hash with the fetched authentication token.
    class Client
      # Updates a_hash updated with the authentication token
      def apply!(a_hash, opts = {})
        # fetch the access token there is currently not one, or if the client
        # has expired
        fetch_access_token!(opts) if access_token.nil? || expires_within?(60)
        a_hash[AUTH_METADATA_KEY] = "Bearer #{access_token}"
      end

      # Returns a clone of a_hash updated with the authentication token
      def apply(a_hash, opts = {})
        a_copy = a_hash.clone
        apply!(a_copy, opts)
        a_copy
      end

      # Returns a reference to the #apply method, suitable for passing as
      # a closure
      def updater_proc
        lambda(&method(:apply))
      end

      def on_refresh(&block)
        @refresh_listeners ||= []
        @refresh_listeners << block
      end

      alias orig_fetch_access_token! fetch_access_token!
      def fetch_access_token!(options = {})
        info = orig_fetch_access_token!(options)
        notify_refresh_listeners
        info
      end

      def notify_refresh_listeners
        listeners = @refresh_listeners || []
        listeners.each do |block|
          block.call(self)
        end
      end

      def retry_with_error(max_retry_count = 5)
        retry_count = 0

        begin
          yield
        rescue => e
          if e.is_a?(Signet::AuthorizationError) || e.is_a?(Signet::ParseError)
            raise e
          end

          if retry_count < max_retry_count
            retry_count += 1
            sleep retry_count * 0.3
            retry
          else
            msg = "Unexpected error: #{e.inspect}"
            raise(Signet::AuthorizationError, msg)
          end
        end
      end
    end
  end
end
