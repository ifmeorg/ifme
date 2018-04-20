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
    module ComputeAlpha
      
      class AcceleratorConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorType
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorTypeAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorTypeList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorTypesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AccessConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Address
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddressAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddressList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddressesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AliasIpRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AttachedDisk
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AttachedDiskInitializeParams
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AuditConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AuditLogConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AuthorizationLoggingOptions
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Autoscaler
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalerAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalerList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalerStatusDetails
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalersScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalingPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalingPolicyCpuUtilization
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalingPolicyCustomMetricUtilization
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalingPolicyLoadBalancingUtilization
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalingPolicyQueueBasedScaling
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoscalingPolicyQueueBasedScalingCloudPubSub
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Backend
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendBucket
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendBucketCdnPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendBucketList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendService
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServiceAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServiceCdnPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServiceGroupHealth
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServiceIap
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServiceList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServiceReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BackendServicesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Binding
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CacheInvalidationRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CacheKeyPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Commitment
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CommitmentAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CommitmentList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CommitmentsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Condition
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ConnectionDraining
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CustomerEncryptionKey
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CustomerEncryptionKeyProtectedDisk
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeprecationStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Disk
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskMoveRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskType
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskTypeAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskTypeList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskTypesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DisksResizeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DisksScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DistributionPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DistributionPolicyZoneConfiguration
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Expr
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Firewall
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Allowed
          class Representation < Google::Apis::Core::JsonRepresentation; end
        
          include Google::Apis::Core::JsonObjectSupport
        end
        
        class Denied
          class Representation < Google::Apis::Core::JsonRepresentation; end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FirewallList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FixedOrPercent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ForwardingRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ForwardingRuleAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ForwardingRuleList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ForwardingRuleReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ForwardingRulesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GlobalSetLabelsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GuestAttributes
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GuestOsFeature
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Http2HealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpsHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HealthCheckList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HealthCheckReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HealthStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HealthStatusForNetworkEndpoint
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Host
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostType
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostTypeAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostTypeList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostTypesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HostsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpHealthCheckList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpsHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HttpsHealthCheckList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Image
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class RawDisk
          class Representation < Google::Apis::Core::JsonRepresentation; end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ImageList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Instance
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroup
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManager
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerActionsSummary
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerActivities
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerAutoHealingPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerPendingActionsSummary
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerStatefulPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerStatefulPolicyDiskPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerUpdatePolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagerVersion
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersAbandonInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersApplyUpdatesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersDeleteInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersDeletePerInstanceConfigsReq
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersListManagedInstancesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersListPerInstanceConfigsResp
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersRecreateInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersResizeAdvancedRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersSetAutoHealingRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersSetInstanceTemplateRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersSetTargetPoolsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupManagersUpdatePerInstanceConfigsReq
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupsAddInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupsListInstances
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupsListInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupsRemoveInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupsSetNamedPortsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceListReferrers
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceMoveRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceProperties
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceTemplate
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceTemplateList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceWithNamedPorts
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesSetLabelsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesSetMachineResourcesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesSetMachineTypeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesSetMinCpuPlatformRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesSetServiceAccountRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstancesStartWithEncryptionKeyRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Interconnect
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectAttachment
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectAttachmentAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectAttachmentList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectAttachmentPrivateInfo
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectAttachmentsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectCircuitInfo
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectLocation
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectLocationList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectLocationRegionInfo
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterconnectOutageNotification
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InternalIpOwner
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class IpOwnerList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class License
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LicenseCode
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LicenseCodeLicenseAlias
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LicenseResourceRequirements
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LicensesListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LogConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LogConfigCloudAuditOptions
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LogConfigCounterOptions
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LogConfigDataAccessOptions
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MachineType
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MachineTypeAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MachineTypeList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MachineTypesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedInstance
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedInstanceLastAttempt
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Errors
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Error
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedInstanceOverride
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedInstanceOverrideDiskOverride
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedInstanceVersion
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Metadata
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Item
          class Representation < Google::Apis::Core::JsonRepresentation; end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NamedPort
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Network
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpoint
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroup
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupLbNetworkEndpointGroup
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupsAttachEndpointsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupsDetachEndpointsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupsListEndpointsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupsListNetworkEndpoints
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointGroupsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkEndpointWithHealthStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkInterface
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkPeering
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworkRoutingConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworksAddPeeringRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NetworksRemovePeeringRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Operation
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Error
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Error
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class OperationAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class OperationList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class OperationsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PathMatcher
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PathRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PerInstanceConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Policy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Project
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProjectsDisableXpnResourceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProjectsEnableXpnResourceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProjectsGetXpnResources
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProjectsListXpnHostsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProjectsSetDefaultServiceAccountRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Quota
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Reference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Region
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionAutoscalerList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionDiskTypeList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionDisksResizeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagerDeleteInstanceConfigReq
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagerList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagerUpdateInstanceConfigReq
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersAbandonInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersApplyUpdatesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersDeleteInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersListInstanceConfigsResp
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersListInstancesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersRecreateRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersSetAutoHealingRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersSetTargetPoolsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupManagersSetTemplateRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupsListInstances
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupsListInstancesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionInstanceGroupsSetNamedPortsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegionSetLabelsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ResourceCommitment
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ResourceGroupReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Route
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouteList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Router
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterAdvertisedPrefix
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterBgp
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterBgpPeer
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterInterface
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterNat
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterNatSubnetworkToNat
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterStatusBgpPeerStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterStatusNatStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RouterStatusResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RoutersPreviewResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RoutersScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Rule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SslHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Scheduling
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SecurityPoliciesList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SecurityPolicy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SecurityPolicyReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SecurityPolicyRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SecurityPolicyRuleMatcher
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SecurityPolicyRuleMatcherConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SerialPortOutput
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ServiceAccount
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SignedUrlKey
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Snapshot
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SnapshotList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SslCertificate
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SslCertificateList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Subnetwork
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubnetworkAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubnetworkList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubnetworkSecondaryRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubnetworksExpandIpCidrRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubnetworksScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubnetworksSetPrivateIpGoogleAccessRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TcpHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Tags
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetHttpProxy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetHttpProxyList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetHttpsProxiesSetQuicOverrideRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetHttpsProxiesSetSslCertificatesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetHttpsProxy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetHttpsProxyList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetInstance
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetInstanceAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetInstanceList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetInstancesScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPool
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolInstanceHealth
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolsAddHealthCheckRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolsAddInstanceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolsRemoveHealthCheckRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolsRemoveInstanceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetPoolsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetSslProxiesSetBackendServiceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetSslProxiesSetProxyHeaderRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetSslProxiesSetSslCertificatesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetSslProxy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetSslProxyList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetTcpProxiesSetBackendServiceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetTcpProxiesSetProxyHeaderRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetTcpProxy
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetTcpProxyList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetVpnGateway
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetVpnGatewayAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetVpnGatewayList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TargetVpnGatewaysScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TestFailure
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TestPermissionsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TestPermissionsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UdpHealthCheck
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMap
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMapList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMapReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMapTest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMapValidationResult
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMapsValidateRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UrlMapsValidateResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UsageExportLocation
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class VpnTunnel
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class VpnTunnelAggregatedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class VpnTunnelList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class VpnTunnelsScopedList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class XpnHostList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class XpnResourceId
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Zone
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ZoneList
        class Representation < Google::Apis::Core::JsonRepresentation; end
        
        class Warning
          class Representation < Google::Apis::Core::JsonRepresentation; end
          
          class Datum
            class Representation < Google::Apis::Core::JsonRepresentation; end
          
            include Google::Apis::Core::JsonObjectSupport
          end
        
          include Google::Apis::Core::JsonObjectSupport
        end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ZoneSetLabelsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :accelerator_count, as: 'acceleratorCount'
          property :accelerator_type, as: 'acceleratorType'
        end
      end
      
      class AcceleratorType
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :maximum_cards_per_instance, as: 'maximumCardsPerInstance'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :zone, as: 'zone'
        end
      end
      
      class AcceleratorTypeAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::AcceleratorTypesScopedList, decorator: Google::Apis::ComputeAlpha::AcceleratorTypesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AcceleratorTypeAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::AcceleratorTypeAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AcceleratorTypeAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AcceleratorTypeAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AcceleratorTypeList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::AcceleratorType, decorator: Google::Apis::ComputeAlpha::AcceleratorType::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AcceleratorTypeList::Warning, decorator: Google::Apis::ComputeAlpha::AcceleratorTypeList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AcceleratorTypeList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AcceleratorTypeList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AcceleratorTypesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :accelerator_types, as: 'acceleratorTypes', class: Google::Apis::ComputeAlpha::AcceleratorType, decorator: Google::Apis::ComputeAlpha::AcceleratorType::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AcceleratorTypesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::AcceleratorTypesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AcceleratorTypesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AcceleratorTypesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AccessConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :nat_ip, as: 'natIP'
          property :network_tier, as: 'networkTier'
          property :public_dns_name, as: 'publicDnsName'
          property :public_ptr_domain_name, as: 'publicPtrDomainName'
          property :set_public_dns, as: 'setPublicDns'
          property :set_public_ptr, as: 'setPublicPtr'
          property :type, as: 'type'
        end
      end
      
      class Address
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :address, as: 'address'
          property :address_type, as: 'addressType'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :ip_version, as: 'ipVersion'
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          property :name, as: 'name'
          property :network_tier, as: 'networkTier'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
          property :subnetwork, as: 'subnetwork'
          collection :users, as: 'users'
        end
      end
      
      class AddressAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::AddressesScopedList, decorator: Google::Apis::ComputeAlpha::AddressesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AddressAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::AddressAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AddressAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AddressAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AddressList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Address, decorator: Google::Apis::ComputeAlpha::Address::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AddressList::Warning, decorator: Google::Apis::ComputeAlpha::AddressList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AddressList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AddressList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AddressesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :addresses, as: 'addresses', class: Google::Apis::ComputeAlpha::Address, decorator: Google::Apis::ComputeAlpha::Address::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AddressesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::AddressesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AddressesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AddressesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AliasIpRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :ip_cidr_range, as: 'ipCidrRange'
          property :subnetwork_range_name, as: 'subnetworkRangeName'
        end
      end
      
      class AttachedDisk
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :auto_delete, as: 'autoDelete'
          property :boot, as: 'boot'
          property :device_name, as: 'deviceName'
          property :disk_encryption_key, as: 'diskEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :disk_size_gb, :numeric_string => true, as: 'diskSizeGb'
          property :index, as: 'index'
          property :initialize_params, as: 'initializeParams', class: Google::Apis::ComputeAlpha::AttachedDiskInitializeParams, decorator: Google::Apis::ComputeAlpha::AttachedDiskInitializeParams::Representation
      
          property :interface, as: 'interface'
          property :kind, as: 'kind'
          collection :licenses, as: 'licenses'
          property :mode, as: 'mode'
          property :source, as: 'source'
          property :type, as: 'type'
        end
      end
      
      class AttachedDiskInitializeParams
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :disk_name, as: 'diskName'
          property :disk_size_gb, :numeric_string => true, as: 'diskSizeGb'
          property :disk_storage_type, as: 'diskStorageType'
          property :disk_type, as: 'diskType'
          property :source_image, as: 'sourceImage'
          property :source_image_encryption_key, as: 'sourceImageEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
        end
      end
      
      class AuditConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :audit_log_configs, as: 'auditLogConfigs', class: Google::Apis::ComputeAlpha::AuditLogConfig, decorator: Google::Apis::ComputeAlpha::AuditLogConfig::Representation
      
          collection :exempted_members, as: 'exemptedMembers'
          property :service, as: 'service'
        end
      end
      
      class AuditLogConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :exempted_members, as: 'exemptedMembers'
          property :log_type, as: 'logType'
        end
      end
      
      class AuthorizationLoggingOptions
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :permission_type, as: 'permissionType'
        end
      end
      
      class Autoscaler
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :autoscaling_policy, as: 'autoscalingPolicy', class: Google::Apis::ComputeAlpha::AutoscalingPolicy, decorator: Google::Apis::ComputeAlpha::AutoscalingPolicy::Representation
      
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
          collection :status_details, as: 'statusDetails', class: Google::Apis::ComputeAlpha::AutoscalerStatusDetails, decorator: Google::Apis::ComputeAlpha::AutoscalerStatusDetails::Representation
      
          property :target, as: 'target'
          property :zone, as: 'zone'
        end
      end
      
      class AutoscalerAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::AutoscalersScopedList, decorator: Google::Apis::ComputeAlpha::AutoscalersScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AutoscalerAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::AutoscalerAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AutoscalerAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AutoscalerAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AutoscalerList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Autoscaler, decorator: Google::Apis::ComputeAlpha::Autoscaler::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AutoscalerList::Warning, decorator: Google::Apis::ComputeAlpha::AutoscalerList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AutoscalerList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AutoscalerList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AutoscalerStatusDetails
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :message, as: 'message'
          property :type, as: 'type'
        end
      end
      
      class AutoscalersScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :autoscalers, as: 'autoscalers', class: Google::Apis::ComputeAlpha::Autoscaler, decorator: Google::Apis::ComputeAlpha::Autoscaler::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::AutoscalersScopedList::Warning, decorator: Google::Apis::ComputeAlpha::AutoscalersScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::AutoscalersScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::AutoscalersScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class AutoscalingPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cool_down_period_sec, as: 'coolDownPeriodSec'
          property :cpu_utilization, as: 'cpuUtilization', class: Google::Apis::ComputeAlpha::AutoscalingPolicyCpuUtilization, decorator: Google::Apis::ComputeAlpha::AutoscalingPolicyCpuUtilization::Representation
      
          collection :custom_metric_utilizations, as: 'customMetricUtilizations', class: Google::Apis::ComputeAlpha::AutoscalingPolicyCustomMetricUtilization, decorator: Google::Apis::ComputeAlpha::AutoscalingPolicyCustomMetricUtilization::Representation
      
          property :load_balancing_utilization, as: 'loadBalancingUtilization', class: Google::Apis::ComputeAlpha::AutoscalingPolicyLoadBalancingUtilization, decorator: Google::Apis::ComputeAlpha::AutoscalingPolicyLoadBalancingUtilization::Representation
      
          property :max_num_replicas, as: 'maxNumReplicas'
          property :min_num_replicas, as: 'minNumReplicas'
          property :mode, as: 'mode'
          property :queue_based_scaling, as: 'queueBasedScaling', class: Google::Apis::ComputeAlpha::AutoscalingPolicyQueueBasedScaling, decorator: Google::Apis::ComputeAlpha::AutoscalingPolicyQueueBasedScaling::Representation
      
        end
      end
      
      class AutoscalingPolicyCpuUtilization
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :utilization_target, as: 'utilizationTarget'
        end
      end
      
      class AutoscalingPolicyCustomMetricUtilization
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter, as: 'filter'
          property :metric, as: 'metric'
          property :single_instance_assignment, as: 'singleInstanceAssignment'
          property :utilization_target, as: 'utilizationTarget'
          property :utilization_target_type, as: 'utilizationTargetType'
        end
      end
      
      class AutoscalingPolicyLoadBalancingUtilization
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :utilization_target, as: 'utilizationTarget'
        end
      end
      
      class AutoscalingPolicyQueueBasedScaling
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :acceptable_backlog_per_instance, as: 'acceptableBacklogPerInstance'
          property :cloud_pub_sub, as: 'cloudPubSub', class: Google::Apis::ComputeAlpha::AutoscalingPolicyQueueBasedScalingCloudPubSub, decorator: Google::Apis::ComputeAlpha::AutoscalingPolicyQueueBasedScalingCloudPubSub::Representation
      
          property :single_worker_throughput_per_sec, as: 'singleWorkerThroughputPerSec'
        end
      end
      
      class AutoscalingPolicyQueueBasedScalingCloudPubSub
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :subscription, as: 'subscription'
          property :topic, as: 'topic'
        end
      end
      
      class Backend
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :balancing_mode, as: 'balancingMode'
          property :capacity_scaler, as: 'capacityScaler'
          property :description, as: 'description'
          property :failover, as: 'failover'
          property :group, as: 'group'
          property :max_connections, as: 'maxConnections'
          property :max_connections_per_instance, as: 'maxConnectionsPerInstance'
          property :max_rate, as: 'maxRate'
          property :max_rate_per_instance, as: 'maxRatePerInstance'
          property :max_utilization, as: 'maxUtilization'
        end
      end
      
      class BackendBucket
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bucket_name, as: 'bucketName'
          property :cdn_policy, as: 'cdnPolicy', class: Google::Apis::ComputeAlpha::BackendBucketCdnPolicy, decorator: Google::Apis::ComputeAlpha::BackendBucketCdnPolicy::Representation
      
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :enable_cdn, as: 'enableCdn'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
        end
      end
      
      class BackendBucketCdnPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :signed_url_cache_max_age_sec, :numeric_string => true, as: 'signedUrlCacheMaxAgeSec'
          collection :signed_url_key_names, as: 'signedUrlKeyNames'
        end
      end
      
      class BackendBucketList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::BackendBucket, decorator: Google::Apis::ComputeAlpha::BackendBucket::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::BackendBucketList::Warning, decorator: Google::Apis::ComputeAlpha::BackendBucketList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::BackendBucketList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::BackendBucketList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class BackendService
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :affinity_cookie_ttl_sec, as: 'affinityCookieTtlSec'
          collection :backends, as: 'backends', class: Google::Apis::ComputeAlpha::Backend, decorator: Google::Apis::ComputeAlpha::Backend::Representation
      
          property :cdn_policy, as: 'cdnPolicy', class: Google::Apis::ComputeAlpha::BackendServiceCdnPolicy, decorator: Google::Apis::ComputeAlpha::BackendServiceCdnPolicy::Representation
      
          property :connection_draining, as: 'connectionDraining', class: Google::Apis::ComputeAlpha::ConnectionDraining, decorator: Google::Apis::ComputeAlpha::ConnectionDraining::Representation
      
          property :creation_timestamp, as: 'creationTimestamp'
          collection :custom_request_headers, as: 'customRequestHeaders'
          property :description, as: 'description'
          property :enable_cdn, as: 'enableCDN'
          property :failover_ratio, as: 'failoverRatio'
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :health_checks, as: 'healthChecks'
          property :iap, as: 'iap', class: Google::Apis::ComputeAlpha::BackendServiceIap, decorator: Google::Apis::ComputeAlpha::BackendServiceIap::Representation
      
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :load_balancing_scheme, as: 'loadBalancingScheme'
          property :name, as: 'name'
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :protocol, as: 'protocol'
          property :region, as: 'region'
          property :security_policy, as: 'securityPolicy'
          property :self_link, as: 'selfLink'
          property :session_affinity, as: 'sessionAffinity'
          property :timeout_sec, as: 'timeoutSec'
        end
      end
      
      class BackendServiceAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::BackendServicesScopedList, decorator: Google::Apis::ComputeAlpha::BackendServicesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::BackendServiceAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::BackendServiceAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::BackendServiceAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::BackendServiceAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class BackendServiceCdnPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cache_key_policy, as: 'cacheKeyPolicy', class: Google::Apis::ComputeAlpha::CacheKeyPolicy, decorator: Google::Apis::ComputeAlpha::CacheKeyPolicy::Representation
      
          property :signed_url_cache_max_age_sec, :numeric_string => true, as: 'signedUrlCacheMaxAgeSec'
          collection :signed_url_key_names, as: 'signedUrlKeyNames'
        end
      end
      
      class BackendServiceGroupHealth
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :health_status, as: 'healthStatus', class: Google::Apis::ComputeAlpha::HealthStatus, decorator: Google::Apis::ComputeAlpha::HealthStatus::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class BackendServiceIap
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :enabled, as: 'enabled'
          property :oauth2_client_id, as: 'oauth2ClientId'
          property :oauth2_client_secret, as: 'oauth2ClientSecret'
          property :oauth2_client_secret_sha256, as: 'oauth2ClientSecretSha256'
        end
      end
      
      class BackendServiceList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::BackendService, decorator: Google::Apis::ComputeAlpha::BackendService::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::BackendServiceList::Warning, decorator: Google::Apis::ComputeAlpha::BackendServiceList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::BackendServiceList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::BackendServiceList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class BackendServiceReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :backend_service, as: 'backendService'
        end
      end
      
      class BackendServicesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :backend_services, as: 'backendServices', class: Google::Apis::ComputeAlpha::BackendService, decorator: Google::Apis::ComputeAlpha::BackendService::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::BackendServicesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::BackendServicesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::BackendServicesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::BackendServicesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Binding
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :condition, as: 'condition', class: Google::Apis::ComputeAlpha::Expr, decorator: Google::Apis::ComputeAlpha::Expr::Representation
      
          collection :members, as: 'members'
          property :role, as: 'role'
        end
      end
      
      class CacheInvalidationRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :host, as: 'host'
          property :path, as: 'path'
        end
      end
      
      class CacheKeyPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :include_host, as: 'includeHost'
          property :include_protocol, as: 'includeProtocol'
          property :include_query_string, as: 'includeQueryString'
          collection :query_string_blacklist, as: 'queryStringBlacklist'
          collection :query_string_whitelist, as: 'queryStringWhitelist'
        end
      end
      
      class Commitment
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :end_timestamp, as: 'endTimestamp'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :plan, as: 'plan'
          property :region, as: 'region'
          collection :resources, as: 'resources', class: Google::Apis::ComputeAlpha::ResourceCommitment, decorator: Google::Apis::ComputeAlpha::ResourceCommitment::Representation
      
          property :self_link, as: 'selfLink'
          property :start_timestamp, as: 'startTimestamp'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
        end
      end
      
      class CommitmentAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::CommitmentsScopedList, decorator: Google::Apis::ComputeAlpha::CommitmentsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::CommitmentAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::CommitmentAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::CommitmentAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::CommitmentAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class CommitmentList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Commitment, decorator: Google::Apis::ComputeAlpha::Commitment::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::CommitmentList::Warning, decorator: Google::Apis::ComputeAlpha::CommitmentList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::CommitmentList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::CommitmentList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class CommitmentsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :commitments, as: 'commitments', class: Google::Apis::ComputeAlpha::Commitment, decorator: Google::Apis::ComputeAlpha::Commitment::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::CommitmentsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::CommitmentsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::CommitmentsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::CommitmentsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Condition
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :iam, as: 'iam'
          property :op, as: 'op'
          property :svc, as: 'svc'
          property :sys, as: 'sys'
          property :value, as: 'value'
          collection :values, as: 'values'
        end
      end
      
      class ConnectionDraining
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :draining_timeout_sec, as: 'drainingTimeoutSec'
        end
      end
      
      class CustomerEncryptionKey
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kms_key_name, as: 'kmsKeyName'
          property :raw_key, as: 'rawKey'
          property :rsa_encrypted_key, as: 'rsaEncryptedKey'
          property :sha256, as: 'sha256'
        end
      end
      
      class CustomerEncryptionKeyProtectedDisk
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :disk_encryption_key, as: 'diskEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source, as: 'source'
        end
      end
      
      class DeprecationStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :deleted, as: 'deleted'
          property :deprecated, as: 'deprecated'
          property :obsolete, as: 'obsolete'
          property :replacement, as: 'replacement'
          property :state, as: 'state'
        end
      end
      
      class Disk
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :disk_encryption_key, as: 'diskEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          property :last_attach_timestamp, as: 'lastAttachTimestamp'
          property :last_detach_timestamp, as: 'lastDetachTimestamp'
          collection :license_codes, as: 'licenseCodes'
          collection :licenses, as: 'licenses'
          property :name, as: 'name'
          property :options, as: 'options'
          property :physical_block_size_bytes, :numeric_string => true, as: 'physicalBlockSizeBytes'
          property :region, as: 'region'
          collection :replica_zones, as: 'replicaZones'
          property :self_link, as: 'selfLink'
          property :size_gb, :numeric_string => true, as: 'sizeGb'
          property :source_image, as: 'sourceImage'
          property :source_image_encryption_key, as: 'sourceImageEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source_image_id, as: 'sourceImageId'
          property :source_snapshot, as: 'sourceSnapshot'
          property :source_snapshot_encryption_key, as: 'sourceSnapshotEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source_snapshot_id, as: 'sourceSnapshotId'
          property :status, as: 'status'
          property :storage_type, as: 'storageType'
          property :type, as: 'type'
          collection :users, as: 'users'
          property :zone, as: 'zone'
        end
      end
      
      class DiskAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::DisksScopedList, decorator: Google::Apis::ComputeAlpha::DisksScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::DiskAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::DiskAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::DiskAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::DiskAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class DiskList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Disk, decorator: Google::Apis::ComputeAlpha::Disk::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::DiskList::Warning, decorator: Google::Apis::ComputeAlpha::DiskList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::DiskList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::DiskList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class DiskMoveRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :destination_zone, as: 'destinationZone'
          property :target_disk, as: 'targetDisk'
        end
      end
      
      class DiskType
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :default_disk_size_gb, :numeric_string => true, as: 'defaultDiskSizeGb'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :valid_disk_size, as: 'validDiskSize'
          property :zone, as: 'zone'
        end
      end
      
      class DiskTypeAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::DiskTypesScopedList, decorator: Google::Apis::ComputeAlpha::DiskTypesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::DiskTypeAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::DiskTypeAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::DiskTypeAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::DiskTypeAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class DiskTypeList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::DiskType, decorator: Google::Apis::ComputeAlpha::DiskType::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::DiskTypeList::Warning, decorator: Google::Apis::ComputeAlpha::DiskTypeList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::DiskTypeList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::DiskTypeList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class DiskTypesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :disk_types, as: 'diskTypes', class: Google::Apis::ComputeAlpha::DiskType, decorator: Google::Apis::ComputeAlpha::DiskType::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::DiskTypesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::DiskTypesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::DiskTypesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::DiskTypesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class DisksResizeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :size_gb, :numeric_string => true, as: 'sizeGb'
        end
      end
      
      class DisksScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :disks, as: 'disks', class: Google::Apis::ComputeAlpha::Disk, decorator: Google::Apis::ComputeAlpha::Disk::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::DisksScopedList::Warning, decorator: Google::Apis::ComputeAlpha::DisksScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::DisksScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::DisksScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class DistributionPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :zones, as: 'zones', class: Google::Apis::ComputeAlpha::DistributionPolicyZoneConfiguration, decorator: Google::Apis::ComputeAlpha::DistributionPolicyZoneConfiguration::Representation
      
        end
      end
      
      class DistributionPolicyZoneConfiguration
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :zone, as: 'zone'
        end
      end
      
      class Expr
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          property :expression, as: 'expression'
          property :location, as: 'location'
          property :title, as: 'title'
        end
      end
      
      class Firewall
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :allowed, as: 'allowed', class: Google::Apis::ComputeAlpha::Firewall::Allowed, decorator: Google::Apis::ComputeAlpha::Firewall::Allowed::Representation
      
          property :creation_timestamp, as: 'creationTimestamp'
          collection :denied, as: 'denied', class: Google::Apis::ComputeAlpha::Firewall::Denied, decorator: Google::Apis::ComputeAlpha::Firewall::Denied::Representation
      
          property :description, as: 'description'
          collection :destination_ranges, as: 'destinationRanges'
          property :direction, as: 'direction'
          property :enable_logging, as: 'enableLogging'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :network, as: 'network'
          property :priority, as: 'priority'
          property :self_link, as: 'selfLink'
          collection :source_ranges, as: 'sourceRanges'
          collection :source_service_accounts, as: 'sourceServiceAccounts'
          collection :source_tags, as: 'sourceTags'
          collection :target_service_accounts, as: 'targetServiceAccounts'
          collection :target_tags, as: 'targetTags'
        end
        
        class Allowed
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :ip_protocol, as: 'IPProtocol'
            collection :ports, as: 'ports'
          end
        end
        
        class Denied
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :ip_protocol, as: 'IPProtocol'
            collection :ports, as: 'ports'
          end
        end
      end
      
      class FirewallList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Firewall, decorator: Google::Apis::ComputeAlpha::Firewall::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::FirewallList::Warning, decorator: Google::Apis::ComputeAlpha::FirewallList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::FirewallList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::FirewallList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class FixedOrPercent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :calculated, as: 'calculated'
          property :fixed, as: 'fixed'
          property :percent, as: 'percent'
        end
      end
      
      class ForwardingRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :ip_address, as: 'IPAddress'
          property :ip_protocol, as: 'IPProtocol'
          property :backend_service, as: 'backendService'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :ip_version, as: 'ipVersion'
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          property :load_balancing_scheme, as: 'loadBalancingScheme'
          property :name, as: 'name'
          property :network, as: 'network'
          property :network_tier, as: 'networkTier'
          property :port_range, as: 'portRange'
          collection :ports, as: 'ports'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :service_label, as: 'serviceLabel'
          property :service_name, as: 'serviceName'
          property :subnetwork, as: 'subnetwork'
          property :target, as: 'target'
        end
      end
      
      class ForwardingRuleAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::ForwardingRulesScopedList, decorator: Google::Apis::ComputeAlpha::ForwardingRulesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::ForwardingRuleAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::ForwardingRuleAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::ForwardingRuleAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::ForwardingRuleAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class ForwardingRuleList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::ForwardingRule, decorator: Google::Apis::ComputeAlpha::ForwardingRule::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::ForwardingRuleList::Warning, decorator: Google::Apis::ComputeAlpha::ForwardingRuleList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::ForwardingRuleList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::ForwardingRuleList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class ForwardingRuleReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :forwarding_rule, as: 'forwardingRule'
        end
      end
      
      class ForwardingRulesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :forwarding_rules, as: 'forwardingRules', class: Google::Apis::ComputeAlpha::ForwardingRule, decorator: Google::Apis::ComputeAlpha::ForwardingRule::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::ForwardingRulesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::ForwardingRulesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::ForwardingRulesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::ForwardingRulesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class GlobalSetLabelsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
        end
      end
      
      class GuestAttributes
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :self_link, as: 'selfLink'
          property :variable_key, as: 'variableKey'
          property :variable_value, as: 'variableValue'
        end
      end
      
      class GuestOsFeature
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :type, as: 'type'
        end
      end
      
      class Http2HealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :host, as: 'host'
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :proxy_header, as: 'proxyHeader'
          property :request_path, as: 'requestPath'
          property :response, as: 'response'
        end
      end
      
      class HttpHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :host, as: 'host'
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :proxy_header, as: 'proxyHeader'
          property :request_path, as: 'requestPath'
          property :response, as: 'response'
        end
      end
      
      class HttpsHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :host, as: 'host'
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :proxy_header, as: 'proxyHeader'
          property :request_path, as: 'requestPath'
          property :response, as: 'response'
        end
      end
      
      class HealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :check_interval_sec, as: 'checkIntervalSec'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :healthy_threshold, as: 'healthyThreshold'
          property :http2_health_check, as: 'http2HealthCheck', class: Google::Apis::ComputeAlpha::Http2HealthCheck, decorator: Google::Apis::ComputeAlpha::Http2HealthCheck::Representation
      
          property :http_health_check, as: 'httpHealthCheck', class: Google::Apis::ComputeAlpha::HttpHealthCheck, decorator: Google::Apis::ComputeAlpha::HttpHealthCheck::Representation
      
          property :https_health_check, as: 'httpsHealthCheck', class: Google::Apis::ComputeAlpha::HttpsHealthCheck, decorator: Google::Apis::ComputeAlpha::HttpsHealthCheck::Representation
      
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :ssl_health_check, as: 'sslHealthCheck', class: Google::Apis::ComputeAlpha::SslHealthCheck, decorator: Google::Apis::ComputeAlpha::SslHealthCheck::Representation
      
          property :tcp_health_check, as: 'tcpHealthCheck', class: Google::Apis::ComputeAlpha::TcpHealthCheck, decorator: Google::Apis::ComputeAlpha::TcpHealthCheck::Representation
      
          property :timeout_sec, as: 'timeoutSec'
          property :type, as: 'type'
          property :udp_health_check, as: 'udpHealthCheck', class: Google::Apis::ComputeAlpha::UdpHealthCheck, decorator: Google::Apis::ComputeAlpha::UdpHealthCheck::Representation
      
          property :unhealthy_threshold, as: 'unhealthyThreshold'
        end
      end
      
      class HealthCheckList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::HealthCheck, decorator: Google::Apis::ComputeAlpha::HealthCheck::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HealthCheckList::Warning, decorator: Google::Apis::ComputeAlpha::HealthCheckList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HealthCheckList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HealthCheckList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HealthCheckReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :health_check, as: 'healthCheck'
        end
      end
      
      class HealthStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :health_state, as: 'healthState'
          property :instance, as: 'instance'
          property :ip_address, as: 'ipAddress'
          property :port, as: 'port'
        end
      end
      
      class HealthStatusForNetworkEndpoint
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :backend_service, as: 'backendService', class: Google::Apis::ComputeAlpha::BackendServiceReference, decorator: Google::Apis::ComputeAlpha::BackendServiceReference::Representation
      
          property :forwarding_rule, as: 'forwardingRule', class: Google::Apis::ComputeAlpha::ForwardingRuleReference, decorator: Google::Apis::ComputeAlpha::ForwardingRuleReference::Representation
      
          property :health_check, as: 'healthCheck', class: Google::Apis::ComputeAlpha::HealthCheckReference, decorator: Google::Apis::ComputeAlpha::HealthCheckReference::Representation
      
          property :health_state, as: 'healthState'
        end
      end
      
      class Host
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :host_type, as: 'hostType'
          property :id, :numeric_string => true, as: 'id'
          collection :instances, as: 'instances'
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
          property :zone, as: 'zone'
        end
      end
      
      class HostAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::HostsScopedList, decorator: Google::Apis::ComputeAlpha::HostsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HostAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::HostAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HostAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HostAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HostList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Host, decorator: Google::Apis::ComputeAlpha::Host::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HostList::Warning, decorator: Google::Apis::ComputeAlpha::HostList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HostList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HostList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HostRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          collection :hosts, as: 'hosts'
          property :path_matcher, as: 'pathMatcher'
        end
      end
      
      class HostType
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cpu_platform, as: 'cpuPlatform'
          property :creation_timestamp, as: 'creationTimestamp'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :guest_cpus, as: 'guestCpus'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :local_ssd_gb, as: 'localSsdGb'
          property :memory_mb, as: 'memoryMb'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :zone, as: 'zone'
        end
      end
      
      class HostTypeAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::HostTypesScopedList, decorator: Google::Apis::ComputeAlpha::HostTypesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HostTypeAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::HostTypeAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HostTypeAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HostTypeAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HostTypeList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::HostType, decorator: Google::Apis::ComputeAlpha::HostType::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HostTypeList::Warning, decorator: Google::Apis::ComputeAlpha::HostTypeList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HostTypeList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HostTypeList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HostTypesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :host_types, as: 'hostTypes', class: Google::Apis::ComputeAlpha::HostType, decorator: Google::Apis::ComputeAlpha::HostType::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HostTypesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::HostTypesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HostTypesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HostTypesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HostsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :hosts, as: 'hosts', class: Google::Apis::ComputeAlpha::Host, decorator: Google::Apis::ComputeAlpha::Host::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HostsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::HostsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HostsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HostsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HttpHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :check_interval_sec, as: 'checkIntervalSec'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :healthy_threshold, as: 'healthyThreshold'
          property :host, as: 'host'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :port, as: 'port'
          property :request_path, as: 'requestPath'
          property :self_link, as: 'selfLink'
          property :timeout_sec, as: 'timeoutSec'
          property :unhealthy_threshold, as: 'unhealthyThreshold'
        end
      end
      
      class HttpHealthCheckList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::HttpHealthCheck, decorator: Google::Apis::ComputeAlpha::HttpHealthCheck::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HttpHealthCheckList::Warning, decorator: Google::Apis::ComputeAlpha::HttpHealthCheckList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HttpHealthCheckList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HttpHealthCheckList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class HttpsHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :check_interval_sec, as: 'checkIntervalSec'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :healthy_threshold, as: 'healthyThreshold'
          property :host, as: 'host'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :port, as: 'port'
          property :request_path, as: 'requestPath'
          property :self_link, as: 'selfLink'
          property :timeout_sec, as: 'timeoutSec'
          property :unhealthy_threshold, as: 'unhealthyThreshold'
        end
      end
      
      class HttpsHealthCheckList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::HttpsHealthCheck, decorator: Google::Apis::ComputeAlpha::HttpsHealthCheck::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::HttpsHealthCheckList::Warning, decorator: Google::Apis::ComputeAlpha::HttpsHealthCheckList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::HttpsHealthCheckList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::HttpsHealthCheckList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Image
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :archive_size_bytes, :numeric_string => true, as: 'archiveSizeBytes'
          property :creation_timestamp, as: 'creationTimestamp'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :disk_size_gb, :numeric_string => true, as: 'diskSizeGb'
          property :family, as: 'family'
          collection :guest_os_features, as: 'guestOsFeatures', class: Google::Apis::ComputeAlpha::GuestOsFeature, decorator: Google::Apis::ComputeAlpha::GuestOsFeature::Representation
      
          property :id, :numeric_string => true, as: 'id'
          property :image_encryption_key, as: 'imageEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          collection :license_codes, as: 'licenseCodes'
          collection :licenses, as: 'licenses'
          property :name, as: 'name'
          property :raw_disk, as: 'rawDisk', class: Google::Apis::ComputeAlpha::Image::RawDisk, decorator: Google::Apis::ComputeAlpha::Image::RawDisk::Representation
      
          property :self_link, as: 'selfLink'
          property :source_disk, as: 'sourceDisk'
          property :source_disk_encryption_key, as: 'sourceDiskEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source_disk_id, as: 'sourceDiskId'
          property :source_image, as: 'sourceImage'
          property :source_image_encryption_key, as: 'sourceImageEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source_image_id, as: 'sourceImageId'
          property :source_type, as: 'sourceType'
          property :status, as: 'status'
        end
        
        class RawDisk
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :container_type, as: 'containerType'
            property :sha1_checksum, as: 'sha1Checksum'
            property :source, as: 'source'
          end
        end
      end
      
      class ImageList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Image, decorator: Google::Apis::ComputeAlpha::Image::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::ImageList::Warning, decorator: Google::Apis::ComputeAlpha::ImageList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::ImageList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::ImageList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Instance
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :can_ip_forward, as: 'canIpForward'
          property :cpu_platform, as: 'cpuPlatform'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          collection :disks, as: 'disks', class: Google::Apis::ComputeAlpha::AttachedDisk, decorator: Google::Apis::ComputeAlpha::AttachedDisk::Representation
      
          collection :guest_accelerators, as: 'guestAccelerators', class: Google::Apis::ComputeAlpha::AcceleratorConfig, decorator: Google::Apis::ComputeAlpha::AcceleratorConfig::Representation
      
          property :host, as: 'host'
          property :id, :numeric_string => true, as: 'id'
          property :instance_encryption_key, as: 'instanceEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          property :machine_type, as: 'machineType'
          property :metadata, as: 'metadata', class: Google::Apis::ComputeAlpha::Metadata, decorator: Google::Apis::ComputeAlpha::Metadata::Representation
      
          property :min_cpu_platform, as: 'minCpuPlatform'
          property :name, as: 'name'
          collection :network_interfaces, as: 'networkInterfaces', class: Google::Apis::ComputeAlpha::NetworkInterface, decorator: Google::Apis::ComputeAlpha::NetworkInterface::Representation
      
          property :scheduling, as: 'scheduling', class: Google::Apis::ComputeAlpha::Scheduling, decorator: Google::Apis::ComputeAlpha::Scheduling::Representation
      
          property :self_link, as: 'selfLink'
          collection :service_accounts, as: 'serviceAccounts', class: Google::Apis::ComputeAlpha::ServiceAccount, decorator: Google::Apis::ComputeAlpha::ServiceAccount::Representation
      
          property :start_restricted, as: 'startRestricted'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
          property :tags, as: 'tags', class: Google::Apis::ComputeAlpha::Tags, decorator: Google::Apis::ComputeAlpha::Tags::Representation
      
          property :zone, as: 'zone'
        end
      end
      
      class InstanceAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::InstancesScopedList, decorator: Google::Apis::ComputeAlpha::InstancesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroup
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :fingerprint, :base64 => true, as: 'fingerprint'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :named_ports, as: 'namedPorts', class: Google::Apis::ComputeAlpha::NamedPort, decorator: Google::Apis::ComputeAlpha::NamedPort::Representation
      
          property :network, as: 'network'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :size, as: 'size'
          property :subnetwork, as: 'subnetwork'
          property :zone, as: 'zone'
        end
      end
      
      class InstanceGroupAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceGroupsScopedList, decorator: Google::Apis::ComputeAlpha::InstanceGroupsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceGroup, decorator: Google::Apis::ComputeAlpha::InstanceGroup::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupManager
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :activities, as: 'activities', class: Google::Apis::ComputeAlpha::InstanceGroupManagerActivities, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerActivities::Representation
      
          collection :auto_healing_policies, as: 'autoHealingPolicies', class: Google::Apis::ComputeAlpha::InstanceGroupManagerAutoHealingPolicy, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerAutoHealingPolicy::Representation
      
          property :base_instance_name, as: 'baseInstanceName'
          property :creation_timestamp, as: 'creationTimestamp'
          property :current_actions, as: 'currentActions', class: Google::Apis::ComputeAlpha::InstanceGroupManagerActionsSummary, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerActionsSummary::Representation
      
          property :description, as: 'description'
          property :distribution_policy, as: 'distributionPolicy', class: Google::Apis::ComputeAlpha::DistributionPolicy, decorator: Google::Apis::ComputeAlpha::DistributionPolicy::Representation
      
          property :failover_action, as: 'failoverAction'
          property :fingerprint, :base64 => true, as: 'fingerprint'
          property :id, :numeric_string => true, as: 'id'
          property :instance_group, as: 'instanceGroup'
          property :instance_template, as: 'instanceTemplate'
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :named_ports, as: 'namedPorts', class: Google::Apis::ComputeAlpha::NamedPort, decorator: Google::Apis::ComputeAlpha::NamedPort::Representation
      
          property :pending_actions, as: 'pendingActions', class: Google::Apis::ComputeAlpha::InstanceGroupManagerPendingActionsSummary, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerPendingActionsSummary::Representation
      
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :service_account, as: 'serviceAccount'
          property :stateful_policy, as: 'statefulPolicy', class: Google::Apis::ComputeAlpha::InstanceGroupManagerStatefulPolicy, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerStatefulPolicy::Representation
      
          collection :target_pools, as: 'targetPools'
          property :target_size, as: 'targetSize'
          property :update_policy, as: 'updatePolicy', class: Google::Apis::ComputeAlpha::InstanceGroupManagerUpdatePolicy, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerUpdatePolicy::Representation
      
          collection :versions, as: 'versions', class: Google::Apis::ComputeAlpha::InstanceGroupManagerVersion, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerVersion::Representation
      
          property :zone, as: 'zone'
        end
      end
      
      class InstanceGroupManagerActionsSummary
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :abandoning, as: 'abandoning'
          property :creating, as: 'creating'
          property :creating_without_retries, as: 'creatingWithoutRetries'
          property :deleting, as: 'deleting'
          property :none, as: 'none'
          property :recreating, as: 'recreating'
          property :refreshing, as: 'refreshing'
          property :restarting, as: 'restarting'
          property :verifying, as: 'verifying'
        end
      end
      
      class InstanceGroupManagerActivities
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :autohealing, as: 'autohealing'
          property :autohealing_health_check_based, as: 'autohealingHealthCheckBased'
          property :autoscaling_down, as: 'autoscalingDown'
          property :autoscaling_up, as: 'autoscalingUp'
          property :creating_instances, as: 'creatingInstances'
          property :deleting_instances, as: 'deletingInstances'
          property :recreating_instances, as: 'recreatingInstances'
        end
      end
      
      class InstanceGroupManagerAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceGroupManagersScopedList, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagersScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupManagerAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupManagerAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupManagerAutoHealingPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :health_check, as: 'healthCheck'
          property :initial_delay_sec, as: 'initialDelaySec'
          property :max_unavailable, as: 'maxUnavailable', class: Google::Apis::ComputeAlpha::FixedOrPercent, decorator: Google::Apis::ComputeAlpha::FixedOrPercent::Representation
      
        end
      end
      
      class InstanceGroupManagerList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceGroupManager, decorator: Google::Apis::ComputeAlpha::InstanceGroupManager::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupManagerList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupManagerList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupManagerPendingActionsSummary
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creating, as: 'creating'
          property :deleting, as: 'deleting'
          property :recreating, as: 'recreating'
          property :restarting, as: 'restarting'
        end
      end
      
      class InstanceGroupManagerStatefulPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :preserved_disks, as: 'preservedDisks', class: Google::Apis::ComputeAlpha::InstanceGroupManagerStatefulPolicyDiskPolicy, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerStatefulPolicyDiskPolicy::Representation
      
        end
      end
      
      class InstanceGroupManagerStatefulPolicyDiskPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :device_name, as: 'deviceName'
        end
      end
      
      class InstanceGroupManagerUpdatePolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :max_surge, as: 'maxSurge', class: Google::Apis::ComputeAlpha::FixedOrPercent, decorator: Google::Apis::ComputeAlpha::FixedOrPercent::Representation
      
          property :max_unavailable, as: 'maxUnavailable', class: Google::Apis::ComputeAlpha::FixedOrPercent, decorator: Google::Apis::ComputeAlpha::FixedOrPercent::Representation
      
          property :min_ready_sec, as: 'minReadySec'
          property :minimal_action, as: 'minimalAction'
          property :type, as: 'type'
        end
      end
      
      class InstanceGroupManagerVersion
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_template, as: 'instanceTemplate'
          property :name, as: 'name'
          property :tag, as: 'tag'
          property :target_size, as: 'targetSize', class: Google::Apis::ComputeAlpha::FixedOrPercent, decorator: Google::Apis::ComputeAlpha::FixedOrPercent::Representation
      
        end
      end
      
      class InstanceGroupManagersAbandonInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class InstanceGroupManagersApplyUpdatesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
          property :maximal_action, as: 'maximalAction'
          property :minimal_action, as: 'minimalAction'
        end
      end
      
      class InstanceGroupManagersDeleteInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class InstanceGroupManagersDeletePerInstanceConfigsReq
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class InstanceGroupManagersListManagedInstancesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :managed_instances, as: 'managedInstances', class: Google::Apis::ComputeAlpha::ManagedInstance, decorator: Google::Apis::ComputeAlpha::ManagedInstance::Representation
      
          property :next_page_token, as: 'nextPageToken'
        end
      end
      
      class InstanceGroupManagersListPerInstanceConfigsResp
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::PerInstanceConfig, decorator: Google::Apis::ComputeAlpha::PerInstanceConfig::Representation
      
          property :next_page_token, as: 'nextPageToken'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupManagersListPerInstanceConfigsResp::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagersListPerInstanceConfigsResp::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupManagersListPerInstanceConfigsResp::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagersListPerInstanceConfigsResp::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupManagersRecreateInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class InstanceGroupManagersResizeAdvancedRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :no_creation_retries, as: 'noCreationRetries'
          property :target_size, as: 'targetSize'
        end
      end
      
      class InstanceGroupManagersScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instance_group_managers, as: 'instanceGroupManagers', class: Google::Apis::ComputeAlpha::InstanceGroupManager, decorator: Google::Apis::ComputeAlpha::InstanceGroupManager::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupManagersScopedList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagersScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupManagersScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagersScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupManagersSetAutoHealingRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :auto_healing_policies, as: 'autoHealingPolicies', class: Google::Apis::ComputeAlpha::InstanceGroupManagerAutoHealingPolicy, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerAutoHealingPolicy::Representation
      
        end
      end
      
      class InstanceGroupManagersSetInstanceTemplateRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_template, as: 'instanceTemplate'
        end
      end
      
      class InstanceGroupManagersSetTargetPoolsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :target_pools, as: 'targetPools'
        end
      end
      
      class InstanceGroupManagersUpdatePerInstanceConfigsReq
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :per_instance_configs, as: 'perInstanceConfigs', class: Google::Apis::ComputeAlpha::PerInstanceConfig, decorator: Google::Apis::ComputeAlpha::PerInstanceConfig::Representation
      
        end
      end
      
      class InstanceGroupsAddInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances', class: Google::Apis::ComputeAlpha::InstanceReference, decorator: Google::Apis::ComputeAlpha::InstanceReference::Representation
      
        end
      end
      
      class InstanceGroupsListInstances
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceWithNamedPorts, decorator: Google::Apis::ComputeAlpha::InstanceWithNamedPorts::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupsListInstances::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupsListInstances::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupsListInstances::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupsListInstances::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupsListInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_state, as: 'instanceState'
        end
      end
      
      class InstanceGroupsRemoveInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances', class: Google::Apis::ComputeAlpha::InstanceReference, decorator: Google::Apis::ComputeAlpha::InstanceReference::Representation
      
        end
      end
      
      class InstanceGroupsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instance_groups, as: 'instanceGroups', class: Google::Apis::ComputeAlpha::InstanceGroup, decorator: Google::Apis::ComputeAlpha::InstanceGroup::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceGroupsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceGroupsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceGroupsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceGroupsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceGroupsSetNamedPortsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :named_ports, as: 'namedPorts', class: Google::Apis::ComputeAlpha::NamedPort, decorator: Google::Apis::ComputeAlpha::NamedPort::Representation
      
        end
      end
      
      class InstanceList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Instance, decorator: Google::Apis::ComputeAlpha::Instance::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceListReferrers
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Reference, decorator: Google::Apis::ComputeAlpha::Reference::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceListReferrers::Warning, decorator: Google::Apis::ComputeAlpha::InstanceListReferrers::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceListReferrers::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceListReferrers::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceMoveRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :destination_zone, as: 'destinationZone'
          property :target_instance, as: 'targetInstance'
        end
      end
      
      class InstanceProperties
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :can_ip_forward, as: 'canIpForward'
          property :description, as: 'description'
          collection :disks, as: 'disks', class: Google::Apis::ComputeAlpha::AttachedDisk, decorator: Google::Apis::ComputeAlpha::AttachedDisk::Representation
      
          collection :guest_accelerators, as: 'guestAccelerators', class: Google::Apis::ComputeAlpha::AcceleratorConfig, decorator: Google::Apis::ComputeAlpha::AcceleratorConfig::Representation
      
          hash :labels, as: 'labels'
          property :machine_type, as: 'machineType'
          property :metadata, as: 'metadata', class: Google::Apis::ComputeAlpha::Metadata, decorator: Google::Apis::ComputeAlpha::Metadata::Representation
      
          property :min_cpu_platform, as: 'minCpuPlatform'
          collection :network_interfaces, as: 'networkInterfaces', class: Google::Apis::ComputeAlpha::NetworkInterface, decorator: Google::Apis::ComputeAlpha::NetworkInterface::Representation
      
          property :scheduling, as: 'scheduling', class: Google::Apis::ComputeAlpha::Scheduling, decorator: Google::Apis::ComputeAlpha::Scheduling::Representation
      
          collection :service_accounts, as: 'serviceAccounts', class: Google::Apis::ComputeAlpha::ServiceAccount, decorator: Google::Apis::ComputeAlpha::ServiceAccount::Representation
      
          property :tags, as: 'tags', class: Google::Apis::ComputeAlpha::Tags, decorator: Google::Apis::ComputeAlpha::Tags::Representation
      
        end
      end
      
      class InstanceReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance, as: 'instance'
        end
      end
      
      class InstanceTemplate
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :properties, as: 'properties', class: Google::Apis::ComputeAlpha::InstanceProperties, decorator: Google::Apis::ComputeAlpha::InstanceProperties::Representation
      
          property :self_link, as: 'selfLink'
          property :source_instance, as: 'sourceInstance'
        end
      end
      
      class InstanceTemplateList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceTemplate, decorator: Google::Apis::ComputeAlpha::InstanceTemplate::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstanceTemplateList::Warning, decorator: Google::Apis::ComputeAlpha::InstanceTemplateList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstanceTemplateList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstanceTemplateList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstanceWithNamedPorts
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance, as: 'instance'
          collection :named_ports, as: 'namedPorts', class: Google::Apis::ComputeAlpha::NamedPort, decorator: Google::Apis::ComputeAlpha::NamedPort::Representation
      
          property :status, as: 'status'
        end
      end
      
      class InstancesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances', class: Google::Apis::ComputeAlpha::Instance, decorator: Google::Apis::ComputeAlpha::Instance::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InstancesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::InstancesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InstancesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InstancesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InstancesSetLabelsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
        end
      end
      
      class InstancesSetMachineResourcesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :guest_accelerators, as: 'guestAccelerators', class: Google::Apis::ComputeAlpha::AcceleratorConfig, decorator: Google::Apis::ComputeAlpha::AcceleratorConfig::Representation
      
        end
      end
      
      class InstancesSetMachineTypeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :machine_type, as: 'machineType'
        end
      end
      
      class InstancesSetMinCpuPlatformRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :min_cpu_platform, as: 'minCpuPlatform'
        end
      end
      
      class InstancesSetServiceAccountRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :email, as: 'email'
          collection :scopes, as: 'scopes'
        end
      end
      
      class InstancesStartWithEncryptionKeyRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :disks, as: 'disks', class: Google::Apis::ComputeAlpha::CustomerEncryptionKeyProtectedDisk, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKeyProtectedDisk::Representation
      
          property :instance_encryption_key, as: 'instanceEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
        end
      end
      
      class Interconnect
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :admin_enabled, as: 'adminEnabled'
          collection :circuit_infos, as: 'circuitInfos', class: Google::Apis::ComputeAlpha::InterconnectCircuitInfo, decorator: Google::Apis::ComputeAlpha::InterconnectCircuitInfo::Representation
      
          property :connection_authorization, as: 'connectionAuthorization'
          property :creation_timestamp, as: 'creationTimestamp'
          property :customer_name, as: 'customerName'
          property :description, as: 'description'
          collection :expected_outages, as: 'expectedOutages', class: Google::Apis::ComputeAlpha::InterconnectOutageNotification, decorator: Google::Apis::ComputeAlpha::InterconnectOutageNotification::Representation
      
          property :google_ip_address, as: 'googleIpAddress'
          property :google_reference_id, as: 'googleReferenceId'
          property :id, :numeric_string => true, as: 'id'
          collection :interconnect_attachments, as: 'interconnectAttachments'
          property :interconnect_type, as: 'interconnectType'
          property :kind, as: 'kind'
          property :link_type, as: 'linkType'
          property :location, as: 'location'
          property :name, as: 'name'
          property :noc_contact_email, as: 'nocContactEmail'
          property :operational_status, as: 'operationalStatus'
          property :peer_ip_address, as: 'peerIpAddress'
          property :provisioned_link_count, as: 'provisionedLinkCount'
          property :requested_link_count, as: 'requestedLinkCount'
          property :self_link, as: 'selfLink'
        end
      end
      
      class InterconnectAttachment
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cloud_router_ip_address, as: 'cloudRouterIpAddress'
          property :creation_timestamp, as: 'creationTimestamp'
          property :customer_router_ip_address, as: 'customerRouterIpAddress'
          property :description, as: 'description'
          property :google_reference_id, as: 'googleReferenceId'
          property :id, :numeric_string => true, as: 'id'
          property :interconnect, as: 'interconnect'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :operational_status, as: 'operationalStatus'
          property :private_interconnect_info, as: 'privateInterconnectInfo', class: Google::Apis::ComputeAlpha::InterconnectAttachmentPrivateInfo, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentPrivateInfo::Representation
      
          property :region, as: 'region'
          property :router, as: 'router'
          property :self_link, as: 'selfLink'
        end
      end
      
      class InterconnectAttachmentAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::InterconnectAttachmentsScopedList, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InterconnectAttachmentAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InterconnectAttachmentAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InterconnectAttachmentList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InterconnectAttachment, decorator: Google::Apis::ComputeAlpha::InterconnectAttachment::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InterconnectAttachmentList::Warning, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InterconnectAttachmentList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InterconnectAttachmentPrivateInfo
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :tag8021q, as: 'tag8021q'
        end
      end
      
      class InterconnectAttachmentsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :interconnect_attachments, as: 'interconnectAttachments', class: Google::Apis::ComputeAlpha::InterconnectAttachment, decorator: Google::Apis::ComputeAlpha::InterconnectAttachment::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InterconnectAttachmentsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InterconnectAttachmentsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InterconnectAttachmentsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InterconnectCircuitInfo
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :customer_demarc_id, as: 'customerDemarcId'
          property :google_circuit_id, as: 'googleCircuitId'
          property :google_demarc_id, as: 'googleDemarcId'
        end
      end
      
      class InterconnectList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Interconnect, decorator: Google::Apis::ComputeAlpha::Interconnect::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InterconnectList::Warning, decorator: Google::Apis::ComputeAlpha::InterconnectList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InterconnectList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InterconnectList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InterconnectLocation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :address, as: 'address'
          property :availability_zone, as: 'availabilityZone'
          property :city, as: 'city'
          property :continent, as: 'continent'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :facility_provider, as: 'facilityProvider'
          property :facility_provider_facility_id, as: 'facilityProviderFacilityId'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :peeringdb_facility_id, as: 'peeringdbFacilityId'
          collection :region_infos, as: 'regionInfos', class: Google::Apis::ComputeAlpha::InterconnectLocationRegionInfo, decorator: Google::Apis::ComputeAlpha::InterconnectLocationRegionInfo::Representation
      
          property :self_link, as: 'selfLink'
        end
      end
      
      class InterconnectLocationList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InterconnectLocation, decorator: Google::Apis::ComputeAlpha::InterconnectLocation::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::InterconnectLocationList::Warning, decorator: Google::Apis::ComputeAlpha::InterconnectLocationList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::InterconnectLocationList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::InterconnectLocationList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class InterconnectLocationRegionInfo
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :expected_rtt_ms, :numeric_string => true, as: 'expectedRttMs'
          property :location_presence, as: 'locationPresence'
          property :region, as: 'region'
          property :region_key, as: 'regionKey'
        end
      end
      
      class InterconnectOutageNotification
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :affected_circuits, as: 'affectedCircuits'
          property :description, as: 'description'
          property :end_time, :numeric_string => true, as: 'endTime'
          property :issue_type, as: 'issueType'
          property :name, as: 'name'
          property :source, as: 'source'
          property :start_time, :numeric_string => true, as: 'startTime'
          property :state, as: 'state'
        end
      end
      
      class InternalIpOwner
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :ip_cidr_range, as: 'ipCidrRange'
          collection :owners, as: 'owners'
          property :system_owned, as: 'systemOwned'
        end
      end
      
      class IpOwnerList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InternalIpOwner, decorator: Google::Apis::ComputeAlpha::InternalIpOwner::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::IpOwnerList::Warning, decorator: Google::Apis::ComputeAlpha::IpOwnerList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::IpOwnerList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::IpOwnerList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class License
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :charges_use_fee, as: 'chargesUseFee'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :license_code, :numeric_string => true, as: 'licenseCode'
          property :name, as: 'name'
          property :resource_requirements, as: 'resourceRequirements', class: Google::Apis::ComputeAlpha::LicenseResourceRequirements, decorator: Google::Apis::ComputeAlpha::LicenseResourceRequirements::Representation
      
          property :self_link, as: 'selfLink'
          property :transferable, as: 'transferable'
        end
      end
      
      class LicenseCode
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          collection :license_alias, as: 'licenseAlias', class: Google::Apis::ComputeAlpha::LicenseCodeLicenseAlias, decorator: Google::Apis::ComputeAlpha::LicenseCodeLicenseAlias::Representation
      
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :state, as: 'state'
          property :transferable, as: 'transferable'
        end
      end
      
      class LicenseCodeLicenseAlias
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          property :self_link, as: 'selfLink'
        end
      end
      
      class LicenseResourceRequirements
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :min_guest_cpu_count, as: 'minGuestCpuCount'
          property :min_memory_mb, as: 'minMemoryMb'
        end
      end
      
      class LicensesListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::License, decorator: Google::Apis::ComputeAlpha::License::Representation
      
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::LicensesListResponse::Warning, decorator: Google::Apis::ComputeAlpha::LicensesListResponse::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::LicensesListResponse::Warning::Datum, decorator: Google::Apis::ComputeAlpha::LicensesListResponse::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class LogConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cloud_audit, as: 'cloudAudit', class: Google::Apis::ComputeAlpha::LogConfigCloudAuditOptions, decorator: Google::Apis::ComputeAlpha::LogConfigCloudAuditOptions::Representation
      
          property :counter, as: 'counter', class: Google::Apis::ComputeAlpha::LogConfigCounterOptions, decorator: Google::Apis::ComputeAlpha::LogConfigCounterOptions::Representation
      
          property :data_access, as: 'dataAccess', class: Google::Apis::ComputeAlpha::LogConfigDataAccessOptions, decorator: Google::Apis::ComputeAlpha::LogConfigDataAccessOptions::Representation
      
        end
      end
      
      class LogConfigCloudAuditOptions
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :authorization_logging_options, as: 'authorizationLoggingOptions', class: Google::Apis::ComputeAlpha::AuthorizationLoggingOptions, decorator: Google::Apis::ComputeAlpha::AuthorizationLoggingOptions::Representation
      
          property :log_name, as: 'logName'
        end
      end
      
      class LogConfigCounterOptions
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :field, as: 'field'
          property :metric, as: 'metric'
        end
      end
      
      class LogConfigDataAccessOptions
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :log_mode, as: 'logMode'
        end
      end
      
      class MachineType
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :guest_cpus, as: 'guestCpus'
          property :id, :numeric_string => true, as: 'id'
          property :is_shared_cpu, as: 'isSharedCpu'
          property :kind, as: 'kind'
          property :maximum_persistent_disks, as: 'maximumPersistentDisks'
          property :maximum_persistent_disks_size_gb, :numeric_string => true, as: 'maximumPersistentDisksSizeGb'
          property :memory_mb, as: 'memoryMb'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :zone, as: 'zone'
        end
      end
      
      class MachineTypeAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::MachineTypesScopedList, decorator: Google::Apis::ComputeAlpha::MachineTypesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::MachineTypeAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::MachineTypeAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::MachineTypeAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::MachineTypeAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class MachineTypeList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::MachineType, decorator: Google::Apis::ComputeAlpha::MachineType::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::MachineTypeList::Warning, decorator: Google::Apis::ComputeAlpha::MachineTypeList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::MachineTypeList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::MachineTypeList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class MachineTypesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :machine_types, as: 'machineTypes', class: Google::Apis::ComputeAlpha::MachineType, decorator: Google::Apis::ComputeAlpha::MachineType::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::MachineTypesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::MachineTypesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::MachineTypesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::MachineTypesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class ManagedInstance
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :current_action, as: 'currentAction'
          property :id, :numeric_string => true, as: 'id'
          property :instance, as: 'instance'
          property :instance_status, as: 'instanceStatus'
          property :instance_template, as: 'instanceTemplate'
          property :last_attempt, as: 'lastAttempt', class: Google::Apis::ComputeAlpha::ManagedInstanceLastAttempt, decorator: Google::Apis::ComputeAlpha::ManagedInstanceLastAttempt::Representation
      
          property :override, as: 'override', class: Google::Apis::ComputeAlpha::ManagedInstanceOverride, decorator: Google::Apis::ComputeAlpha::ManagedInstanceOverride::Representation
      
          property :standby_mode, as: 'standbyMode'
          property :tag, as: 'tag'
          property :version, as: 'version', class: Google::Apis::ComputeAlpha::ManagedInstanceVersion, decorator: Google::Apis::ComputeAlpha::ManagedInstanceVersion::Representation
      
        end
      end
      
      class ManagedInstanceLastAttempt
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :errors, as: 'errors', class: Google::Apis::ComputeAlpha::ManagedInstanceLastAttempt::Errors, decorator: Google::Apis::ComputeAlpha::ManagedInstanceLastAttempt::Errors::Representation
      
        end
        
        class Errors
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            collection :errors, as: 'errors', class: Google::Apis::ComputeAlpha::ManagedInstanceLastAttempt::Errors::Error, decorator: Google::Apis::ComputeAlpha::ManagedInstanceLastAttempt::Errors::Error::Representation
        
          end
          
          class Error
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :code, as: 'code'
              property :location, as: 'location'
              property :message, as: 'message'
            end
          end
        end
      end
      
      class ManagedInstanceOverride
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :disks, as: 'disks', class: Google::Apis::ComputeAlpha::ManagedInstanceOverrideDiskOverride, decorator: Google::Apis::ComputeAlpha::ManagedInstanceOverrideDiskOverride::Representation
      
          property :origin, as: 'origin'
        end
      end
      
      class ManagedInstanceOverrideDiskOverride
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :device_name, as: 'deviceName'
          property :mode, as: 'mode'
          property :source, as: 'source'
        end
      end
      
      class ManagedInstanceVersion
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_template, as: 'instanceTemplate'
          property :name, as: 'name'
        end
      end
      
      class Metadata
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Metadata::Item, decorator: Google::Apis::ComputeAlpha::Metadata::Item::Representation
      
          property :kind, as: 'kind'
        end
        
        class Item
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :key, as: 'key'
            property :value, as: 'value'
          end
        end
      end
      
      class NamedPort
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :name, as: 'name'
          property :port, as: 'port'
        end
      end
      
      class Network
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :i_pv4_range, as: 'IPv4Range'
          property :auto_create_subnetworks, as: 'autoCreateSubnetworks'
          property :creation_timestamp, as: 'creationTimestamp'
          property :cross_vm_encryption, as: 'crossVmEncryption'
          property :description, as: 'description'
          property :gateway_i_pv4, as: 'gatewayIPv4'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :load_balancer_vm_encryption, as: 'loadBalancerVmEncryption'
          property :name, as: 'name'
          collection :peerings, as: 'peerings', class: Google::Apis::ComputeAlpha::NetworkPeering, decorator: Google::Apis::ComputeAlpha::NetworkPeering::Representation
      
          property :routing_config, as: 'routingConfig', class: Google::Apis::ComputeAlpha::NetworkRoutingConfig, decorator: Google::Apis::ComputeAlpha::NetworkRoutingConfig::Representation
      
          property :self_link, as: 'selfLink'
          collection :subnetworks, as: 'subnetworks'
        end
      end
      
      class NetworkEndpoint
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance, as: 'instance'
          property :ip_address, as: 'ipAddress'
          property :port, as: 'port'
        end
      end
      
      class NetworkEndpointGroup
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :load_balancer, as: 'loadBalancer', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupLbNetworkEndpointGroup, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupLbNetworkEndpointGroup::Representation
      
          property :name, as: 'name'
          property :network_endpoint_type, as: 'networkEndpointType'
          property :self_link, as: 'selfLink'
          property :size, as: 'size'
          property :type, as: 'type'
        end
      end
      
      class NetworkEndpointGroupAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupsScopedList, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class NetworkEndpointGroupLbNetworkEndpointGroup
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :default_port, as: 'defaultPort'
          property :network, as: 'network'
          property :subnetwork, as: 'subnetwork'
          property :zone, as: 'zone'
        end
      end
      
      class NetworkEndpointGroupList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::NetworkEndpointGroup, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroup::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupList::Warning, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class NetworkEndpointGroupsAttachEndpointsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :network_endpoints, as: 'networkEndpoints', class: Google::Apis::ComputeAlpha::NetworkEndpoint, decorator: Google::Apis::ComputeAlpha::NetworkEndpoint::Representation
      
        end
      end
      
      class NetworkEndpointGroupsDetachEndpointsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :network_endpoints, as: 'networkEndpoints', class: Google::Apis::ComputeAlpha::NetworkEndpoint, decorator: Google::Apis::ComputeAlpha::NetworkEndpoint::Representation
      
        end
      end
      
      class NetworkEndpointGroupsListEndpointsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :health_status, as: 'healthStatus'
        end
      end
      
      class NetworkEndpointGroupsListNetworkEndpoints
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::NetworkEndpointWithHealthStatus, decorator: Google::Apis::ComputeAlpha::NetworkEndpointWithHealthStatus::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupsListNetworkEndpoints::Warning, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupsListNetworkEndpoints::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupsListNetworkEndpoints::Warning::Datum, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupsListNetworkEndpoints::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class NetworkEndpointGroupsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :network_endpoint_groups, as: 'networkEndpointGroups', class: Google::Apis::ComputeAlpha::NetworkEndpointGroup, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroup::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::NetworkEndpointGroupsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::NetworkEndpointGroupsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class NetworkEndpointWithHealthStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :healths, as: 'healths', class: Google::Apis::ComputeAlpha::HealthStatusForNetworkEndpoint, decorator: Google::Apis::ComputeAlpha::HealthStatusForNetworkEndpoint::Representation
      
          property :network_endpoint, as: 'networkEndpoint', class: Google::Apis::ComputeAlpha::NetworkEndpoint, decorator: Google::Apis::ComputeAlpha::NetworkEndpoint::Representation
      
        end
      end
      
      class NetworkInterface
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :access_configs, as: 'accessConfigs', class: Google::Apis::ComputeAlpha::AccessConfig, decorator: Google::Apis::ComputeAlpha::AccessConfig::Representation
      
          collection :alias_ip_ranges, as: 'aliasIpRanges', class: Google::Apis::ComputeAlpha::AliasIpRange, decorator: Google::Apis::ComputeAlpha::AliasIpRange::Representation
      
          property :fingerprint, :base64 => true, as: 'fingerprint'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :network, as: 'network'
          property :network_ip, as: 'networkIP'
          property :subnetwork, as: 'subnetwork'
        end
      end
      
      class NetworkList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Network, decorator: Google::Apis::ComputeAlpha::Network::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::NetworkList::Warning, decorator: Google::Apis::ComputeAlpha::NetworkList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::NetworkList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::NetworkList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class NetworkPeering
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :auto_create_routes, as: 'autoCreateRoutes'
          property :name, as: 'name'
          property :network, as: 'network'
          property :state, as: 'state'
          property :state_details, as: 'stateDetails'
        end
      end
      
      class NetworkRoutingConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :routing_mode, as: 'routingMode'
        end
      end
      
      class NetworksAddPeeringRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :auto_create_routes, as: 'autoCreateRoutes'
          property :name, as: 'name'
          property :peer_network, as: 'peerNetwork'
        end
      end
      
      class NetworksRemovePeeringRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :name, as: 'name'
        end
      end
      
      class Operation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :client_operation_id, as: 'clientOperationId'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :end_time, as: 'endTime'
          property :error, as: 'error', class: Google::Apis::ComputeAlpha::Operation::Error, decorator: Google::Apis::ComputeAlpha::Operation::Error::Representation
      
          property :http_error_message, as: 'httpErrorMessage'
          property :http_error_status_code, as: 'httpErrorStatusCode'
          property :id, :numeric_string => true, as: 'id'
          property :insert_time, as: 'insertTime'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :operation_type, as: 'operationType'
          property :progress, as: 'progress'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :start_time, as: 'startTime'
          property :status, as: 'status'
          property :status_message, as: 'statusMessage'
          property :target_id, :numeric_string => true, as: 'targetId'
          property :target_link, as: 'targetLink'
          property :user, as: 'user'
          collection :warnings, as: 'warnings', class: Google::Apis::ComputeAlpha::Operation::Warning, decorator: Google::Apis::ComputeAlpha::Operation::Warning::Representation
      
          property :zone, as: 'zone'
        end
        
        class Error
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            collection :errors, as: 'errors', class: Google::Apis::ComputeAlpha::Operation::Error::Error, decorator: Google::Apis::ComputeAlpha::Operation::Error::Error::Representation
        
          end
          
          class Error
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :code, as: 'code'
              property :location, as: 'location'
              property :message, as: 'message'
            end
          end
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::Operation::Warning::Datum, decorator: Google::Apis::ComputeAlpha::Operation::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class OperationAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::OperationsScopedList, decorator: Google::Apis::ComputeAlpha::OperationsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::OperationAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::OperationAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::OperationAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::OperationAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class OperationList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Operation, decorator: Google::Apis::ComputeAlpha::Operation::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::OperationList::Warning, decorator: Google::Apis::ComputeAlpha::OperationList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::OperationList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::OperationList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class OperationsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :operations, as: 'operations', class: Google::Apis::ComputeAlpha::Operation, decorator: Google::Apis::ComputeAlpha::Operation::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::OperationsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::OperationsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::OperationsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::OperationsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class PathMatcher
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :default_service, as: 'defaultService'
          property :description, as: 'description'
          property :name, as: 'name'
          collection :path_rules, as: 'pathRules', class: Google::Apis::ComputeAlpha::PathRule, decorator: Google::Apis::ComputeAlpha::PathRule::Representation
      
        end
      end
      
      class PathRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :paths, as: 'paths'
          property :service, as: 'service'
        end
      end
      
      class PerInstanceConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance, as: 'instance'
          property :override, as: 'override', class: Google::Apis::ComputeAlpha::ManagedInstanceOverride, decorator: Google::Apis::ComputeAlpha::ManagedInstanceOverride::Representation
      
        end
      end
      
      class Policy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :audit_configs, as: 'auditConfigs', class: Google::Apis::ComputeAlpha::AuditConfig, decorator: Google::Apis::ComputeAlpha::AuditConfig::Representation
      
          collection :bindings, as: 'bindings', class: Google::Apis::ComputeAlpha::Binding, decorator: Google::Apis::ComputeAlpha::Binding::Representation
      
          property :etag, :base64 => true, as: 'etag'
          property :iam_owned, as: 'iamOwned'
          collection :rules, as: 'rules', class: Google::Apis::ComputeAlpha::Rule, decorator: Google::Apis::ComputeAlpha::Rule::Representation
      
          property :version, as: 'version'
        end
      end
      
      class Project
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :common_instance_metadata, as: 'commonInstanceMetadata', class: Google::Apis::ComputeAlpha::Metadata, decorator: Google::Apis::ComputeAlpha::Metadata::Representation
      
          property :creation_timestamp, as: 'creationTimestamp'
          property :default_service_account, as: 'defaultServiceAccount'
          property :description, as: 'description'
          collection :enabled_features, as: 'enabledFeatures'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :quotas, as: 'quotas', class: Google::Apis::ComputeAlpha::Quota, decorator: Google::Apis::ComputeAlpha::Quota::Representation
      
          property :self_link, as: 'selfLink'
          property :usage_export_location, as: 'usageExportLocation', class: Google::Apis::ComputeAlpha::UsageExportLocation, decorator: Google::Apis::ComputeAlpha::UsageExportLocation::Representation
      
          property :xpn_project_status, as: 'xpnProjectStatus'
        end
      end
      
      class ProjectsDisableXpnResourceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :xpn_resource, as: 'xpnResource', class: Google::Apis::ComputeAlpha::XpnResourceId, decorator: Google::Apis::ComputeAlpha::XpnResourceId::Representation
      
        end
      end
      
      class ProjectsEnableXpnResourceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :xpn_resource, as: 'xpnResource', class: Google::Apis::ComputeAlpha::XpnResourceId, decorator: Google::Apis::ComputeAlpha::XpnResourceId::Representation
      
        end
      end
      
      class ProjectsGetXpnResources
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          collection :resources, as: 'resources', class: Google::Apis::ComputeAlpha::XpnResourceId, decorator: Google::Apis::ComputeAlpha::XpnResourceId::Representation
      
        end
      end
      
      class ProjectsListXpnHostsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :organization, as: 'organization'
        end
      end
      
      class ProjectsSetDefaultServiceAccountRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :email, as: 'email'
        end
      end
      
      class Quota
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :limit, as: 'limit'
          property :metric, as: 'metric'
          property :usage, as: 'usage'
        end
      end
      
      class Reference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :reference_type, as: 'referenceType'
          property :referrer, as: 'referrer'
          property :target, as: 'target'
        end
      end
      
      class Region
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :quotas, as: 'quotas', class: Google::Apis::ComputeAlpha::Quota, decorator: Google::Apis::ComputeAlpha::Quota::Representation
      
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
          collection :zones, as: 'zones'
        end
      end
      
      class RegionAutoscalerList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Autoscaler, decorator: Google::Apis::ComputeAlpha::Autoscaler::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionAutoscalerList::Warning, decorator: Google::Apis::ComputeAlpha::RegionAutoscalerList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionAutoscalerList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionAutoscalerList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionDiskTypeList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::DiskType, decorator: Google::Apis::ComputeAlpha::DiskType::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionDiskTypeList::Warning, decorator: Google::Apis::ComputeAlpha::RegionDiskTypeList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionDiskTypeList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionDiskTypeList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionDisksResizeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :size_gb, :numeric_string => true, as: 'sizeGb'
        end
      end
      
      class RegionInstanceGroupList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceGroup, decorator: Google::Apis::ComputeAlpha::InstanceGroup::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionInstanceGroupList::Warning, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionInstanceGroupList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionInstanceGroupManagerDeleteInstanceConfigReq
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class RegionInstanceGroupManagerList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceGroupManager, decorator: Google::Apis::ComputeAlpha::InstanceGroupManager::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionInstanceGroupManagerList::Warning, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupManagerList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionInstanceGroupManagerList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupManagerList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionInstanceGroupManagerUpdateInstanceConfigReq
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :per_instance_configs, as: 'perInstanceConfigs', class: Google::Apis::ComputeAlpha::PerInstanceConfig, decorator: Google::Apis::ComputeAlpha::PerInstanceConfig::Representation
      
        end
      end
      
      class RegionInstanceGroupManagersAbandonInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class RegionInstanceGroupManagersApplyUpdatesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
          property :maximal_action, as: 'maximalAction'
          property :minimal_action, as: 'minimalAction'
        end
      end
      
      class RegionInstanceGroupManagersDeleteInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class RegionInstanceGroupManagersListInstanceConfigsResp
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::PerInstanceConfig, decorator: Google::Apis::ComputeAlpha::PerInstanceConfig::Representation
      
          property :next_page_token, as: 'nextPageToken'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionInstanceGroupManagersListInstanceConfigsResp::Warning, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupManagersListInstanceConfigsResp::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionInstanceGroupManagersListInstanceConfigsResp::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupManagersListInstanceConfigsResp::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionInstanceGroupManagersListInstancesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :managed_instances, as: 'managedInstances', class: Google::Apis::ComputeAlpha::ManagedInstance, decorator: Google::Apis::ComputeAlpha::ManagedInstance::Representation
      
          property :next_page_token, as: 'nextPageToken'
        end
      end
      
      class RegionInstanceGroupManagersRecreateRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances'
        end
      end
      
      class RegionInstanceGroupManagersSetAutoHealingRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :auto_healing_policies, as: 'autoHealingPolicies', class: Google::Apis::ComputeAlpha::InstanceGroupManagerAutoHealingPolicy, decorator: Google::Apis::ComputeAlpha::InstanceGroupManagerAutoHealingPolicy::Representation
      
        end
      end
      
      class RegionInstanceGroupManagersSetTargetPoolsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :target_pools, as: 'targetPools'
        end
      end
      
      class RegionInstanceGroupManagersSetTemplateRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_template, as: 'instanceTemplate'
        end
      end
      
      class RegionInstanceGroupsListInstances
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::InstanceWithNamedPorts, decorator: Google::Apis::ComputeAlpha::InstanceWithNamedPorts::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionInstanceGroupsListInstances::Warning, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupsListInstances::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionInstanceGroupsListInstances::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionInstanceGroupsListInstances::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionInstanceGroupsListInstancesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_state, as: 'instanceState'
          property :port_name, as: 'portName'
        end
      end
      
      class RegionInstanceGroupsSetNamedPortsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :named_ports, as: 'namedPorts', class: Google::Apis::ComputeAlpha::NamedPort, decorator: Google::Apis::ComputeAlpha::NamedPort::Representation
      
        end
      end
      
      class RegionList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Region, decorator: Google::Apis::ComputeAlpha::Region::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RegionList::Warning, decorator: Google::Apis::ComputeAlpha::RegionList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RegionList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RegionList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RegionSetLabelsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
        end
      end
      
      class ResourceCommitment
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :amount, :numeric_string => true, as: 'amount'
          property :type, as: 'type'
        end
      end
      
      class ResourceGroupReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :group, as: 'group'
        end
      end
      
      class Route
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :dest_range, as: 'destRange'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :network, as: 'network'
          property :next_hop_gateway, as: 'nextHopGateway'
          property :next_hop_instance, as: 'nextHopInstance'
          property :next_hop_ip, as: 'nextHopIp'
          property :next_hop_network, as: 'nextHopNetwork'
          property :next_hop_peering, as: 'nextHopPeering'
          property :next_hop_vpn_tunnel, as: 'nextHopVpnTunnel'
          property :priority, as: 'priority'
          property :self_link, as: 'selfLink'
          collection :tags, as: 'tags'
          collection :warnings, as: 'warnings', class: Google::Apis::ComputeAlpha::Route::Warning, decorator: Google::Apis::ComputeAlpha::Route::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::Route::Warning::Datum, decorator: Google::Apis::ComputeAlpha::Route::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RouteList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Route, decorator: Google::Apis::ComputeAlpha::Route::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RouteList::Warning, decorator: Google::Apis::ComputeAlpha::RouteList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RouteList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RouteList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Router
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bgp, as: 'bgp', class: Google::Apis::ComputeAlpha::RouterBgp, decorator: Google::Apis::ComputeAlpha::RouterBgp::Representation
      
          collection :bgp_peers, as: 'bgpPeers', class: Google::Apis::ComputeAlpha::RouterBgpPeer, decorator: Google::Apis::ComputeAlpha::RouterBgpPeer::Representation
      
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          collection :interfaces, as: 'interfaces', class: Google::Apis::ComputeAlpha::RouterInterface, decorator: Google::Apis::ComputeAlpha::RouterInterface::Representation
      
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :nats, as: 'nats', class: Google::Apis::ComputeAlpha::RouterNat, decorator: Google::Apis::ComputeAlpha::RouterNat::Representation
      
          property :network, as: 'network'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
        end
      end
      
      class RouterAdvertisedPrefix
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          property :prefix, as: 'prefix'
        end
      end
      
      class RouterAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::RoutersScopedList, decorator: Google::Apis::ComputeAlpha::RoutersScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RouterAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::RouterAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RouterAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RouterAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RouterBgp
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :advertise_mode, as: 'advertiseMode'
          collection :advertised_groups, as: 'advertisedGroups'
          collection :advertised_prefixs, as: 'advertisedPrefixs', class: Google::Apis::ComputeAlpha::RouterAdvertisedPrefix, decorator: Google::Apis::ComputeAlpha::RouterAdvertisedPrefix::Representation
      
          property :asn, as: 'asn'
        end
      end
      
      class RouterBgpPeer
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :advertise_mode, as: 'advertiseMode'
          collection :advertised_groups, as: 'advertisedGroups'
          collection :advertised_prefixs, as: 'advertisedPrefixs', class: Google::Apis::ComputeAlpha::RouterAdvertisedPrefix, decorator: Google::Apis::ComputeAlpha::RouterAdvertisedPrefix::Representation
      
          property :advertised_route_priority, as: 'advertisedRoutePriority'
          property :interface_name, as: 'interfaceName'
          property :ip_address, as: 'ipAddress'
          property :name, as: 'name'
          property :peer_asn, as: 'peerAsn'
          property :peer_ip_address, as: 'peerIpAddress'
        end
      end
      
      class RouterInterface
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :ip_range, as: 'ipRange'
          property :linked_interconnect_attachment, as: 'linkedInterconnectAttachment'
          property :linked_vpn_tunnel, as: 'linkedVpnTunnel'
          property :name, as: 'name'
        end
      end
      
      class RouterList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Router, decorator: Google::Apis::ComputeAlpha::Router::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RouterList::Warning, decorator: Google::Apis::ComputeAlpha::RouterList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RouterList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RouterList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class RouterNat
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :auto_allocated_nat_ips, as: 'autoAllocatedNatIps'
          property :name, as: 'name'
          property :nat_ip_allocate_option, as: 'natIpAllocateOption'
          collection :nat_ips, as: 'natIps'
          property :source_subnetwork_ip_ranges_to_nat, as: 'sourceSubnetworkIpRangesToNat'
          collection :subnetworks, as: 'subnetworks', class: Google::Apis::ComputeAlpha::RouterNatSubnetworkToNat, decorator: Google::Apis::ComputeAlpha::RouterNatSubnetworkToNat::Representation
      
        end
      end
      
      class RouterNatSubnetworkToNat
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :name, as: 'name'
          collection :secondary_ip_range_names, as: 'secondaryIpRangeNames'
          collection :source_ip_ranges_to_nats, as: 'sourceIpRangesToNats'
        end
      end
      
      class RouterStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :best_routes, as: 'bestRoutes', class: Google::Apis::ComputeAlpha::Route, decorator: Google::Apis::ComputeAlpha::Route::Representation
      
          collection :best_routes_for_router, as: 'bestRoutesForRouter', class: Google::Apis::ComputeAlpha::Route, decorator: Google::Apis::ComputeAlpha::Route::Representation
      
          collection :bgp_peer_status, as: 'bgpPeerStatus', class: Google::Apis::ComputeAlpha::RouterStatusBgpPeerStatus, decorator: Google::Apis::ComputeAlpha::RouterStatusBgpPeerStatus::Representation
      
          collection :nat_status, as: 'natStatus', class: Google::Apis::ComputeAlpha::RouterStatusNatStatus, decorator: Google::Apis::ComputeAlpha::RouterStatusNatStatus::Representation
      
          property :network, as: 'network'
        end
      end
      
      class RouterStatusBgpPeerStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :advertised_routes, as: 'advertisedRoutes', class: Google::Apis::ComputeAlpha::Route, decorator: Google::Apis::ComputeAlpha::Route::Representation
      
          property :ip_address, as: 'ipAddress'
          property :linked_vpn_tunnel, as: 'linkedVpnTunnel'
          property :name, as: 'name'
          property :num_learned_routes, as: 'numLearnedRoutes'
          property :peer_ip_address, as: 'peerIpAddress'
          property :state, as: 'state'
          property :status, as: 'status'
          property :uptime, as: 'uptime'
          property :uptime_seconds, as: 'uptimeSeconds'
        end
      end
      
      class RouterStatusNatStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :auto_allocated_nat_ips, as: 'autoAllocatedNatIps'
          property :min_extra_nat_ips_needed, as: 'minExtraNatIpsNeeded'
          property :name, as: 'name'
          property :num_vm_endpoints_with_nat_mappings, as: 'numVmEndpointsWithNatMappings'
          collection :user_allocated_nat_ip_resources, as: 'userAllocatedNatIpResources'
          collection :user_allocated_nat_ips, as: 'userAllocatedNatIps'
        end
      end
      
      class RouterStatusResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :result, as: 'result', class: Google::Apis::ComputeAlpha::RouterStatus, decorator: Google::Apis::ComputeAlpha::RouterStatus::Representation
      
        end
      end
      
      class RoutersPreviewResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :resource, as: 'resource', class: Google::Apis::ComputeAlpha::Router, decorator: Google::Apis::ComputeAlpha::Router::Representation
      
        end
      end
      
      class RoutersScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :routers, as: 'routers', class: Google::Apis::ComputeAlpha::Router, decorator: Google::Apis::ComputeAlpha::Router::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::RoutersScopedList::Warning, decorator: Google::Apis::ComputeAlpha::RoutersScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::RoutersScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::RoutersScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Rule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :action, as: 'action'
          collection :conditions, as: 'conditions', class: Google::Apis::ComputeAlpha::Condition, decorator: Google::Apis::ComputeAlpha::Condition::Representation
      
          property :description, as: 'description'
          collection :ins, as: 'ins'
          collection :log_configs, as: 'logConfigs', class: Google::Apis::ComputeAlpha::LogConfig, decorator: Google::Apis::ComputeAlpha::LogConfig::Representation
      
          collection :not_ins, as: 'notIns'
          collection :permissions, as: 'permissions'
        end
      end
      
      class SslHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :proxy_header, as: 'proxyHeader'
          property :request, as: 'request'
          property :response, as: 'response'
        end
      end
      
      class Scheduling
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :automatic_restart, as: 'automaticRestart'
          property :on_host_maintenance, as: 'onHostMaintenance'
          property :preemptible, as: 'preemptible'
        end
      end
      
      class SecurityPoliciesList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::SecurityPolicy, decorator: Google::Apis::ComputeAlpha::SecurityPolicy::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::SecurityPoliciesList::Warning, decorator: Google::Apis::ComputeAlpha::SecurityPoliciesList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::SecurityPoliciesList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::SecurityPoliciesList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class SecurityPolicy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :fingerprint, :base64 => true, as: 'fingerprint'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :rules, as: 'rules', class: Google::Apis::ComputeAlpha::SecurityPolicyRule, decorator: Google::Apis::ComputeAlpha::SecurityPolicyRule::Representation
      
          property :self_link, as: 'selfLink'
        end
      end
      
      class SecurityPolicyReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :security_policy, as: 'securityPolicy'
        end
      end
      
      class SecurityPolicyRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :action, as: 'action'
          property :description, as: 'description'
          property :kind, as: 'kind'
          property :match, as: 'match', class: Google::Apis::ComputeAlpha::SecurityPolicyRuleMatcher, decorator: Google::Apis::ComputeAlpha::SecurityPolicyRuleMatcher::Representation
      
          property :preview, as: 'preview'
          property :priority, as: 'priority'
        end
      end
      
      class SecurityPolicyRuleMatcher
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :config, as: 'config', class: Google::Apis::ComputeAlpha::SecurityPolicyRuleMatcherConfig, decorator: Google::Apis::ComputeAlpha::SecurityPolicyRuleMatcherConfig::Representation
      
          collection :src_ip_ranges, as: 'srcIpRanges'
          collection :src_region_codes, as: 'srcRegionCodes'
          property :versioned_expr, as: 'versionedExpr'
        end
      end
      
      class SecurityPolicyRuleMatcherConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :src_ip_ranges, as: 'srcIpRanges'
        end
      end
      
      class SerialPortOutput
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :contents, as: 'contents'
          property :kind, as: 'kind'
          property :next, :numeric_string => true, as: 'next'
          property :self_link, as: 'selfLink'
          property :start, :numeric_string => true, as: 'start'
        end
      end
      
      class ServiceAccount
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :email, as: 'email'
          collection :scopes, as: 'scopes'
        end
      end
      
      class SignedUrlKey
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :key_name, as: 'keyName'
          property :key_value, as: 'keyValue'
        end
      end
      
      class Snapshot
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :disk_size_gb, :numeric_string => true, as: 'diskSizeGb'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          collection :license_codes, as: 'licenseCodes'
          collection :licenses, as: 'licenses'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :snapshot_encryption_key, as: 'snapshotEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source_disk, as: 'sourceDisk'
          property :source_disk_encryption_key, as: 'sourceDiskEncryptionKey', class: Google::Apis::ComputeAlpha::CustomerEncryptionKey, decorator: Google::Apis::ComputeAlpha::CustomerEncryptionKey::Representation
      
          property :source_disk_id, as: 'sourceDiskId'
          property :status, as: 'status'
          property :storage_bytes, :numeric_string => true, as: 'storageBytes'
          property :storage_bytes_status, as: 'storageBytesStatus'
        end
      end
      
      class SnapshotList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Snapshot, decorator: Google::Apis::ComputeAlpha::Snapshot::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::SnapshotList::Warning, decorator: Google::Apis::ComputeAlpha::SnapshotList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::SnapshotList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::SnapshotList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class SslCertificate
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :certificate, as: 'certificate'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :private_key, as: 'privateKey'
          property :self_link, as: 'selfLink'
        end
      end
      
      class SslCertificateList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::SslCertificate, decorator: Google::Apis::ComputeAlpha::SslCertificate::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::SslCertificateList::Warning, decorator: Google::Apis::ComputeAlpha::SslCertificateList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::SslCertificateList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::SslCertificateList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class Subnetwork
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :allow_subnet_cidr_routes_overlap, as: 'allowSubnetCidrRoutesOverlap'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :fingerprint, :base64 => true, as: 'fingerprint'
          property :gateway_address, as: 'gatewayAddress'
          property :id, :numeric_string => true, as: 'id'
          property :ip_cidr_range, as: 'ipCidrRange'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :network, as: 'network'
          property :private_ip_google_access, as: 'privateIpGoogleAccess'
          property :region, as: 'region'
          collection :secondary_ip_ranges, as: 'secondaryIpRanges', class: Google::Apis::ComputeAlpha::SubnetworkSecondaryRange, decorator: Google::Apis::ComputeAlpha::SubnetworkSecondaryRange::Representation
      
          property :self_link, as: 'selfLink'
        end
      end
      
      class SubnetworkAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::SubnetworksScopedList, decorator: Google::Apis::ComputeAlpha::SubnetworksScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::SubnetworkAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::SubnetworkAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::SubnetworkAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::SubnetworkAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class SubnetworkList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Subnetwork, decorator: Google::Apis::ComputeAlpha::Subnetwork::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::SubnetworkList::Warning, decorator: Google::Apis::ComputeAlpha::SubnetworkList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::SubnetworkList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::SubnetworkList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class SubnetworkSecondaryRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :ip_cidr_range, as: 'ipCidrRange'
          property :range_name, as: 'rangeName'
        end
      end
      
      class SubnetworksExpandIpCidrRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :ip_cidr_range, as: 'ipCidrRange'
        end
      end
      
      class SubnetworksScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :subnetworks, as: 'subnetworks', class: Google::Apis::ComputeAlpha::Subnetwork, decorator: Google::Apis::ComputeAlpha::Subnetwork::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::SubnetworksScopedList::Warning, decorator: Google::Apis::ComputeAlpha::SubnetworksScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::SubnetworksScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::SubnetworksScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class SubnetworksSetPrivateIpGoogleAccessRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :private_ip_google_access, as: 'privateIpGoogleAccess'
        end
      end
      
      class TcpHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :proxy_header, as: 'proxyHeader'
          property :request, as: 'request'
          property :response, as: 'response'
        end
      end
      
      class Tags
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :items, as: 'items'
        end
      end
      
      class TargetHttpProxy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :self_link, as: 'selfLink'
          property :url_map, as: 'urlMap'
        end
      end
      
      class TargetHttpProxyList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetHttpProxy, decorator: Google::Apis::ComputeAlpha::TargetHttpProxy::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetHttpProxyList::Warning, decorator: Google::Apis::ComputeAlpha::TargetHttpProxyList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetHttpProxyList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetHttpProxyList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetHttpsProxiesSetQuicOverrideRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :quic_override, as: 'quicOverride'
        end
      end
      
      class TargetHttpsProxiesSetSslCertificatesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :ssl_certificates, as: 'sslCertificates'
        end
      end
      
      class TargetHttpsProxy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :client_ssl_policy, as: 'clientSslPolicy'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :quic_override, as: 'quicOverride'
          property :self_link, as: 'selfLink'
          collection :ssl_certificates, as: 'sslCertificates'
          property :url_map, as: 'urlMap'
        end
      end
      
      class TargetHttpsProxyList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetHttpsProxy, decorator: Google::Apis::ComputeAlpha::TargetHttpsProxy::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetHttpsProxyList::Warning, decorator: Google::Apis::ComputeAlpha::TargetHttpsProxyList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetHttpsProxyList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetHttpsProxyList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetInstance
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :instance, as: 'instance'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :nat_policy, as: 'natPolicy'
          property :self_link, as: 'selfLink'
          property :zone, as: 'zone'
        end
      end
      
      class TargetInstanceAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetInstancesScopedList, decorator: Google::Apis::ComputeAlpha::TargetInstancesScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetInstanceAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::TargetInstanceAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetInstanceAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetInstanceAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetInstanceList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetInstance, decorator: Google::Apis::ComputeAlpha::TargetInstance::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetInstanceList::Warning, decorator: Google::Apis::ComputeAlpha::TargetInstanceList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetInstanceList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetInstanceList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetInstancesScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :target_instances, as: 'targetInstances', class: Google::Apis::ComputeAlpha::TargetInstance, decorator: Google::Apis::ComputeAlpha::TargetInstance::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetInstancesScopedList::Warning, decorator: Google::Apis::ComputeAlpha::TargetInstancesScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetInstancesScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetInstancesScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetPool
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :backup_pool, as: 'backupPool'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :failover_ratio, as: 'failoverRatio'
          collection :health_checks, as: 'healthChecks'
          property :id, :numeric_string => true, as: 'id'
          collection :instances, as: 'instances'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :session_affinity, as: 'sessionAffinity'
        end
      end
      
      class TargetPoolAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetPoolsScopedList, decorator: Google::Apis::ComputeAlpha::TargetPoolsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetPoolAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::TargetPoolAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetPoolAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetPoolAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetPoolInstanceHealth
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :health_status, as: 'healthStatus', class: Google::Apis::ComputeAlpha::HealthStatus, decorator: Google::Apis::ComputeAlpha::HealthStatus::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class TargetPoolList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetPool, decorator: Google::Apis::ComputeAlpha::TargetPool::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetPoolList::Warning, decorator: Google::Apis::ComputeAlpha::TargetPoolList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetPoolList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetPoolList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetPoolsAddHealthCheckRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :health_checks, as: 'healthChecks', class: Google::Apis::ComputeAlpha::HealthCheckReference, decorator: Google::Apis::ComputeAlpha::HealthCheckReference::Representation
      
        end
      end
      
      class TargetPoolsAddInstanceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances', class: Google::Apis::ComputeAlpha::InstanceReference, decorator: Google::Apis::ComputeAlpha::InstanceReference::Representation
      
        end
      end
      
      class TargetPoolsRemoveHealthCheckRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :health_checks, as: 'healthChecks', class: Google::Apis::ComputeAlpha::HealthCheckReference, decorator: Google::Apis::ComputeAlpha::HealthCheckReference::Representation
      
        end
      end
      
      class TargetPoolsRemoveInstanceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :instances, as: 'instances', class: Google::Apis::ComputeAlpha::InstanceReference, decorator: Google::Apis::ComputeAlpha::InstanceReference::Representation
      
        end
      end
      
      class TargetPoolsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :target_pools, as: 'targetPools', class: Google::Apis::ComputeAlpha::TargetPool, decorator: Google::Apis::ComputeAlpha::TargetPool::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetPoolsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::TargetPoolsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetPoolsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetPoolsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :target, as: 'target'
        end
      end
      
      class TargetSslProxiesSetBackendServiceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :service, as: 'service'
        end
      end
      
      class TargetSslProxiesSetProxyHeaderRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :proxy_header, as: 'proxyHeader'
        end
      end
      
      class TargetSslProxiesSetSslCertificatesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :ssl_certificates, as: 'sslCertificates'
        end
      end
      
      class TargetSslProxy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :client_ssl_policy, as: 'clientSslPolicy'
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :proxy_header, as: 'proxyHeader'
          property :self_link, as: 'selfLink'
          property :service, as: 'service'
          collection :ssl_certificates, as: 'sslCertificates'
        end
      end
      
      class TargetSslProxyList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetSslProxy, decorator: Google::Apis::ComputeAlpha::TargetSslProxy::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetSslProxyList::Warning, decorator: Google::Apis::ComputeAlpha::TargetSslProxyList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetSslProxyList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetSslProxyList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetTcpProxiesSetBackendServiceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :service, as: 'service'
        end
      end
      
      class TargetTcpProxiesSetProxyHeaderRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :proxy_header, as: 'proxyHeader'
        end
      end
      
      class TargetTcpProxy
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :proxy_header, as: 'proxyHeader'
          property :self_link, as: 'selfLink'
          property :service, as: 'service'
        end
      end
      
      class TargetTcpProxyList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetTcpProxy, decorator: Google::Apis::ComputeAlpha::TargetTcpProxy::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetTcpProxyList::Warning, decorator: Google::Apis::ComputeAlpha::TargetTcpProxyList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetTcpProxyList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetTcpProxyList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetVpnGateway
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          collection :forwarding_rules, as: 'forwardingRules'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :network, as: 'network'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
          collection :tunnels, as: 'tunnels'
        end
      end
      
      class TargetVpnGatewayAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetVpnGatewaysScopedList, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewaysScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetVpnGatewayAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewayAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetVpnGatewayAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewayAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetVpnGatewayList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::TargetVpnGateway, decorator: Google::Apis::ComputeAlpha::TargetVpnGateway::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetVpnGatewayList::Warning, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewayList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetVpnGatewayList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewayList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TargetVpnGatewaysScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :target_vpn_gateways, as: 'targetVpnGateways', class: Google::Apis::ComputeAlpha::TargetVpnGateway, decorator: Google::Apis::ComputeAlpha::TargetVpnGateway::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::TargetVpnGatewaysScopedList::Warning, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewaysScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::TargetVpnGatewaysScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::TargetVpnGatewaysScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class TestFailure
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :actual_service, as: 'actualService'
          property :expected_service, as: 'expectedService'
          property :host, as: 'host'
          property :path, as: 'path'
        end
      end
      
      class TestPermissionsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :permissions, as: 'permissions'
        end
      end
      
      class TestPermissionsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :permissions, as: 'permissions'
        end
      end
      
      class UdpHealthCheck
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :port, as: 'port'
          property :port_name, as: 'portName'
          property :request, as: 'request'
          property :response, as: 'response'
        end
      end
      
      class UrlMap
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :default_service, as: 'defaultService'
          property :description, as: 'description'
          property :fingerprint, :base64 => true, as: 'fingerprint'
          collection :host_rules, as: 'hostRules', class: Google::Apis::ComputeAlpha::HostRule, decorator: Google::Apis::ComputeAlpha::HostRule::Representation
      
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          collection :path_matchers, as: 'pathMatchers', class: Google::Apis::ComputeAlpha::PathMatcher, decorator: Google::Apis::ComputeAlpha::PathMatcher::Representation
      
          property :self_link, as: 'selfLink'
          collection :tests, as: 'tests', class: Google::Apis::ComputeAlpha::UrlMapTest, decorator: Google::Apis::ComputeAlpha::UrlMapTest::Representation
      
        end
      end
      
      class UrlMapList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::UrlMap, decorator: Google::Apis::ComputeAlpha::UrlMap::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::UrlMapList::Warning, decorator: Google::Apis::ComputeAlpha::UrlMapList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::UrlMapList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::UrlMapList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class UrlMapReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :url_map, as: 'urlMap'
        end
      end
      
      class UrlMapTest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          property :host, as: 'host'
          property :path, as: 'path'
          property :service, as: 'service'
        end
      end
      
      class UrlMapValidationResult
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :load_errors, as: 'loadErrors'
          property :load_succeeded, as: 'loadSucceeded'
          collection :test_failures, as: 'testFailures', class: Google::Apis::ComputeAlpha::TestFailure, decorator: Google::Apis::ComputeAlpha::TestFailure::Representation
      
          property :test_passed, as: 'testPassed'
        end
      end
      
      class UrlMapsValidateRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :resource, as: 'resource', class: Google::Apis::ComputeAlpha::UrlMap, decorator: Google::Apis::ComputeAlpha::UrlMap::Representation
      
        end
      end
      
      class UrlMapsValidateResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :result, as: 'result', class: Google::Apis::ComputeAlpha::UrlMapValidationResult, decorator: Google::Apis::ComputeAlpha::UrlMapValidationResult::Representation
      
        end
      end
      
      class UsageExportLocation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bucket_name, as: 'bucketName'
          property :report_name_prefix, as: 'reportNamePrefix'
        end
      end
      
      class VpnTunnel
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :creation_timestamp, as: 'creationTimestamp'
          property :description, as: 'description'
          property :detailed_status, as: 'detailedStatus'
          property :id, :numeric_string => true, as: 'id'
          property :ike_version, as: 'ikeVersion'
          property :kind, as: 'kind'
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
          collection :local_traffic_selector, as: 'localTrafficSelector'
          property :name, as: 'name'
          property :peer_ip, as: 'peerIp'
          property :region, as: 'region'
          collection :remote_traffic_selector, as: 'remoteTrafficSelector'
          property :router, as: 'router'
          property :self_link, as: 'selfLink'
          property :shared_secret, as: 'sharedSecret'
          property :shared_secret_hash, as: 'sharedSecretHash'
          property :status, as: 'status'
          property :target_vpn_gateway, as: 'targetVpnGateway'
        end
      end
      
      class VpnTunnelAggregatedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          hash :items, as: 'items', class: Google::Apis::ComputeAlpha::VpnTunnelsScopedList, decorator: Google::Apis::ComputeAlpha::VpnTunnelsScopedList::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::VpnTunnelAggregatedList::Warning, decorator: Google::Apis::ComputeAlpha::VpnTunnelAggregatedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::VpnTunnelAggregatedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::VpnTunnelAggregatedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class VpnTunnelList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::VpnTunnel, decorator: Google::Apis::ComputeAlpha::VpnTunnel::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::VpnTunnelList::Warning, decorator: Google::Apis::ComputeAlpha::VpnTunnelList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::VpnTunnelList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::VpnTunnelList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class VpnTunnelsScopedList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :vpn_tunnels, as: 'vpnTunnels', class: Google::Apis::ComputeAlpha::VpnTunnel, decorator: Google::Apis::ComputeAlpha::VpnTunnel::Representation
      
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::VpnTunnelsScopedList::Warning, decorator: Google::Apis::ComputeAlpha::VpnTunnelsScopedList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::VpnTunnelsScopedList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::VpnTunnelsScopedList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class XpnHostList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Project, decorator: Google::Apis::ComputeAlpha::Project::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::XpnHostList::Warning, decorator: Google::Apis::ComputeAlpha::XpnHostList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::XpnHostList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::XpnHostList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class XpnResourceId
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          property :type, as: 'type'
        end
      end
      
      class Zone
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :available_cpu_platforms, as: 'availableCpuPlatforms'
          property :creation_timestamp, as: 'creationTimestamp'
          property :deprecated, as: 'deprecated', class: Google::Apis::ComputeAlpha::DeprecationStatus, decorator: Google::Apis::ComputeAlpha::DeprecationStatus::Representation
      
          property :description, as: 'description'
          property :id, :numeric_string => true, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :region, as: 'region'
          property :self_link, as: 'selfLink'
          property :status, as: 'status'
        end
      end
      
      class ZoneList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :items, as: 'items', class: Google::Apis::ComputeAlpha::Zone, decorator: Google::Apis::ComputeAlpha::Zone::Representation
      
          property :kind, as: 'kind'
          property :next_page_token, as: 'nextPageToken'
          property :self_link, as: 'selfLink'
          property :warning, as: 'warning', class: Google::Apis::ComputeAlpha::ZoneList::Warning, decorator: Google::Apis::ComputeAlpha::ZoneList::Warning::Representation
      
        end
        
        class Warning
          # @private
          class Representation < Google::Apis::Core::JsonRepresentation
            property :code, as: 'code'
            collection :data, as: 'data', class: Google::Apis::ComputeAlpha::ZoneList::Warning::Datum, decorator: Google::Apis::ComputeAlpha::ZoneList::Warning::Datum::Representation
        
            property :message, as: 'message'
          end
          
          class Datum
            # @private
            class Representation < Google::Apis::Core::JsonRepresentation
              property :key, as: 'key'
              property :value, as: 'value'
            end
          end
        end
      end
      
      class ZoneSetLabelsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :label_fingerprint, :base64 => true, as: 'labelFingerprint'
          hash :labels, as: 'labels'
        end
      end
    end
  end
end
