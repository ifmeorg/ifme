# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Google
  module Apis
    # General options for API requests
    ClientOptions = Struct.new(
      :application_name,
      :application_version,
      :proxy_url,
      :open_timeout_sec,
      :read_timeout_sec,
      :send_timeout_sec,
      :log_http_requests)

    RequestOptions = Struct.new(
      :authorization,
      :retries,
      :header,
      :normalize_unicode,
      :skip_serialization,
      :skip_deserialization,
      :api_format_version)

    # General client options
    class ClientOptions
      # @!attribute [rw] application_name
      #   @return [String] Name of the application, for identification in the User-Agent header
      # @!attribute [rw] application_version
      #   @return [String] Version of the application, for identification in the User-Agent header
      # @!attribute [rw] proxy_url
      #   @return [String] URL of a proxy server
      # @!attribute [rw] log_http_requests
      #   @return [Boolean] True if raw HTTP requests should be logged
      # @!attribute [rw] open_timeout_sec
      #   @return [Fixnum] How long, in seconds, before failed connections time out
      # @!attribute [rw] read_timeout_sec
      #   @return [Fixnum] How long, in seconds, before requests time out
      # Get the default options
      # @return [Google::Apis::ClientOptions]
      def self.default
        @options ||= ClientOptions.new
      end
    end

    # Request options
    class RequestOptions
      # @!attribute [rw] authorization
      #   @return [Signet::OAuth2::Client, #apply(Hash)] OAuth2 credentials
      # @!attribute [rw] retries
      #   @return [Fixnum] Number of times to retry requests on server error
      # @!attribute [rw] header
      #   @return [Hash<String,String] Additional HTTP headers to include in requests
      # @!attribute [rw] normalize_unicode
      #   @return [Boolean] True if unicode strings should be normalized in path parameters
      # @!attribute [rw] skip_serialization
      #   @return [Boolean] True if body object should be treated as raw text instead of an object.
      # @!attribute [rw] skip_deserialization
      #   @return [Boolean] True if response should be returned in raw form instead of deserialized.
      # @!attribute [rw] api_format_version
      #   @return [Fixnum] Version of the error format to request/expect.

      # Get the default options
      # @return [Google::Apis::RequestOptions]
      def self.default
        @options ||= RequestOptions.new
      end

      def merge(options)
        return self if options.nil?

        new_options = dup
        members.each do |opt|
          opt = opt.to_sym
          new_options[opt] = options[opt] unless options[opt].nil?
        end
        new_options
      end
    end

    ClientOptions.default.log_http_requests = false
    ClientOptions.default.application_name = 'unknown'
    ClientOptions.default.application_version = '0.0.0'
    RequestOptions.default.retries = 0
    RequestOptions.default.normalize_unicode = false
    RequestOptions.default.skip_serialization = false
    RequestOptions.default.skip_deserialization = false
    RequestOptions.default.api_format_version = nil
  end
end
