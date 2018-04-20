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

require 'date'
require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module ContainerV1
      
      class AcceleratorConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddonsConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoUpgradeOptions
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CancelOperationRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CidrBlock
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClientCertificateConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Cluster
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClusterUpdate
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CompleteIpRotationRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CreateClusterRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CreateNodePoolRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Empty
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HorizontalPodAutoscaling
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpLoadBalancing
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class IpAllocationPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class KubernetesDashboard
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LegacyAbac
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListClustersResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListNodePoolsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListOperationsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MasterAuth
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MasterAuthorizedNetworksConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NodeConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NodeManagement
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NodePool
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NodePoolAutoscaling
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Operation
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RollbackNodePoolUpgradeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ServerConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetAddonsConfigRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetLabelsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetLegacyAbacRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetLocationsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetLoggingServiceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetMasterAuthRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetMonitoringServiceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetNetworkPolicyRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetNodePoolAutoscalingRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetNodePoolManagementRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetNodePoolSizeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StartIpRotationRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateClusterRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateMasterRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateNodePoolRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :accelerator_count, :numeric_string => true, as: 'acceleratorCount'
          property :accelerator_type, as: 'acceleratorType'
        end
      end
      
      class AddonsConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :horizontal_pod_autoscaling, as: 'horizontalPodAutoscaling', class: Google::Apis::ContainerV1::HorizontalPodAutoscaling, decorator: Google::Apis::ContainerV1::HorizontalPodAutoscaling::Representation
      
          property :http_load_balancing, as: 'httpLoadBalancing', class: Google::Apis::ContainerV1::HttpLoadBalancing, decorator: Google::Apis::ContainerV1::HttpLoadBalancing::Representation
      
          property :kubernetes_dashboard, as: 'kubernetesDashboard', class: Google::Apis::ContainerV1::KubernetesDashboard, decorator: Google::Apis::ContainerV1::KubernetesDashboard::Representation
      
        end
      end
      
      class AutoUpgradeOptions
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :auto_upgrade_start_time, as: 'autoUpgradeStartTime'
          property :description, as: 'description'
        end
      end
      
      class CancelOperationRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class CidrBlock
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cidr_block, as: 'cidrBlock'
          property :display_name, as: 'displayName'
        end
      end
      
      class ClientCertificateConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :issue_client_certificate, as: 'issueClientCertificate'
        end
      end
      
      class Cluster
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :addons_config, as: 'addonsConfig', class: Google::Apis::ContainerV1::AddonsConfig, decorator: Google::Apis::ContainerV1::AddonsConfig::Representation
      
          property :cluster_ipv4_cidr, as: 'clusterIpv4Cidr'
          property :create_time, as: 'createTime'
          property :current_master_version, as: 'currentMasterVersion'
          property :current_node_count, as: 'currentNodeCount'
          property :current_node_version, as: 'currentNodeVersion'
          property :description, as: 'description'
          property :enable_kubernetes_alpha, as: 'enableKubernetesAlpha'
          property :endpoint, as: 'endpoint'
          property :expire_time, as: 'expireTime'
          property :initial_cluster_version, as: 'initialClusterVersion'
          property :initial_node_count, as: 'initialNodeCount'
          collection :instance_group_urls, as: 'instanceGroupUrls'
          property :ip_allocation_policy, as: 'ipAllocationPolicy', class: Google::Apis::ContainerV1::IpAllocationPolicy, decorator: Google::Apis::ContainerV1::IpAllocationPolicy::Representation
      
          property :label_fingerprint, as: 'labelFingerprint'
          property :legacy_abac, as: 'legacyAbac', class: Google::Apis::ContainerV1::LegacyAbac, decorator: Google::Apis::ContainerV1::LegacyAbac::Representation
      
          collection :locations, as: 'locations'
          property :logging_service, as: 'loggingService'
          property :master_auth, as: 'masterAuth', class: Google::Apis::ContainerV1::MasterAuth, decorator: Google::Apis::ContainerV1::MasterAuth::Representation
      
          property :master_authorized_networks_config, as: 'masterAuthorizedNetworksConfig', class: Google::Apis::ContainerV1::MasterAuthorizedNetworksConfig, decorator: Google::Apis::ContainerV1::MasterAuthorizedNetworksConfig::Representation
      
          property :monitoring_service, as: 'monitoringService'
          property :name, as: 'name'
          property :network, as: 'network'
          property :network_policy, as: 'networkPolicy', class: Google::Apis::ContainerV1::NetworkPolicy, decorator: Google::Apis::ContainerV1::NetworkPolicy::Representation
      
          property :node_config, as: 'nodeConfig', class: Google::Apis::ContainerV1::NodeConfig, decorator: Google::Apis::ContainerV1::NodeConfig::Representation
      
          property :node_ipv4_cidr_size, as: 'nodeIpv4CidrSize'
          collection :node_pools, as: 'nodePools', class: Google::Apis::ContainerV1::NodePool, decorator: Google::Apis::ContainerV1::NodePool::Representation
      
          hash :resource_labels, as: 'resourceLabels'
          property :self_link, as: 'selfLink'
          property :services_ipv4_cidr, as: 'servicesIpv4Cidr'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
          property :subnetwork, as: 'subnetwork'
          property :zone, as: 'zone'
        end
      end
      
      class ClusterUpdate
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :desired_addons_config, as: 'desiredAddonsConfig', class: Google::Apis::ContainerV1::AddonsConfig, decorator: Google::Apis::ContainerV1::AddonsConfig::Representation
      
          property :desired_image_type, as: 'desiredImageType'
          collection :desired_locations, as: 'desiredLocations'
          property :desired_master_authorized_networks_config, as: 'desiredMasterAuthorizedNetworksConfig', class: Google::Apis::ContainerV1::MasterAuthorizedNetworksConfig, decorator: Google::Apis::ContainerV1::MasterAuthorizedNetworksConfig::Representation
      
          property :desired_master_version, as: 'desiredMasterVersion'
          property :desired_monitoring_service, as: 'desiredMonitoringService'
          property :desired_node_pool_autoscaling, as: 'desiredNodePoolAutoscaling', class: Google::Apis::ContainerV1::NodePoolAutoscaling, decorator: Google::Apis::ContainerV1::NodePoolAutoscaling::Representation
      
          property :desired_node_pool_id, as: 'desiredNodePoolId'
          property :desired_node_version, as: 'desiredNodeVersion'
        end
      end
      
      class CompleteIpRotationRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class CreateClusterRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cluster, as: 'cluster', class: Google::Apis::ContainerV1::Cluster, decorator: Google::Apis::ContainerV1::Cluster::Representation
      
        end
      end
      
      class CreateNodePoolRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :node_pool, as: 'nodePool', class: Google::Apis::ContainerV1::NodePool, decorator: Google::Apis::ContainerV1::NodePool::Representation
      
        end
      end
      
      class Empty
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class HorizontalPodAutoscaling
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :disabled, as: 'disabled'
        end
      end
      
      class HttpLoadBalancing
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :disabled, as: 'disabled'
        end
      end
      
      class IpAllocationPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cluster_ipv4_cidr, as: 'clusterIpv4Cidr'
          property :cluster_ipv4_cidr_block, as: 'clusterIpv4CidrBlock'
          property :cluster_secondary_range_name, as: 'clusterSecondaryRangeName'
          property :create_subnetwork, as: 'createSubnetwork'
          property :node_ipv4_cidr, as: 'nodeIpv4Cidr'
          property :node_ipv4_cidr_block, as: 'nodeIpv4CidrBlock'
          property :services_ipv4_cidr, as: 'servicesIpv4Cidr'
          property :services_ipv4_cidr_block, as: 'servicesIpv4CidrBlock'
          property :services_secondary_range_name, as: 'servicesSecondaryRangeName'
          property :subnetwork_name, as: 'subnetworkName'
          property :use_ip_aliases, as: 'useIpAliases'
        end
      end
      
      class KubernetesDashboard
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :disabled, as: 'disabled'
        end
      end
      
      class LegacyAbac
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :enabled, as: 'enabled'
        end
      end
      
      class ListClustersResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :clusters, as: 'clusters', class: Google::Apis::ContainerV1::Cluster, decorator: Google::Apis::ContainerV1::Cluster::Representation
      
          collection :missing_zones, as: 'missingZones'
        end
      end
      
      class ListNodePoolsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :node_pools, as: 'nodePools', class: Google::Apis::ContainerV1::NodePool, decorator: Google::Apis::ContainerV1::NodePool::Representation
      
        end
      end
      
      class ListOperationsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :missing_zones, as: 'missingZones'
          collection :operations, as: 'operations', class: Google::Apis::ContainerV1::Operation, decorator: Google::Apis::ContainerV1::Operation::Representation
      
        end
      end
      
      class MasterAuth
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :client_certificate, as: 'clientCertificate'
          property :client_certificate_config, as: 'clientCertificateConfig', class: Google::Apis::ContainerV1::ClientCertificateConfig, decorator: Google::Apis::ContainerV1::ClientCertificateConfig::Representation
      
          property :client_key, as: 'clientKey'
          property :cluster_ca_certificate, as: 'clusterCaCertificate'
          property :password, as: 'password'
          property :username, as: 'username'
        end
      end
      
      class MasterAuthorizedNetworksConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :cidr_blocks, as: 'cidrBlocks', class: Google::Apis::ContainerV1::CidrBlock, decorator: Google::Apis::ContainerV1::CidrBlock::Representation
      
          property :enabled, as: 'enabled'
        end
      end
      
      class NetworkPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :enabled, as: 'enabled'
          property :provider, as: 'provider'
        end
      end
      
      class NodeConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :accelerators, as: 'accelerators', class: Google::Apis::ContainerV1::AcceleratorConfig, decorator: Google::Apis::ContainerV1::AcceleratorConfig::Representation
      
          property :disk_size_gb, as: 'diskSizeGb'
          property :image_type, as: 'imageType'
          hash :labels, as: 'labels'
          property :local_ssd_count, as: 'localSsdCount'
          property :machine_type, as: 'machineType'
          hash :metadata, as: 'metadata'
          collection :oauth_scopes, as: 'oauthScopes'
          property :preemptible, as: 'preemptible'
          property :service_account, as: 'serviceAccount'
          collection :tags, as: 'tags'
        end
      end
      
      class NodeManagement
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :auto_repair, as: 'autoRepair'
          property :auto_upgrade, as: 'autoUpgrade'
          property :upgrade_options, as: 'upgradeOptions', class: Google::Apis::ContainerV1::AutoUpgradeOptions, decorator: Google::Apis::ContainerV1::AutoUpgradeOptions::Representation
      
        end
      end
      
      class NodePool
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :autoscaling, as: 'autoscaling', class: Google::Apis::ContainerV1::NodePoolAutoscaling, decorator: Google::Apis::ContainerV1::NodePoolAutoscaling::Representation
      
          property :config, as: 'config', class: Google::Apis::ContainerV1::NodeConfig, decorator: Google::Apis::ContainerV1::NodeConfig::Representation
      
          property :initial_node_count, as: 'initialNodeCount'
          collection :instance_group_urls, as: 'instanceGroupUrls'
          property :management, as: 'management', class: Google::Apis::ContainerV1::NodeManagement, decorator: Google::Apis::ContainerV1::NodeManagement::Representation
      
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
          property :version, as: 'version'
        end
      end
      
      class NodePoolAutoscaling
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :enabled, as: 'enabled'
          property :max_node_count, as: 'maxNodeCount'
          property :min_node_count, as: 'minNodeCount'
        end
      end
      
      class Operation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :detail, as: 'detail'
          property :end_time, as: 'endTime'
          property :name, as: 'name'
          property :operation_type, as: 'operationType'
          property :self_link, as: 'selfLink'
          property :start_time, as: 'startTime'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
          property :target_link, as: 'targetLink'
          property :zone, as: 'zone'
        end
      end
      
      class RollbackNodePoolUpgradeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class ServerConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :default_cluster_version, as: 'defaultClusterVersion'
          property :default_image_type, as: 'defaultImageType'
          collection :valid_image_types, as: 'validImageTypes'
          collection :valid_master_versions, as: 'validMasterVersions'
          collection :valid_node_versions, as: 'validNodeVersions'
        end
      end
      
      class SetAddonsConfigRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :addons_config, as: 'addonsConfig', class: Google::Apis::ContainerV1::AddonsConfig, decorator: Google::Apis::ContainerV1::AddonsConfig::Representation
      
        end
      end
      
      class SetLabelsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :label_fingerprint, as: 'labelFingerprint'
          hash :resource_labels, as: 'resourceLabels'
        end
      end
      
      class SetLegacyAbacRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :enabled, as: 'enabled'
        end
      end
      
      class SetLocationsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :locations, as: 'locations'
        end
      end
      
      class SetLoggingServiceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :logging_service, as: 'loggingService'
        end
      end
      
      class SetMasterAuthRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :action, as: 'action'
          property :update, as: 'update', class: Google::Apis::ContainerV1::MasterAuth, decorator: Google::Apis::ContainerV1::MasterAuth::Representation
      
        end
      end
      
      class SetMonitoringServiceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :monitoring_service, as: 'monitoringService'
        end
      end
      
      class SetNetworkPolicyRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :network_policy, as: 'networkPolicy', class: Google::Apis::ContainerV1::NetworkPolicy, decorator: Google::Apis::ContainerV1::NetworkPolicy::Representation
      
        end
      end
      
      class SetNodePoolAutoscalingRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :autoscaling, as: 'autoscaling', class: Google::Apis::ContainerV1::NodePoolAutoscaling, decorator: Google::Apis::ContainerV1::NodePoolAutoscaling::Representation
      
        end
      end
      
      class SetNodePoolManagementRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :management, as: 'management', class: Google::Apis::ContainerV1::NodeManagement, decorator: Google::Apis::ContainerV1::NodeManagement::Representation
      
        end
      end
      
      class SetNodePoolSizeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :node_count, as: 'nodeCount'
        end
      end
      
      class StartIpRotationRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class UpdateClusterRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :update, as: 'update', class: Google::Apis::ContainerV1::ClusterUpdate, decorator: Google::Apis::ContainerV1::ClusterUpdate::Representation
      
        end
      end
      
      class UpdateMasterRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :master_version, as: 'masterVersion'
        end
      end
      
      class UpdateNodePoolRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :image_type, as: 'imageType'
          property :node_version, as: 'nodeVersion'
        end
      end
    end
  end
end
