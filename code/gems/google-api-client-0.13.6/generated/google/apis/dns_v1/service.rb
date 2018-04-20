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

require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module DnsV1
      # Google Cloud DNS API
      #
      # Configures and serves authoritative DNS records.
      #
      # @example
      #    require 'google/apis/dns_v1'
      #
      #    Dns = Google::Apis::DnsV1 # Alias the module
      #    service = Dns::DnsService.new
      #
      # @see https://developers.google.com/cloud-dns
      class DnsService < Google::Apis::Core::BaseService
        # @return [String]
        #  API key. Your API key identifies your project and provides you with API access,
        #  quota, and reports. Required unless you provide an OAuth 2.0 token.
        attr_accessor :key

        # @return [String]
        #  Available to use for quota purposes for server-side applications. Can be any
        #  arbitrary string assigned to a user, but should not exceed 40 characters.
        #  Overrides userIp if both are provided.
        attr_accessor :quota_user

        # @return [String]
        #  IP address of the site where the request originates. Use this if you want to
        #  enforce per-user limits.
        attr_accessor :user_ip

        def initialize
          super('https://www.googleapis.com/', 'dns/v1/projects/')
          @batch_path = 'batch'
        end
        
        # Atomically update the ResourceRecordSet collection.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] managed_zone
        #   Identifies the managed zone addressed by this request. Can be the managed zone
        #   name or id.
        # @param [Google::Apis::DnsV1::Change] change_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::Change] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::Change]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_change(project, managed_zone, change_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{project}/managedZones/{managedZone}/changes', options)
          command.request_representation = Google::Apis::DnsV1::Change::Representation
          command.request_object = change_object
          command.response_representation = Google::Apis::DnsV1::Change::Representation
          command.response_class = Google::Apis::DnsV1::Change
          command.params['project'] = project unless project.nil?
          command.params['managedZone'] = managed_zone unless managed_zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetch the representation of an existing Change.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] managed_zone
        #   Identifies the managed zone addressed by this request. Can be the managed zone
        #   name or id.
        # @param [String] change_id
        #   The identifier of the requested change, from a previous
        #   ResourceRecordSetsChangeResponse.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::Change] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::Change]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_change(project, managed_zone, change_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{project}/managedZones/{managedZone}/changes/{changeId}', options)
          command.response_representation = Google::Apis::DnsV1::Change::Representation
          command.response_class = Google::Apis::DnsV1::Change
          command.params['project'] = project unless project.nil?
          command.params['managedZone'] = managed_zone unless managed_zone.nil?
          command.params['changeId'] = change_id unless change_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enumerate Changes to a ResourceRecordSet collection.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] managed_zone
        #   Identifies the managed zone addressed by this request. Can be the managed zone
        #   name or id.
        # @param [Fixnum] max_results
        #   Optional. Maximum number of results to be returned. If unspecified, the server
        #   will decide how many results to return.
        # @param [String] page_token
        #   Optional. A tag returned by a previous list request that was truncated. Use
        #   this parameter to continue a previous list request.
        # @param [String] sort_by
        #   Sorting criterion. The only supported value is change sequence.
        # @param [String] sort_order
        #   Sorting order direction: 'ascending' or 'descending'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::ListChangesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::ListChangesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_changes(project, managed_zone, max_results: nil, page_token: nil, sort_by: nil, sort_order: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{project}/managedZones/{managedZone}/changes', options)
          command.response_representation = Google::Apis::DnsV1::ListChangesResponse::Representation
          command.response_class = Google::Apis::DnsV1::ListChangesResponse
          command.params['project'] = project unless project.nil?
          command.params['managedZone'] = managed_zone unless managed_zone.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['sortBy'] = sort_by unless sort_by.nil?
          command.query['sortOrder'] = sort_order unless sort_order.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Create a new ManagedZone.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [Google::Apis::DnsV1::ManagedZone] managed_zone_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::ManagedZone] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::ManagedZone]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_managed_zone(project, managed_zone_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{project}/managedZones', options)
          command.request_representation = Google::Apis::DnsV1::ManagedZone::Representation
          command.request_object = managed_zone_object
          command.response_representation = Google::Apis::DnsV1::ManagedZone::Representation
          command.response_class = Google::Apis::DnsV1::ManagedZone
          command.params['project'] = project unless project.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Delete a previously created ManagedZone.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] managed_zone
        #   Identifies the managed zone addressed by this request. Can be the managed zone
        #   name or id.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [NilClass] No result returned for this method
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [void]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_managed_zone(project, managed_zone, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{project}/managedZones/{managedZone}', options)
          command.params['project'] = project unless project.nil?
          command.params['managedZone'] = managed_zone unless managed_zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetch the representation of an existing ManagedZone.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] managed_zone
        #   Identifies the managed zone addressed by this request. Can be the managed zone
        #   name or id.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::ManagedZone] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::ManagedZone]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_managed_zone(project, managed_zone, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{project}/managedZones/{managedZone}', options)
          command.response_representation = Google::Apis::DnsV1::ManagedZone::Representation
          command.response_class = Google::Apis::DnsV1::ManagedZone
          command.params['project'] = project unless project.nil?
          command.params['managedZone'] = managed_zone unless managed_zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enumerate ManagedZones that have been created but not yet deleted.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] dns_name
        #   Restricts the list to return only zones with this domain name.
        # @param [Fixnum] max_results
        #   Optional. Maximum number of results to be returned. If unspecified, the server
        #   will decide how many results to return.
        # @param [String] page_token
        #   Optional. A tag returned by a previous list request that was truncated. Use
        #   this parameter to continue a previous list request.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::ListManagedZonesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::ListManagedZonesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_managed_zones(project, dns_name: nil, max_results: nil, page_token: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{project}/managedZones', options)
          command.response_representation = Google::Apis::DnsV1::ListManagedZonesResponse::Representation
          command.response_class = Google::Apis::DnsV1::ListManagedZonesResponse
          command.params['project'] = project unless project.nil?
          command.query['dnsName'] = dns_name unless dns_name.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetch the representation of an existing Project.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::Project] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::Project]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project(project, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{project}', options)
          command.response_representation = Google::Apis::DnsV1::Project::Representation
          command.response_class = Google::Apis::DnsV1::Project
          command.params['project'] = project unless project.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enumerate ResourceRecordSets that have been created but not yet deleted.
        # @param [String] project
        #   Identifies the project addressed by this request.
        # @param [String] managed_zone
        #   Identifies the managed zone addressed by this request. Can be the managed zone
        #   name or id.
        # @param [Fixnum] max_results
        #   Optional. Maximum number of results to be returned. If unspecified, the server
        #   will decide how many results to return.
        # @param [String] name
        #   Restricts the list to return only records with this fully qualified domain
        #   name.
        # @param [String] page_token
        #   Optional. A tag returned by a previous list request that was truncated. Use
        #   this parameter to continue a previous list request.
        # @param [String] type
        #   Restricts the list to return only records of this type. If present, the "name"
        #   parameter must also be present.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DnsV1::ListResourceRecordSetsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DnsV1::ListResourceRecordSetsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_resource_record_sets(project, managed_zone, max_results: nil, name: nil, page_token: nil, type: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{project}/managedZones/{managedZone}/rrsets', options)
          command.response_representation = Google::Apis::DnsV1::ListResourceRecordSetsResponse::Representation
          command.response_class = Google::Apis::DnsV1::ListResourceRecordSetsResponse
          command.params['project'] = project unless project.nil?
          command.params['managedZone'] = managed_zone unless managed_zone.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['name'] = name unless name.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['type'] = type unless type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end

        protected

        def apply_command_defaults(command)
          command.query['key'] = key unless key.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
        end
      end
    end
  end
end
