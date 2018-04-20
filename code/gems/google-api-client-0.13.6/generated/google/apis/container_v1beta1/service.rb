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
    module ContainerV1beta1
      # Google Container Engine API
      #
      # The Google Container Engine API is used for building and managing container
      #  based applications, powered by the open source Kubernetes technology.
      #
      # @example
      #    require 'google/apis/container_v1beta1'
      #
      #    Container = Google::Apis::ContainerV1beta1 # Alias the module
      #    service = Container::ContainerService.new
      #
      # @see https://cloud.google.com/container-engine/
      class ContainerService < Google::Apis::Core::BaseService
        # @return [String]
        #  API key. Your API key identifies your project and provides you with API access,
        #  quota, and reports. Required unless you provide an OAuth 2.0 token.
        attr_accessor :key

        # @return [String]
        #  Available to use for quota purposes for server-side applications. Can be any
        #  arbitrary string assigned to a user, but should not exceed 40 characters.
        attr_accessor :quota_user

        def initialize
          super('https://container.googleapis.com/', '')
          @batch_path = 'batch'
        end
        
        # Returns configuration info about the Container Engine service.
        # @param [String] name
        #   The name (project and location) of the server config to get
        #   Specified in the format 'projects/*/locations/*'.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine [zone](/compute/docs/zones#available)
        #   to return operations for.
        #   This field is deprecated, use name instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ServerConfig] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ServerConfig]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_location_server_config(name, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+name}/serverConfig', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ServerConfig::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ServerConfig
          command.params['name'] = name unless name.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Completes master IP rotation.
        # @param [String] name
        #   The name (project, location, cluster id) of the cluster to complete IP
        #   rotation.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::CompleteIpRotationRequest] complete_ip_rotation_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def complete_project_location_cluster_ip_rotation(name, complete_ip_rotation_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:completeIpRotation', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CompleteIpRotationRequest::Representation
          command.request_object = complete_ip_rotation_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a cluster, consisting of the specified number and type of Google
        # Compute Engine instances.
        # By default, the cluster is created in the project's
        # [default network](/compute/docs/networks-and-firewalls#networks).
        # One firewall is added for the cluster. After cluster creation,
        # the cluster creates routes for each node to allow the containers
        # on that node to communicate with all other instances in the
        # cluster.
        # Finally, an entry is added to the project's global metadata indicating
        # which CIDR range is being used by the cluster.
        # @param [String] parent
        #   The parent (project and location) where the cluster will be created.
        #   Specified in the format 'projects/*/locations/*'.
        # @param [Google::Apis::ContainerV1beta1::CreateClusterRequest] create_cluster_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_location_cluster(parent, create_cluster_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+parent}/clusters', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CreateClusterRequest::Representation
          command.request_object = create_cluster_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes the cluster, including the Kubernetes endpoint and all worker
        # nodes.
        # Firewalls and routes that were configured during cluster creation
        # are also deleted.
        # Other Google Compute Engine resources that might be in use by the cluster
        # (e.g. load balancer resources) will not be deleted if they weren't present
        # at the initial create time.
        # @param [String] name
        #   The name (project, location, cluster) of the cluster to delete.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [String] cluster_id
        #   The name of the cluster to delete.
        #   This field is deprecated, use name instead.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_location_cluster(name, cluster_id: nil, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the details of a specific cluster.
        # @param [String] name
        #   The name (project, location, cluster) of the cluster to retrieve.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [String] cluster_id
        #   The name of the cluster to retrieve.
        #   This field is deprecated, use name instead.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Cluster] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Cluster]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_location_cluster(name, cluster_id: nil, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Cluster::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Cluster
          command.params['name'] = name unless name.nil?
          command.query['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all clusters owned by a project in either the specified zone or all
        # zones.
        # @param [String] parent
        #   The parent (project and location) where the clusters will be listed.
        #   Specified in the format 'projects/*/locations/*'.
        #   Location "-" matches all zones and all regions.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides, or "-" for all zones.
        #   This field is deprecated, use parent instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ListClustersResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ListClustersResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_location_clusters(parent, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+parent}/clusters', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ListClustersResponse::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ListClustersResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enables or disables the ABAC authorization mechanism on a cluster.
        # @param [String] name
        #   The name (project, location, cluster id) of the cluster to set legacy abac.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::SetLegacyAbacRequest] set_legacy_abac_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_cluster_legacy_abac(name, set_legacy_abac_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:setLegacyAbac', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetLegacyAbacRequest::Representation
          command.request_object = set_legacy_abac_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Used to set master auth materials. Currently supports :-
        # Changing the admin password of a specific cluster.
        # This can be either via password generation or explicitly set.
        # Modify basic_auth.csv and reset the K8S API server.
        # @param [String] name
        #   The name (project, location, cluster) of the cluster to set auth.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::SetMasterAuthRequest] set_master_auth_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_location_cluster_master_auth(name, set_master_auth_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:setMasterAuth', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetMasterAuthRequest::Representation
          command.request_object = set_master_auth_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enables/Disables Network Policy for a cluster.
        # @param [String] name
        #   The name (project, location, cluster id) of the cluster to set networking
        #   policy.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::SetNetworkPolicyRequest] set_network_policy_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_location_cluster_network_policy(name, set_network_policy_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:setNetworkPolicy', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetNetworkPolicyRequest::Representation
          command.request_object = set_network_policy_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Sets labels on a cluster.
        # @param [String] name
        #   The name (project, location, cluster id) of the cluster to set labels.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::SetLabelsRequest] set_labels_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_location_cluster_resource_labels(name, set_labels_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:setResourceLabels', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetLabelsRequest::Representation
          command.request_object = set_labels_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Start master IP rotation.
        # @param [String] name
        #   The name (project, location, cluster id) of the cluster to start IP rotation.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::StartIpRotationRequest] start_ip_rotation_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def start_project_location_cluster_ip_rotation(name, start_ip_rotation_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:startIpRotation', options)
          command.request_representation = Google::Apis::ContainerV1beta1::StartIpRotationRequest::Representation
          command.request_object = start_ip_rotation_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the settings of a specific cluster.
        # @param [String] name
        #   The name (project, location, cluster) of the cluster to update.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [Google::Apis::ContainerV1beta1::UpdateClusterRequest] update_cluster_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_project_location_cluster(name, update_cluster_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:put, 'v1beta1/{+name}', options)
          command.request_representation = Google::Apis::ContainerV1beta1::UpdateClusterRequest::Representation
          command.request_object = update_cluster_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a node pool for a cluster.
        # @param [String] parent
        #   The parent (project, location, cluster id) where the node pool will be created.
        #   Specified in the format 'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [Google::Apis::ContainerV1beta1::CreateNodePoolRequest] create_node_pool_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_location_cluster_node_pool(parent, create_node_pool_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+parent}/nodePools', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CreateNodePoolRequest::Representation
          command.request_object = create_node_pool_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a node pool from a cluster.
        # @param [String] name
        #   The name (project, location, cluster, node pool id) of the node pool to delete.
        #   Specified in the format 'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [String] node_pool_id
        #   The name of the node pool to delete.
        #   This field is deprecated, use name instead.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_location_cluster_node_pool(name, cluster_id: nil, node_pool_id: nil, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['nodePoolId'] = node_pool_id unless node_pool_id.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Retrieves the node pool requested.
        # @param [String] name
        #   The name (project, location, cluster, node pool id) of the node pool to get.
        #   Specified in the format 'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [String] node_pool_id
        #   The name of the node pool.
        #   This field is deprecated, use name instead.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::NodePool] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::NodePool]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_location_cluster_node_pool(name, cluster_id: nil, node_pool_id: nil, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::NodePool::Representation
          command.response_class = Google::Apis::ContainerV1beta1::NodePool
          command.params['name'] = name unless name.nil?
          command.query['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['nodePoolId'] = node_pool_id unless node_pool_id.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists the node pools for a cluster.
        # @param [String] parent
        #   The parent (project, location, cluster id) where the node pools will be listed.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use parent instead.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use parent instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ListNodePoolsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ListNodePoolsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_location_cluster_node_pools(parent, cluster_id: nil, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+parent}/nodePools', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ListNodePoolsResponse::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ListNodePoolsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Roll back the previously Aborted or Failed NodePool upgrade.
        # This will be an no-op if the last upgrade successfully completed.
        # @param [String] name
        #   The name (project, location, cluster, node pool id) of the node poll to
        #   rollback upgrade.
        #   Specified in the format 'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [Google::Apis::ContainerV1beta1::RollbackNodePoolUpgradeRequest] rollback_node_pool_upgrade_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def rollback_project_location_cluster_node_pool(name, rollback_node_pool_upgrade_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:rollback', options)
          command.request_representation = Google::Apis::ContainerV1beta1::RollbackNodePoolUpgradeRequest::Representation
          command.request_object = rollback_node_pool_upgrade_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Sets the NodeManagement options for a node pool.
        # @param [String] name
        #   The name (project, location, cluster, node pool id) of the node pool to set
        #   management properties. Specified in the format
        #   'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [Google::Apis::ContainerV1beta1::SetNodePoolManagementRequest] set_node_pool_management_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_location_cluster_node_pool_management(name, set_node_pool_management_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:setManagement', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetNodePoolManagementRequest::Representation
          command.request_object = set_node_pool_management_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Cancels the specified operation.
        # @param [String] name
        #   The name (project, location, operation id) of the operation to cancel.
        #   Specified in the format 'projects/*/locations/*/operations/*'.
        # @param [Google::Apis::ContainerV1beta1::CancelOperationRequest] cancel_operation_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def cancel_project_location_operation(name, cancel_operation_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/{+name}:cancel', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CancelOperationRequest::Representation
          command.request_object = cancel_operation_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Empty::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Empty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the specified operation.
        # @param [String] name
        #   The name (project, location, operation id) of the operation to get.
        #   Specified in the format 'projects/*/locations/*/operations/*'.
        # @param [String] operation_id
        #   The server-assigned `name` of the operation.
        #   This field is deprecated, use name instead.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_location_operation(name, operation_id: nil, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['operationId'] = operation_id unless operation_id.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all operations in a project in a specific zone or all zones.
        # @param [String] parent
        #   The parent (project and location) where the operations will be listed.
        #   Specified in the format 'projects/*/locations/*'.
        #   Location "-" matches all zones and all regions.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine [zone](/compute/docs/zones#available)
        #   to return operations for, or `-` for all zones.
        #   This field is deprecated, use parent instead.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ListOperationsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ListOperationsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_location_operations(parent, project_id: nil, zone: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/{+parent}/operations', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ListOperationsResponse::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ListOperationsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['projectId'] = project_id unless project_id.nil?
          command.query['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns configuration info about the Container Engine service.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine [zone](/compute/docs/zones#available)
        #   to return operations for.
        #   This field is deprecated, use name instead.
        # @param [String] name
        #   The name (project and location) of the server config to get
        #   Specified in the format 'projects/*/locations/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ServerConfig] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ServerConfig]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_zone_serverconfig(project_id, zone, name: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/serverconfig', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ServerConfig::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ServerConfig
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.query['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Completes master IP rotation.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::CompleteIpRotationRequest] complete_ip_rotation_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def complete_project_zone_cluster_ip_rotation(project_id, zone, cluster_id, complete_ip_rotation_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}:completeIpRotation', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CompleteIpRotationRequest::Representation
          command.request_object = complete_ip_rotation_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a cluster, consisting of the specified number and type of Google
        # Compute Engine instances.
        # By default, the cluster is created in the project's
        # [default network](/compute/docs/networks-and-firewalls#networks).
        # One firewall is added for the cluster. After cluster creation,
        # the cluster creates routes for each node to allow the containers
        # on that node to communicate with all other instances in the
        # cluster.
        # Finally, an entry is added to the project's global metadata indicating
        # which CIDR range is being used by the cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use parent instead.
        # @param [Google::Apis::ContainerV1beta1::CreateClusterRequest] create_cluster_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_cluster(project_id, zone, create_cluster_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CreateClusterRequest::Representation
          command.request_object = create_cluster_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes the cluster, including the Kubernetes endpoint and all worker
        # nodes.
        # Firewalls and routes that were configured during cluster creation
        # are also deleted.
        # Other Google Compute Engine resources that might be in use by the cluster
        # (e.g. load balancer resources) will not be deleted if they weren't present
        # at the initial create time.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to delete.
        #   This field is deprecated, use name instead.
        # @param [String] name
        #   The name (project, location, cluster) of the cluster to delete.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_zone_cluster(project_id, zone, cluster_id, name: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the details of a specific cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to retrieve.
        #   This field is deprecated, use name instead.
        # @param [String] name
        #   The name (project, location, cluster) of the cluster to retrieve.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Cluster] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Cluster]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_zone_cluster(project_id, zone, cluster_id, name: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Cluster::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Cluster
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enables or disables the ABAC authorization mechanism on a cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to update.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::SetLegacyAbacRequest] set_legacy_abac_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def legacy_project_zone_cluster_abac(project_id, zone, cluster_id, set_legacy_abac_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/legacyAbac', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetLegacyAbacRequest::Representation
          command.request_object = set_legacy_abac_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all clusters owned by a project in either the specified zone or all
        # zones.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides, or "-" for all zones.
        #   This field is deprecated, use parent instead.
        # @param [String] parent
        #   The parent (project and location) where the clusters will be listed.
        #   Specified in the format 'projects/*/locations/*'.
        #   Location "-" matches all zones and all regions.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ListClustersResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ListClustersResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_zone_clusters(project_id, zone, parent: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/clusters', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ListClustersResponse::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ListClustersResponse
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.query['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Sets labels on a cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::SetLabelsRequest] set_labels_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def resource_project_zone_cluster_labels(project_id, zone, cluster_id, set_labels_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/resourceLabels', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetLabelsRequest::Representation
          command.request_object = set_labels_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Used to set master auth materials. Currently supports :-
        # Changing the admin password of a specific cluster.
        # This can be either via password generation or explicitly set.
        # Modify basic_auth.csv and reset the K8S API server.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to upgrade.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::SetMasterAuthRequest] set_master_auth_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_zone_cluster_master_auth(project_id, zone, cluster_id, set_master_auth_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}:setMasterAuth', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetMasterAuthRequest::Representation
          command.request_object = set_master_auth_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Enables/Disables Network Policy for a cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::SetNetworkPolicyRequest] set_network_policy_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_zone_cluster_network_policy(project_id, zone, cluster_id, set_network_policy_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}:setNetworkPolicy', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetNetworkPolicyRequest::Representation
          command.request_object = set_network_policy_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Start master IP rotation.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::StartIpRotationRequest] start_ip_rotation_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def start_project_zone_cluster_ip_rotation(project_id, zone, cluster_id, start_ip_rotation_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}:startIpRotation', options)
          command.request_representation = Google::Apis::ContainerV1beta1::StartIpRotationRequest::Representation
          command.request_object = start_ip_rotation_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the settings of a specific cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to upgrade.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::UpdateClusterRequest] update_cluster_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_project_zone_cluster(project_id, zone, cluster_id, update_cluster_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:put, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}', options)
          command.request_representation = Google::Apis::ContainerV1beta1::UpdateClusterRequest::Representation
          command.request_object = update_cluster_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a node pool for a cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use parent instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use parent instead.
        # @param [Google::Apis::ContainerV1beta1::CreateNodePoolRequest] create_node_pool_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_zone_cluster_node_pool(project_id, zone, cluster_id, create_node_pool_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/nodePools', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CreateNodePoolRequest::Representation
          command.request_object = create_node_pool_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a node pool from a cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [String] node_pool_id
        #   The name of the node pool to delete.
        #   This field is deprecated, use name instead.
        # @param [String] name
        #   The name (project, location, cluster, node pool id) of the node pool to delete.
        #   Specified in the format 'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_zone_cluster_node_pool(project_id, zone, cluster_id, node_pool_id, name: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/nodePools/{nodePoolId}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.params['nodePoolId'] = node_pool_id unless node_pool_id.nil?
          command.query['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Retrieves the node pool requested.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use name instead.
        # @param [String] node_pool_id
        #   The name of the node pool.
        #   This field is deprecated, use name instead.
        # @param [String] name
        #   The name (project, location, cluster, node pool id) of the node pool to get.
        #   Specified in the format 'projects/*/locations/*/clusters/*/nodePools/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::NodePool] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::NodePool]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_zone_cluster_node_pool(project_id, zone, cluster_id, node_pool_id, name: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/nodePools/{nodePoolId}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::NodePool::Representation
          command.response_class = Google::Apis::ContainerV1beta1::NodePool
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.params['nodePoolId'] = node_pool_id unless node_pool_id.nil?
          command.query['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists the node pools for a cluster.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://developers.google.com/console/help/new/#projectnumber).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use parent instead.
        # @param [String] cluster_id
        #   The name of the cluster.
        #   This field is deprecated, use parent instead.
        # @param [String] parent
        #   The parent (project, location, cluster id) where the node pools will be listed.
        #   Specified in the format 'projects/*/locations/*/clusters/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ListNodePoolsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ListNodePoolsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_zone_cluster_node_pools(project_id, zone, cluster_id, parent: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/nodePools', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ListNodePoolsResponse::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ListNodePoolsResponse
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.query['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Roll back the previously Aborted or Failed NodePool upgrade.
        # This will be an no-op if the last upgrade successfully completed.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to rollback.
        #   This field is deprecated, use name instead.
        # @param [String] node_pool_id
        #   The name of the node pool to rollback.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::RollbackNodePoolUpgradeRequest] rollback_node_pool_upgrade_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def rollback_project_zone_cluster_node_pool(project_id, zone, cluster_id, node_pool_id, rollback_node_pool_upgrade_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/nodePools/{nodePoolId}:rollback', options)
          command.request_representation = Google::Apis::ContainerV1beta1::RollbackNodePoolUpgradeRequest::Representation
          command.request_object = rollback_node_pool_upgrade_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.params['nodePoolId'] = node_pool_id unless node_pool_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Sets the NodeManagement options for a node pool.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] cluster_id
        #   The name of the cluster to update.
        #   This field is deprecated, use name instead.
        # @param [String] node_pool_id
        #   The name of the node pool to update.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::SetNodePoolManagementRequest] set_node_pool_management_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def set_project_zone_cluster_node_pool_management(project_id, zone, cluster_id, node_pool_id, set_node_pool_management_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/clusters/{clusterId}/nodePools/{nodePoolId}/setManagement', options)
          command.request_representation = Google::Apis::ContainerV1beta1::SetNodePoolManagementRequest::Representation
          command.request_object = set_node_pool_management_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['clusterId'] = cluster_id unless cluster_id.nil?
          command.params['nodePoolId'] = node_pool_id unless node_pool_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Cancels the specified operation.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the operation resides.
        #   This field is deprecated, use name instead.
        # @param [String] operation_id
        #   The server-assigned `name` of the operation.
        #   This field is deprecated, use name instead.
        # @param [Google::Apis::ContainerV1beta1::CancelOperationRequest] cancel_operation_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def cancel_project_zone_operation(project_id, zone, operation_id, cancel_operation_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta1/projects/{projectId}/zones/{zone}/operations/{operationId}:cancel', options)
          command.request_representation = Google::Apis::ContainerV1beta1::CancelOperationRequest::Representation
          command.request_object = cancel_operation_request_object
          command.response_representation = Google::Apis::ContainerV1beta1::Empty::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Empty
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['operationId'] = operation_id unless operation_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the specified operation.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use name instead.
        # @param [String] zone
        #   The name of the Google Compute Engine
        #   [zone](/compute/docs/zones#available) in which the cluster
        #   resides.
        #   This field is deprecated, use name instead.
        # @param [String] operation_id
        #   The server-assigned `name` of the operation.
        #   This field is deprecated, use name instead.
        # @param [String] name
        #   The name (project, location, operation id) of the operation to get.
        #   Specified in the format 'projects/*/locations/*/operations/*'.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_zone_operation(project_id, zone, operation_id, name: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/operations/{operationId}', options)
          command.response_representation = Google::Apis::ContainerV1beta1::Operation::Representation
          command.response_class = Google::Apis::ContainerV1beta1::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.params['operationId'] = operation_id unless operation_id.nil?
          command.query['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all operations in a project in a specific zone or all zones.
        # @param [String] project_id
        #   The Google Developers Console [project ID or project
        #   number](https://support.google.com/cloud/answer/6158840).
        #   This field is deprecated, use parent instead.
        # @param [String] zone
        #   The name of the Google Compute Engine [zone](/compute/docs/zones#available)
        #   to return operations for, or `-` for all zones.
        #   This field is deprecated, use parent instead.
        # @param [String] parent
        #   The parent (project and location) where the operations will be listed.
        #   Specified in the format 'projects/*/locations/*'.
        #   Location "-" matches all zones and all regions.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::ContainerV1beta1::ListOperationsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::ContainerV1beta1::ListOperationsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_zone_operations(project_id, zone, parent: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta1/projects/{projectId}/zones/{zone}/operations', options)
          command.response_representation = Google::Apis::ContainerV1beta1::ListOperationsResponse::Representation
          command.response_class = Google::Apis::ContainerV1beta1::ListOperationsResponse
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['zone'] = zone unless zone.nil?
          command.query['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end

        protected

        def apply_command_defaults(command)
          command.query['key'] = key unless key.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
        end
      end
    end
  end
end
