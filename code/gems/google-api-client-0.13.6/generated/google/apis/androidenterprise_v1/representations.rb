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
    module AndroidenterpriseV1
      
      class Administrator
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AdministratorWebToken
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AdministratorWebTokenSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AndroidDevicePolicyConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppRestrictionsSchema
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppRestrictionsSchemaChangeEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppRestrictionsSchemaRestriction
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppRestrictionsSchemaRestrictionRestrictionValue
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppUpdateEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppVersion
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ApprovalUrlInfo
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AuthenticationToken
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Device
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeviceState
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListDevicesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Enterprise
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class EnterpriseAccount
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListEnterprisesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SendTestPushNotificationResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Entitlement
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListEntitlementsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GroupLicense
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListGroupLicenseUsersResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListGroupLicensesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Install
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstallFailureEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListInstallsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LocalizedText
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedConfiguration
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedConfigurationsForDeviceListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedConfigurationsForUserListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedProperty
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedPropertyBundle
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NewDeviceEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NewPermissionsEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Notification
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NotificationSet
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PageInfo
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Permission
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Product
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductApprovalEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductAvailabilityChangeEvent
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductPermission
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductPermissions
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductSet
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductSigningCertificate
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ApproveProductRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GenerateProductApprovalUrlResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProductsListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ServiceAccount
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ServiceAccountKey
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ServiceAccountKeysListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SignupInfo
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StoreCluster
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StoreLayout
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StoreLayoutClustersListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StoreLayoutPagesListResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StorePage
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TokenPagination
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class User
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UserToken
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListUsersResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Administrator
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :email, as: 'email'
        end
      end
      
      class AdministratorWebToken
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :token, as: 'token'
        end
      end
      
      class AdministratorWebTokenSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :parent, as: 'parent'
          collection :permission, as: 'permission'
        end
      end
      
      class AndroidDevicePolicyConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :state, as: 'state'
        end
      end
      
      class AppRestrictionsSchema
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :restrictions, as: 'restrictions', class: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestriction, decorator: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestriction::Representation
      
        end
      end
      
      class AppRestrictionsSchemaChangeEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :product_id, as: 'productId'
        end
      end
      
      class AppRestrictionsSchemaRestriction
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :default_value, as: 'defaultValue', class: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestrictionRestrictionValue, decorator: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestrictionRestrictionValue::Representation
      
          property :description, as: 'description'
          collection :entry, as: 'entry'
          collection :entry_value, as: 'entryValue'
          property :key, as: 'key'
          collection :nested_restriction, as: 'nestedRestriction', class: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestriction, decorator: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestriction::Representation
      
          property :restriction_type, as: 'restrictionType'
          property :title, as: 'title'
        end
      end
      
      class AppRestrictionsSchemaRestrictionRestrictionValue
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :type, as: 'type'
          property :value_bool, as: 'valueBool'
          property :value_integer, as: 'valueInteger'
          collection :value_multiselect, as: 'valueMultiselect'
          property :value_string, as: 'valueString'
        end
      end
      
      class AppUpdateEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :product_id, as: 'productId'
        end
      end
      
      class AppVersion
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :version_code, as: 'versionCode'
          property :version_string, as: 'versionString'
        end
      end
      
      class ApprovalUrlInfo
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :approval_url, as: 'approvalUrl'
          property :kind, as: 'kind'
        end
      end
      
      class AuthenticationToken
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :token, as: 'token'
        end
      end
      
      class Device
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :android_id, as: 'androidId'
          property :kind, as: 'kind'
          property :management_type, as: 'managementType'
        end
      end
      
      class DeviceState
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :account_state, as: 'accountState'
          property :kind, as: 'kind'
        end
      end
      
      class ListDevicesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :device, as: 'device', class: Google::Apis::AndroidenterpriseV1::Device, decorator: Google::Apis::AndroidenterpriseV1::Device::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class Enterprise
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :administrator, as: 'administrator', class: Google::Apis::AndroidenterpriseV1::Administrator, decorator: Google::Apis::AndroidenterpriseV1::Administrator::Representation
      
          property :id, as: 'id'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :primary_domain, as: 'primaryDomain'
        end
      end
      
      class EnterpriseAccount
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :account_email, as: 'accountEmail'
          property :kind, as: 'kind'
        end
      end
      
      class ListEnterprisesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :enterprise, as: 'enterprise', class: Google::Apis::AndroidenterpriseV1::Enterprise, decorator: Google::Apis::AndroidenterpriseV1::Enterprise::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class SendTestPushNotificationResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :message_id, as: 'messageId'
          property :topic_name, as: 'topicName'
        end
      end
      
      class Entitlement
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :product_id, as: 'productId'
          property :reason, as: 'reason'
        end
      end
      
      class ListEntitlementsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :entitlement, as: 'entitlement', class: Google::Apis::AndroidenterpriseV1::Entitlement, decorator: Google::Apis::AndroidenterpriseV1::Entitlement::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class GroupLicense
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :acquisition_kind, as: 'acquisitionKind'
          property :approval, as: 'approval'
          property :kind, as: 'kind'
          property :num_provisioned, as: 'numProvisioned'
          property :num_purchased, as: 'numPurchased'
          property :permissions, as: 'permissions'
          property :product_id, as: 'productId'
        end
      end
      
      class ListGroupLicenseUsersResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :user, as: 'user', class: Google::Apis::AndroidenterpriseV1::User, decorator: Google::Apis::AndroidenterpriseV1::User::Representation
      
        end
      end
      
      class ListGroupLicensesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :group_license, as: 'groupLicense', class: Google::Apis::AndroidenterpriseV1::GroupLicense, decorator: Google::Apis::AndroidenterpriseV1::GroupLicense::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class Install
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :install_state, as: 'installState'
          property :kind, as: 'kind'
          property :product_id, as: 'productId'
          property :version_code, as: 'versionCode'
        end
      end
      
      class InstallFailureEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :device_id, as: 'deviceId'
          property :failure_details, as: 'failureDetails'
          property :failure_reason, as: 'failureReason'
          property :product_id, as: 'productId'
          property :user_id, as: 'userId'
        end
      end
      
      class ListInstallsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :install, as: 'install', class: Google::Apis::AndroidenterpriseV1::Install, decorator: Google::Apis::AndroidenterpriseV1::Install::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class LocalizedText
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :locale, as: 'locale'
          property :text, as: 'text'
        end
      end
      
      class ManagedConfiguration
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :managed_property, as: 'managedProperty', class: Google::Apis::AndroidenterpriseV1::ManagedProperty, decorator: Google::Apis::AndroidenterpriseV1::ManagedProperty::Representation
      
          property :product_id, as: 'productId'
        end
      end
      
      class ManagedConfigurationsForDeviceListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :managed_configuration_for_device, as: 'managedConfigurationForDevice', class: Google::Apis::AndroidenterpriseV1::ManagedConfiguration, decorator: Google::Apis::AndroidenterpriseV1::ManagedConfiguration::Representation
      
        end
      end
      
      class ManagedConfigurationsForUserListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :managed_configuration_for_user, as: 'managedConfigurationForUser', class: Google::Apis::AndroidenterpriseV1::ManagedConfiguration, decorator: Google::Apis::AndroidenterpriseV1::ManagedConfiguration::Representation
      
        end
      end
      
      class ManagedProperty
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :key, as: 'key'
          property :value_bool, as: 'valueBool'
          property :value_bundle, as: 'valueBundle', class: Google::Apis::AndroidenterpriseV1::ManagedPropertyBundle, decorator: Google::Apis::AndroidenterpriseV1::ManagedPropertyBundle::Representation
      
          collection :value_bundle_array, as: 'valueBundleArray', class: Google::Apis::AndroidenterpriseV1::ManagedPropertyBundle, decorator: Google::Apis::AndroidenterpriseV1::ManagedPropertyBundle::Representation
      
          property :value_integer, as: 'valueInteger'
          property :value_string, as: 'valueString'
          collection :value_string_array, as: 'valueStringArray'
        end
      end
      
      class ManagedPropertyBundle
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :managed_property, as: 'managedProperty', class: Google::Apis::AndroidenterpriseV1::ManagedProperty, decorator: Google::Apis::AndroidenterpriseV1::ManagedProperty::Representation
      
        end
      end
      
      class NewDeviceEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :device_id, as: 'deviceId'
          property :management_type, as: 'managementType'
          property :user_id, as: 'userId'
        end
      end
      
      class NewPermissionsEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :approved_permissions, as: 'approvedPermissions'
          property :product_id, as: 'productId'
          collection :requested_permissions, as: 'requestedPermissions'
        end
      end
      
      class Notification
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :app_restrictions_schema_change_event, as: 'appRestrictionsSchemaChangeEvent', class: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaChangeEvent, decorator: Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaChangeEvent::Representation
      
          property :app_update_event, as: 'appUpdateEvent', class: Google::Apis::AndroidenterpriseV1::AppUpdateEvent, decorator: Google::Apis::AndroidenterpriseV1::AppUpdateEvent::Representation
      
          property :enterprise_id, as: 'enterpriseId'
          property :install_failure_event, as: 'installFailureEvent', class: Google::Apis::AndroidenterpriseV1::InstallFailureEvent, decorator: Google::Apis::AndroidenterpriseV1::InstallFailureEvent::Representation
      
          property :new_device_event, as: 'newDeviceEvent', class: Google::Apis::AndroidenterpriseV1::NewDeviceEvent, decorator: Google::Apis::AndroidenterpriseV1::NewDeviceEvent::Representation
      
          property :new_permissions_event, as: 'newPermissionsEvent', class: Google::Apis::AndroidenterpriseV1::NewPermissionsEvent, decorator: Google::Apis::AndroidenterpriseV1::NewPermissionsEvent::Representation
      
          property :notification_type, as: 'notificationType'
          property :product_approval_event, as: 'productApprovalEvent', class: Google::Apis::AndroidenterpriseV1::ProductApprovalEvent, decorator: Google::Apis::AndroidenterpriseV1::ProductApprovalEvent::Representation
      
          property :product_availability_change_event, as: 'productAvailabilityChangeEvent', class: Google::Apis::AndroidenterpriseV1::ProductAvailabilityChangeEvent, decorator: Google::Apis::AndroidenterpriseV1::ProductAvailabilityChangeEvent::Representation
      
          property :timestamp_millis, :numeric_string => true, as: 'timestampMillis'
        end
      end
      
      class NotificationSet
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :notification, as: 'notification', class: Google::Apis::AndroidenterpriseV1::Notification, decorator: Google::Apis::AndroidenterpriseV1::Notification::Representation
      
          property :notification_set_id, as: 'notificationSetId'
        end
      end
      
      class PageInfo
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :result_per_page, as: 'resultPerPage'
          property :start_index, as: 'startIndex'
          property :total_results, as: 'totalResults'
        end
      end
      
      class Permission
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          property :kind, as: 'kind'
          property :name, as: 'name'
          property :permission_id, as: 'permissionId'
        end
      end
      
      class Product
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :app_version, as: 'appVersion', class: Google::Apis::AndroidenterpriseV1::AppVersion, decorator: Google::Apis::AndroidenterpriseV1::AppVersion::Representation
      
          property :author_name, as: 'authorName'
          property :details_url, as: 'detailsUrl'
          property :distribution_channel, as: 'distributionChannel'
          property :icon_url, as: 'iconUrl'
          property :kind, as: 'kind'
          property :product_id, as: 'productId'
          property :product_pricing, as: 'productPricing'
          property :requires_container_app, as: 'requiresContainerApp'
          property :signing_certificate, as: 'signingCertificate', class: Google::Apis::AndroidenterpriseV1::ProductSigningCertificate, decorator: Google::Apis::AndroidenterpriseV1::ProductSigningCertificate::Representation
      
          property :small_icon_url, as: 'smallIconUrl'
          property :title, as: 'title'
          property :work_details_url, as: 'workDetailsUrl'
        end
      end
      
      class ProductApprovalEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :approved, as: 'approved'
          property :product_id, as: 'productId'
        end
      end
      
      class ProductAvailabilityChangeEvent
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :availability_status, as: 'availabilityStatus'
          property :product_id, as: 'productId'
        end
      end
      
      class ProductPermission
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :permission_id, as: 'permissionId'
          property :state, as: 'state'
        end
      end
      
      class ProductPermissions
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :permission, as: 'permission', class: Google::Apis::AndroidenterpriseV1::ProductPermission, decorator: Google::Apis::AndroidenterpriseV1::ProductPermission::Representation
      
          property :product_id, as: 'productId'
        end
      end
      
      class ProductSet
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :product_id, as: 'productId'
          property :product_set_behavior, as: 'productSetBehavior'
        end
      end
      
      class ProductSigningCertificate
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :certificate_hash_sha1, as: 'certificateHashSha1'
          property :certificate_hash_sha256, as: 'certificateHashSha256'
        end
      end
      
      class ApproveProductRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :approval_url_info, as: 'approvalUrlInfo', class: Google::Apis::AndroidenterpriseV1::ApprovalUrlInfo, decorator: Google::Apis::AndroidenterpriseV1::ApprovalUrlInfo::Representation
      
          property :approved_permissions, as: 'approvedPermissions'
        end
      end
      
      class GenerateProductApprovalUrlResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :url, as: 'url'
        end
      end
      
      class ProductsListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :page_info, as: 'pageInfo', class: Google::Apis::AndroidenterpriseV1::PageInfo, decorator: Google::Apis::AndroidenterpriseV1::PageInfo::Representation
      
          collection :product, as: 'product', class: Google::Apis::AndroidenterpriseV1::Product, decorator: Google::Apis::AndroidenterpriseV1::Product::Representation
      
          property :token_pagination, as: 'tokenPagination', class: Google::Apis::AndroidenterpriseV1::TokenPagination, decorator: Google::Apis::AndroidenterpriseV1::TokenPagination::Representation
      
        end
      end
      
      class ServiceAccount
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :key, as: 'key', class: Google::Apis::AndroidenterpriseV1::ServiceAccountKey, decorator: Google::Apis::AndroidenterpriseV1::ServiceAccountKey::Representation
      
          property :kind, as: 'kind'
          property :name, as: 'name'
        end
      end
      
      class ServiceAccountKey
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :data, as: 'data'
          property :id, as: 'id'
          property :kind, as: 'kind'
          property :public_data, as: 'publicData'
          property :type, as: 'type'
        end
      end
      
      class ServiceAccountKeysListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :service_account_key, as: 'serviceAccountKey', class: Google::Apis::AndroidenterpriseV1::ServiceAccountKey, decorator: Google::Apis::AndroidenterpriseV1::ServiceAccountKey::Representation
      
        end
      end
      
      class SignupInfo
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :completion_token, as: 'completionToken'
          property :kind, as: 'kind'
          property :url, as: 'url'
        end
      end
      
      class StoreCluster
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          property :kind, as: 'kind'
          collection :name, as: 'name', class: Google::Apis::AndroidenterpriseV1::LocalizedText, decorator: Google::Apis::AndroidenterpriseV1::LocalizedText::Representation
      
          property :order_in_page, as: 'orderInPage'
          collection :product_id, as: 'productId'
        end
      end
      
      class StoreLayout
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :homepage_id, as: 'homepageId'
          property :kind, as: 'kind'
          property :store_layout_type, as: 'storeLayoutType'
        end
      end
      
      class StoreLayoutClustersListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :cluster, as: 'cluster', class: Google::Apis::AndroidenterpriseV1::StoreCluster, decorator: Google::Apis::AndroidenterpriseV1::StoreCluster::Representation
      
          property :kind, as: 'kind'
        end
      end
      
      class StoreLayoutPagesListResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :page, as: 'page', class: Google::Apis::AndroidenterpriseV1::StorePage, decorator: Google::Apis::AndroidenterpriseV1::StorePage::Representation
      
        end
      end
      
      class StorePage
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          property :kind, as: 'kind'
          collection :link, as: 'link'
          collection :name, as: 'name', class: Google::Apis::AndroidenterpriseV1::LocalizedText, decorator: Google::Apis::AndroidenterpriseV1::LocalizedText::Representation
      
        end
      end
      
      class TokenPagination
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :next_page_token, as: 'nextPageToken'
          property :previous_page_token, as: 'previousPageToken'
        end
      end
      
      class User
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :account_identifier, as: 'accountIdentifier'
          property :account_type, as: 'accountType'
          property :display_name, as: 'displayName'
          property :id, as: 'id'
          property :kind, as: 'kind'
          property :management_type, as: 'managementType'
          property :primary_email, as: 'primaryEmail'
        end
      end
      
      class UserToken
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :token, as: 'token'
          property :user_id, as: 'userId'
        end
      end
      
      class ListUsersResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          collection :user, as: 'user', class: Google::Apis::AndroidenterpriseV1::User, decorator: Google::Apis::AndroidenterpriseV1::User::Representation
      
        end
      end
    end
  end
end
