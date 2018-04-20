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

require 'addressable/uri'
require 'addressable/template'
require 'google/apis/core/http_command'
require 'google/apis/errors'
require 'json'
require 'retriable'

module Google
  module Apis
    module Core
      # Command for executing most basic API request with JSON requests/responses
      class ApiCommand < HttpCommand
        JSON_CONTENT_TYPE = 'application/json'
        FIELDS_PARAM = 'fields'
        ERROR_REASON_MAPPING = {
          'rateLimitExceeded' => Google::Apis::RateLimitError,
          'userRateLimitExceeded' => Google::Apis::RateLimitError,
          'projectNotLinked' => Google::Apis::ProjectNotLinkedError
        }

        # JSON serializer for request objects
        # @return [Google::Apis::Core::JsonRepresentation]
        attr_accessor :request_representation

        # Request body to serialize
        # @return [Object]
        attr_accessor :request_object

        # JSON serializer for response objects
        # @return [Google::Apis::Core::JsonRepresentation]
        attr_accessor :response_representation

        # Class to instantiate when de-serializing responses
        # @return [Object]
        attr_accessor :response_class

        # Serialize the request body
        #
        # @return [void]
        def prepare!
          if options && options.api_format_version
            header['X-Goog-Api-Format-Version'] = options.api_format_version.to_s
          end
          query[FIELDS_PARAM] = normalize_fields_param(query[FIELDS_PARAM]) if query.key?(FIELDS_PARAM)
          if request_representation && request_object
            header['Content-Type'] ||= JSON_CONTENT_TYPE
            if options && options.skip_serialization
              self.body = request_object
            else
              self.body = request_representation.new(request_object).to_json(user_options: { skip_undefined: true })
            end
          end
          super
        end

        # Deserialize the response body if present
        #
        # @param [String] content_type
        #  Content type of body
        # @param [String, #read] body
        #  Response body
        # @return [Object]
        #   Response object
        # noinspection RubyUnusedLocalVariable
        def decode_response_body(content_type, body)
          return super unless response_representation
          return super if options && options.skip_deserialization
          return super if content_type.nil?
          return nil unless content_type.start_with?(JSON_CONTENT_TYPE)
          instance = response_class.new
          response_representation.new(instance).from_json(body, unwrap: response_class)
          instance
        end

        # Check the response and raise error if needed
        #
        # @param [Fixnum] status
        #   HTTP status code of response
        # @param [Hash] header
        #   HTTP response headers
        # @param [String] body
        #   HTTP response body
        # @param [String] message
        #   Error message text
        # @return [void]
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def check_status(status, header = nil, body = nil, message = nil)
          case status
          when 400, 402...500
            reason, message = parse_error(body)
            if reason
              message = sprintf('%s: %s', reason, message)
              raise ERROR_REASON_MAPPING[reason].new(
                message,
                status_code: status,
                header: header,
                body: body
              ) if ERROR_REASON_MAPPING.key?(reason)
            end
            super(status, header, body, message)
          else
            super(status, header, body, message)
          end
        end

        def allow_form_encoding?
          request_representation.nil? && super
        end

        private

        # Attempt to parse a JSON error message
        # @param [String] body
        #  HTTP response body
        # @return [Array<(String, String)>]
        #   Error reason and message
        def parse_error(body)
          obj = JSON.load(body)
          error = obj['error']
          if error['details']
            return extract_v2_error_details(error)
          elsif error['errors']
            return extract_v1_error_details(error)
          else
            fail 'Can not parse error message. No "details" or "errors" detected'
          end
        rescue
          return [nil, nil]
        end

        # Extracts details from a v1 error message
        # @param [Hash] error
        #  Parsed JSON
        # @return [Array<(String, String)>]
        #   Error reason and message
        def extract_v1_error_details(error)
          reason = error['errors'].first['reason']
          message = error['message']
          return [reason, message]
        end

        # Extracts details from a v2error message
        # @param [Hash] error
        #  Parsed JSON
        # @return [Array<(String, String)>]
        #   Error reason and message
        def extract_v2_error_details(error)
          reason = error['status']
          message = error['message']
          return [reason, message]
        end

        # Convert field names from ruby conventions to original names in JSON
        #
        # @param [String] fields
        #   Value of 'fields' param
        # @return [String]
        #   Updated header value
        def normalize_fields_param(fields)
          # TODO: Generate map of parameter names during code gen. Small possibility that camelization fails
          fields.gsub(/:/, '').gsub(/\w+/) do |str|
            str.gsub(/(?:^|_)([a-z])/){ Regexp.last_match.begin(0) == 0 ? $1 : $1.upcase }
          end
        end
      end
    end
  end
end
