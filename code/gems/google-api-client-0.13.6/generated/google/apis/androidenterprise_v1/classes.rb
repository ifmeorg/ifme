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
      
      # This represents an enterprise admin who can manage the enterprise in the
      # managed Google Play store.
      class Administrator
        include Google::Apis::Core::Hashable
      
        # The admin's email address.
        # Corresponds to the JSON property `email`
        # @return [String]
        attr_accessor :email
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @email = args[:email] if args.key?(:email)
        end
      end
      
      # A token authorizing an admin to access an iframe.
      class AdministratorWebToken
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#administratorWebToken".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # An opaque token to be passed to the Play front-end to generate an iframe.
        # Corresponds to the JSON property `token`
        # @return [String]
        attr_accessor :token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @token = args[:token] if args.key?(:token)
        end
      end
      
      # Specification for a token used to generate iframes. The token specifies what
      # data the admin is allowed to modify and the URI the iframe is allowed to
      # communiate with.
      class AdministratorWebTokenSpec
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#administratorWebTokenSpec".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The URI of the parent frame hosting the iframe. To prevent XSS, the iframe may
        # not be hosted at other URIs. This URI must be https.
        # Corresponds to the JSON property `parent`
        # @return [String]
        attr_accessor :parent
      
        # The list of permissions the admin is granted within the iframe. The admin will
        # only be allowed to view an iframe if they have all of the permissions
        # associated with it. The only valid value is "approveApps" that will allow the
        # admin to access the iframe in "approve" mode.
        # Corresponds to the JSON property `permission`
        # @return [Array<String>]
        attr_accessor :permission
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @parent = args[:parent] if args.key?(:parent)
          @permission = args[:permission] if args.key?(:permission)
        end
      end
      
      # The Android Device Policy configuration of an enterprise.
      class AndroidDevicePolicyConfig
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#androidDevicePolicyConfig".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The state of Android Device Policy. "enabled" indicates that Android Device
        # Policy is enabled for the enterprise and the EMM is allowed to manage devices
        # with Android Device Policy, while "disabled" means that it cannot.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @state = args[:state] if args.key?(:state)
        end
      end
      
      # Represents the list of app restrictions available to be pre-configured for the
      # product.
      class AppRestrictionsSchema
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#appRestrictionsSchema".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The set of restrictions that make up this schema.
        # Corresponds to the JSON property `restrictions`
        # @return [Array<Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestriction>]
        attr_accessor :restrictions
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @restrictions = args[:restrictions] if args.key?(:restrictions)
        end
      end
      
      # An event generated when a new app version is uploaded to Google Play and its
      # app restrictions schema changed. To fetch the app restrictions schema for an
      # app, use Products.getAppRestrictionsSchema on the EMM API.
      class AppRestrictionsSchemaChangeEvent
        include Google::Apis::Core::Hashable
      
        # The id of the product (e.g. "app:com.google.android.gm") for which the app
        # restriction schema changed. This field will always be present.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # A restriction in the App Restriction Schema represents a piece of
      # configuration that may be pre-applied.
      class AppRestrictionsSchemaRestriction
        include Google::Apis::Core::Hashable
      
        # A typed value for the restriction.
        # Corresponds to the JSON property `defaultValue`
        # @return [Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestrictionRestrictionValue]
        attr_accessor :default_value
      
        # A longer description of the restriction, giving more detail of what it affects.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # For choice or multiselect restrictions, the list of possible entries' human-
        # readable names.
        # Corresponds to the JSON property `entry`
        # @return [Array<String>]
        attr_accessor :entry
      
        # For choice or multiselect restrictions, the list of possible entries' machine-
        # readable values. These values should be used in the configuration, either as a
        # single string value for a choice restriction or in a stringArray for a
        # multiselect restriction.
        # Corresponds to the JSON property `entryValue`
        # @return [Array<String>]
        attr_accessor :entry_value
      
        # The unique key that the product uses to identify the restriction, e.g. "com.
        # google.android.gm.fieldname".
        # Corresponds to the JSON property `key`
        # @return [String]
        attr_accessor :key
      
        # For bundle or bundleArray restrictions, the list of nested restrictions. A
        # bundle restriction is always nested within a bundleArray restriction, and a
        # bundleArray restriction is at most two levels deep.
        # Corresponds to the JSON property `nestedRestriction`
        # @return [Array<Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaRestriction>]
        attr_accessor :nested_restriction
      
        # The type of the restriction.
        # Corresponds to the JSON property `restrictionType`
        # @return [String]
        attr_accessor :restriction_type
      
        # The name of the restriction.
        # Corresponds to the JSON property `title`
        # @return [String]
        attr_accessor :title
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_value = args[:default_value] if args.key?(:default_value)
          @description = args[:description] if args.key?(:description)
          @entry = args[:entry] if args.key?(:entry)
          @entry_value = args[:entry_value] if args.key?(:entry_value)
          @key = args[:key] if args.key?(:key)
          @nested_restriction = args[:nested_restriction] if args.key?(:nested_restriction)
          @restriction_type = args[:restriction_type] if args.key?(:restriction_type)
          @title = args[:title] if args.key?(:title)
        end
      end
      
      # A typed value for the restriction.
      class AppRestrictionsSchemaRestrictionRestrictionValue
        include Google::Apis::Core::Hashable
      
        # The type of the value being provided.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        # The boolean value - this will only be present if type is bool.
        # Corresponds to the JSON property `valueBool`
        # @return [Boolean]
        attr_accessor :value_bool
        alias_method :value_bool?, :value_bool
      
        # The integer value - this will only be present if type is integer.
        # Corresponds to the JSON property `valueInteger`
        # @return [Fixnum]
        attr_accessor :value_integer
      
        # The list of string values - this will only be present if type is multiselect.
        # Corresponds to the JSON property `valueMultiselect`
        # @return [Array<String>]
        attr_accessor :value_multiselect
      
        # The string value - this will be present for types string, choice and hidden.
        # Corresponds to the JSON property `valueString`
        # @return [String]
        attr_accessor :value_string
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @type = args[:type] if args.key?(:type)
          @value_bool = args[:value_bool] if args.key?(:value_bool)
          @value_integer = args[:value_integer] if args.key?(:value_integer)
          @value_multiselect = args[:value_multiselect] if args.key?(:value_multiselect)
          @value_string = args[:value_string] if args.key?(:value_string)
        end
      end
      
      # An event generated when a new version of an app is uploaded to Google Play.
      # Notifications are sent for new public versions only: alpha, beta, or canary
      # versions do not generate this event. To fetch up-to-date version history for
      # an app, use Products.Get on the EMM API.
      class AppUpdateEvent
        include Google::Apis::Core::Hashable
      
        # The id of the product (e.g. "app:com.google.android.gm") that was updated.
        # This field will always be present.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # This represents a single version of the app.
      class AppVersion
        include Google::Apis::Core::Hashable
      
        # Unique increasing identifier for the app version.
        # Corresponds to the JSON property `versionCode`
        # @return [Fixnum]
        attr_accessor :version_code
      
        # The string used in the Play store by the app developer to identify the version.
        # The string is not necessarily unique or localized (for example, the string
        # could be "1.4").
        # Corresponds to the JSON property `versionString`
        # @return [String]
        attr_accessor :version_string
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @version_code = args[:version_code] if args.key?(:version_code)
          @version_string = args[:version_string] if args.key?(:version_string)
        end
      end
      
      # Information on an approval URL.
      class ApprovalUrlInfo
        include Google::Apis::Core::Hashable
      
        # A URL that displays a product's permissions and that can also be used to
        # approve the product with the Products.approve call.
        # Corresponds to the JSON property `approvalUrl`
        # @return [String]
        attr_accessor :approval_url
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#approvalUrlInfo".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @approval_url = args[:approval_url] if args.key?(:approval_url)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # An AuthenticationToken is used by the EMM's device policy client on a device
      # to provision the given EMM-managed user on that device.
      class AuthenticationToken
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#authenticationToken".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The authentication token to be passed to the device policy client on the
        # device where it can be used to provision the account for which this token was
        # generated.
        # Corresponds to the JSON property `token`
        # @return [String]
        attr_accessor :token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @token = args[:token] if args.key?(:token)
        end
      end
      
      # A Devices resource represents a mobile device managed by the EMM and belonging
      # to a specific enterprise user.
      # This collection cannot be modified via the API. It is automatically populated
      # as devices are set up to be managed.
      class Device
        include Google::Apis::Core::Hashable
      
        # The Google Play Services Android ID for the device encoded as a lowercase hex
        # string. For example, "123456789abcdef0".
        # Corresponds to the JSON property `androidId`
        # @return [String]
        attr_accessor :android_id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#device".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Identifies the extent to which the device is controlled by a managed Google
        # Play EMM in various deployment configurations.
        # Possible values include:
        # - "managedDevice", a device that has the EMM's device policy controller (DPC)
        # as the device owner.
        # - "managedProfile", a device that has a profile managed by the DPC (DPC is
        # profile owner) in addition to a separate, personal profile that is unavailable
        # to the DPC.
        # - "containerApp", no longer used (deprecated).
        # - "unmanagedProfile", a device that has been allowed (by the domain's admin,
        # using the Admin Console to enable the privilege) to use managed Google Play,
        # but the profile is itself not owned by a DPC.
        # Corresponds to the JSON property `managementType`
        # @return [String]
        attr_accessor :management_type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @android_id = args[:android_id] if args.key?(:android_id)
          @kind = args[:kind] if args.key?(:kind)
          @management_type = args[:management_type] if args.key?(:management_type)
        end
      end
      
      # The state of a user's device, as accessed by the getState and setState methods
      # on device resources.
      class DeviceState
        include Google::Apis::Core::Hashable
      
        # The state of the Google account on the device. "enabled" indicates that the
        # Google account on the device can be used to access Google services (including
        # Google Play), while "disabled" means that it cannot. A new device is initially
        # in the "disabled" state.
        # Corresponds to the JSON property `accountState`
        # @return [String]
        attr_accessor :account_state
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#deviceState".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @account_state = args[:account_state] if args.key?(:account_state)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # The device resources for the user.
      class ListDevicesResponse
        include Google::Apis::Core::Hashable
      
        # A managed device.
        # Corresponds to the JSON property `device`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Device>]
        attr_accessor :device
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#devicesListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @device = args[:device] if args.key?(:device)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # An Enterprises resource represents the binding between an EMM and a specific
      # organization. That binding can be instantiated in one of two different ways
      # using this API as follows:
      # - For Google managed domain customers, the process involves using Enterprises.
      # enroll and Enterprises.setAccount (in conjunction with artifacts obtained from
      # the Admin console and the Google API Console) and submitted to the EMM through
      # a more-or-less manual process.
      # - For managed Google Play Accounts customers, the process involves using
      # Enterprises.generateSignupUrl and Enterprises.completeSignup in conjunction
      # with the managed Google Play sign-up UI (Google-provided mechanism) to create
      # the binding without manual steps. As an EMM, you can support either or both
      # approaches in your EMM console. See Create an Enterprise for details.
      class Enterprise
        include Google::Apis::Core::Hashable
      
        # Admins of the enterprise. This is only supported for enterprises created via
        # the EMM-initiated flow.
        # Corresponds to the JSON property `administrator`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Administrator>]
        attr_accessor :administrator
      
        # The unique ID for the enterprise.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#enterprise".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The name of the enterprise, for example, "Example, Inc".
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The enterprise's primary domain, such as "example.com".
        # Corresponds to the JSON property `primaryDomain`
        # @return [String]
        attr_accessor :primary_domain
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @administrator = args[:administrator] if args.key?(:administrator)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @name = args[:name] if args.key?(:name)
          @primary_domain = args[:primary_domain] if args.key?(:primary_domain)
        end
      end
      
      # A service account that can be used to authenticate as the enterprise to API
      # calls that require such authentication.
      class EnterpriseAccount
        include Google::Apis::Core::Hashable
      
        # The email address of the service account.
        # Corresponds to the JSON property `accountEmail`
        # @return [String]
        attr_accessor :account_email
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#enterpriseAccount".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @account_email = args[:account_email] if args.key?(:account_email)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # The matching enterprise resources.
      class ListEnterprisesResponse
        include Google::Apis::Core::Hashable
      
        # An enterprise.
        # Corresponds to the JSON property `enterprise`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Enterprise>]
        attr_accessor :enterprise
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#enterprisesListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @enterprise = args[:enterprise] if args.key?(:enterprise)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # 
      class SendTestPushNotificationResponse
        include Google::Apis::Core::Hashable
      
        # The message ID of the test push notification that was sent.
        # Corresponds to the JSON property `messageId`
        # @return [String]
        attr_accessor :message_id
      
        # The name of the Cloud Pub/Sub topic to which notifications for this enterprise'
        # s enrolled account will be sent.
        # Corresponds to the JSON property `topicName`
        # @return [String]
        attr_accessor :topic_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @message_id = args[:message_id] if args.key?(:message_id)
          @topic_name = args[:topic_name] if args.key?(:topic_name)
        end
      end
      
      # The presence of an Entitlements resource indicates that a user has the right
      # to use a particular app. Entitlements are user specific, not device specific.
      # This allows a user with an entitlement to an app to install the app on all
      # their devices. It's also possible for a user to hold an entitlement to an app
      # without installing the app on any device.
      # The API can be used to create an entitlement. As an option, you can also use
      # the API to trigger the installation of an app on all a user's managed devices
      # at the same time the entitlement is created.
      # If the app is free, creating the entitlement also creates a group license for
      # that app. For paid apps, creating the entitlement consumes one license, and
      # that license remains consumed until the entitlement is removed. If the
      # enterprise hasn't purchased enough licenses, then no entitlement is created
      # and the installation fails. An entitlement is also not created for an app if
      # the app requires permissions that the enterprise hasn't accepted.
      # If an entitlement is deleted, the app may be uninstalled from a user's device.
      # As a best practice, uninstall the app by calling  Installs.delete() before
      # deleting the entitlement.
      # Entitlements for apps that a user pays for on an unmanaged profile have "
      # userPurchase" as the entitlement reason. These entitlements cannot be removed
      # via the API.
      class Entitlement
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#entitlement".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The ID of the product that the entitlement is for. For example, "app:com.
        # google.android.gm".
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # The reason for the entitlement. For example, "free" for free apps. This
        # property is temporary: it will be replaced by the acquisition kind field of
        # group licenses.
        # Corresponds to the JSON property `reason`
        # @return [String]
        attr_accessor :reason
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @product_id = args[:product_id] if args.key?(:product_id)
          @reason = args[:reason] if args.key?(:reason)
        end
      end
      
      # The entitlement resources for the user.
      class ListEntitlementsResponse
        include Google::Apis::Core::Hashable
      
        # An entitlement of a user to a product (e.g. an app). For example, a free app
        # that they have installed, or a paid app that they have been allocated a
        # license to.
        # Corresponds to the JSON property `entitlement`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Entitlement>]
        attr_accessor :entitlement
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#entitlementsListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @entitlement = args[:entitlement] if args.key?(:entitlement)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # Group license objects allow you to keep track of licenses (called entitlements)
      # for both free and paid apps. For a free app, a group license is created when
      # an enterprise admin first approves the product in Google Play or when the
      # first entitlement for the product is created for a user via the API. For a
      # paid app, a group license object is only created when an enterprise admin
      # purchases the product in Google Play for the first time.
      # Use the API to query group licenses. A Grouplicenses resource includes the
      # total number of licenses purchased (paid apps only) and the total number of
      # licenses currently in use. Iyn other words, the total number of Entitlements
      # that exist for the product.
      # Only one group license object is created per product and group license objects
      # are never deleted. If a product is unapproved, its group license remains. This
      # allows enterprise admins to keep track of any remaining entitlements for the
      # product.
      class GroupLicense
        include Google::Apis::Core::Hashable
      
        # How this group license was acquired. "bulkPurchase" means that this
        # Grouplicenses resource was created because the enterprise purchased licenses
        # for this product; otherwise, the value is "free" (for free products).
        # Corresponds to the JSON property `acquisitionKind`
        # @return [String]
        attr_accessor :acquisition_kind
      
        # Whether the product to which this group license relates is currently approved
        # by the enterprise. Products are approved when a group license is first created,
        # but this approval may be revoked by an enterprise admin via Google Play.
        # Unapproved products will not be visible to end users in collections, and new
        # entitlements to them should not normally be created.
        # Corresponds to the JSON property `approval`
        # @return [String]
        attr_accessor :approval
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#groupLicense".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The total number of provisioned licenses for this product. Returned by read
        # operations, but ignored in write operations.
        # Corresponds to the JSON property `numProvisioned`
        # @return [Fixnum]
        attr_accessor :num_provisioned
      
        # The number of purchased licenses (possibly in multiple purchases). If this
        # field is omitted, then there is no limit on the number of licenses that can be
        # provisioned (for example, if the acquisition kind is "free").
        # Corresponds to the JSON property `numPurchased`
        # @return [Fixnum]
        attr_accessor :num_purchased
      
        # The permission approval status of the product. This field is only set if the
        # product is approved. Possible states are:
        # - "currentApproved", the current set of permissions is approved, but
        # additional permissions will require the administrator to reapprove the product
        # (If the product was approved without specifying the approved permissions
        # setting, then this is the default behavior.),
        # - "needsReapproval", the product has unapproved permissions. No additional
        # product licenses can be assigned until the product is reapproved,
        # - "allCurrentAndFutureApproved", the current permissions are approved and any
        # future permission updates will be automatically approved without administrator
        # review.
        # Corresponds to the JSON property `permissions`
        # @return [String]
        attr_accessor :permissions
      
        # The ID of the product that the license is for. For example, "app:com.google.
        # android.gm".
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @acquisition_kind = args[:acquisition_kind] if args.key?(:acquisition_kind)
          @approval = args[:approval] if args.key?(:approval)
          @kind = args[:kind] if args.key?(:kind)
          @num_provisioned = args[:num_provisioned] if args.key?(:num_provisioned)
          @num_purchased = args[:num_purchased] if args.key?(:num_purchased)
          @permissions = args[:permissions] if args.key?(:permissions)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # The user resources for the group license.
      class ListGroupLicenseUsersResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#groupLicenseUsersListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A user of an enterprise.
        # Corresponds to the JSON property `user`
        # @return [Array<Google::Apis::AndroidenterpriseV1::User>]
        attr_accessor :user
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @user = args[:user] if args.key?(:user)
        end
      end
      
      # The grouplicense resources for the enterprise.
      class ListGroupLicensesResponse
        include Google::Apis::Core::Hashable
      
        # A group license for a product approved for use in the enterprise.
        # Corresponds to the JSON property `groupLicense`
        # @return [Array<Google::Apis::AndroidenterpriseV1::GroupLicense>]
        attr_accessor :group_license
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#groupLicensesListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @group_license = args[:group_license] if args.key?(:group_license)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # The existence of an Installs resource indicates that an app is installed on a
      # particular device (or that an install is pending).
      # The API can be used to create an install resource using the update method.
      # This triggers the actual install of the app on the device. If the user does
      # not already have an entitlement for the app, then an attempt is made to create
      # one. If this fails (for example, because the app is not free and there is no
      # available license), then the creation of the install fails.
      # The API can also be used to update an installed app. If the update method is
      # used on an existing install, then the app will be updated to the latest
      # available version.
      # Note that it is not possible to force the installation of a specific version
      # of an app: the version code is read-only.
      # If a user installs an app themselves (as permitted by the enterprise), then
      # again an install resource and possibly an entitlement resource are
      # automatically created.
      # The API can also be used to delete an install resource, which triggers the
      # removal of the app from the device. Note that deleting an install does not
      # automatically remove the corresponding entitlement, even if there are no
      # remaining installs. The install resource will also be deleted if the user
      # uninstalls the app themselves.
      class Install
        include Google::Apis::Core::Hashable
      
        # Install state. The state "installPending" means that an install request has
        # recently been made and download to the device is in progress. The state "
        # installed" means that the app has been installed. This field is read-only.
        # Corresponds to the JSON property `installState`
        # @return [String]
        attr_accessor :install_state
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#install".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The ID of the product that the install is for. For example, "app:com.google.
        # android.gm".
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # The version of the installed product. Guaranteed to be set only if the install
        # state is "installed".
        # Corresponds to the JSON property `versionCode`
        # @return [Fixnum]
        attr_accessor :version_code
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @install_state = args[:install_state] if args.key?(:install_state)
          @kind = args[:kind] if args.key?(:kind)
          @product_id = args[:product_id] if args.key?(:product_id)
          @version_code = args[:version_code] if args.key?(:version_code)
        end
      end
      
      # An event generated when an app installation failed on a device
      class InstallFailureEvent
        include Google::Apis::Core::Hashable
      
        # The Android ID of the device. This field will always be present.
        # Corresponds to the JSON property `deviceId`
        # @return [String]
        attr_accessor :device_id
      
        # Additional details on the failure if applicable.
        # Corresponds to the JSON property `failureDetails`
        # @return [String]
        attr_accessor :failure_details
      
        # The reason for the installation failure. This field will always be present.
        # Corresponds to the JSON property `failureReason`
        # @return [String]
        attr_accessor :failure_reason
      
        # The id of the product (e.g. "app:com.google.android.gm") for which the install
        # failure event occured. This field will always be present.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # The ID of the user. This field will always be present.
        # Corresponds to the JSON property `userId`
        # @return [String]
        attr_accessor :user_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @device_id = args[:device_id] if args.key?(:device_id)
          @failure_details = args[:failure_details] if args.key?(:failure_details)
          @failure_reason = args[:failure_reason] if args.key?(:failure_reason)
          @product_id = args[:product_id] if args.key?(:product_id)
          @user_id = args[:user_id] if args.key?(:user_id)
        end
      end
      
      # The install resources for the device.
      class ListInstallsResponse
        include Google::Apis::Core::Hashable
      
        # An installation of an app for a user on a specific device. The existence of an
        # install implies that the user must have an entitlement to the app.
        # Corresponds to the JSON property `install`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Install>]
        attr_accessor :install
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#installsListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @install = args[:install] if args.key?(:install)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # A localized string with its locale.
      class LocalizedText
        include Google::Apis::Core::Hashable
      
        # The BCP47 tag for a locale. (e.g. "en-US", "de").
        # Corresponds to the JSON property `locale`
        # @return [String]
        attr_accessor :locale
      
        # The text localized in the associated locale.
        # Corresponds to the JSON property `text`
        # @return [String]
        attr_accessor :text
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @locale = args[:locale] if args.key?(:locale)
          @text = args[:text] if args.key?(:text)
        end
      end
      
      # A managed configuration resource contains the set of managed properties that
      # have been configured for an Android app. The app's developer would have
      # defined configurable properties in the managed configurations schema.
      class ManagedConfiguration
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#managedConfiguration".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The set of managed properties for this configuration.
        # Corresponds to the JSON property `managedProperty`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ManagedProperty>]
        attr_accessor :managed_property
      
        # The ID of the product that the managed configuration is for, e.g. "app:com.
        # google.android.gm".
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @managed_property = args[:managed_property] if args.key?(:managed_property)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # The managed configuration resources for the device.
      class ManagedConfigurationsForDeviceListResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#managedConfigurationsForDeviceListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A managed configuration for an app on a specific device.
        # Corresponds to the JSON property `managedConfigurationForDevice`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ManagedConfiguration>]
        attr_accessor :managed_configuration_for_device
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @managed_configuration_for_device = args[:managed_configuration_for_device] if args.key?(:managed_configuration_for_device)
        end
      end
      
      # The managed configuration resources for the user.
      class ManagedConfigurationsForUserListResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#managedConfigurationsForUserListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A managed configuration for an app for a specific user.
        # Corresponds to the JSON property `managedConfigurationForUser`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ManagedConfiguration>]
        attr_accessor :managed_configuration_for_user
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @managed_configuration_for_user = args[:managed_configuration_for_user] if args.key?(:managed_configuration_for_user)
        end
      end
      
      # A managed property of a managed configuration. The property must match one of
      # the properties in the app restrictions schema of the product. Exactly one of
      # the value fields must be populated, and it must match the property's type in
      # the app restrictions schema.
      class ManagedProperty
        include Google::Apis::Core::Hashable
      
        # The unique key that identifies the property.
        # Corresponds to the JSON property `key`
        # @return [String]
        attr_accessor :key
      
        # The boolean value - this will only be present if type of the property is bool.
        # Corresponds to the JSON property `valueBool`
        # @return [Boolean]
        attr_accessor :value_bool
        alias_method :value_bool?, :value_bool
      
        # A bundle of managed properties.
        # Corresponds to the JSON property `valueBundle`
        # @return [Google::Apis::AndroidenterpriseV1::ManagedPropertyBundle]
        attr_accessor :value_bundle
      
        # The list of bundles of properties - this will only be present if type of the
        # property is bundle_array.
        # Corresponds to the JSON property `valueBundleArray`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ManagedPropertyBundle>]
        attr_accessor :value_bundle_array
      
        # The integer value - this will only be present if type of the property is
        # integer.
        # Corresponds to the JSON property `valueInteger`
        # @return [Fixnum]
        attr_accessor :value_integer
      
        # The string value - this will only be present if type of the property is string,
        # choice or hidden.
        # Corresponds to the JSON property `valueString`
        # @return [String]
        attr_accessor :value_string
      
        # The list of string values - this will only be present if type of the property
        # is multiselect.
        # Corresponds to the JSON property `valueStringArray`
        # @return [Array<String>]
        attr_accessor :value_string_array
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @key = args[:key] if args.key?(:key)
          @value_bool = args[:value_bool] if args.key?(:value_bool)
          @value_bundle = args[:value_bundle] if args.key?(:value_bundle)
          @value_bundle_array = args[:value_bundle_array] if args.key?(:value_bundle_array)
          @value_integer = args[:value_integer] if args.key?(:value_integer)
          @value_string = args[:value_string] if args.key?(:value_string)
          @value_string_array = args[:value_string_array] if args.key?(:value_string_array)
        end
      end
      
      # A bundle of managed properties.
      class ManagedPropertyBundle
        include Google::Apis::Core::Hashable
      
        # The list of managed properties.
        # Corresponds to the JSON property `managedProperty`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ManagedProperty>]
        attr_accessor :managed_property
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @managed_property = args[:managed_property] if args.key?(:managed_property)
        end
      end
      
      # An event generated when a new device is ready to be managed.
      class NewDeviceEvent
        include Google::Apis::Core::Hashable
      
        # The Android ID of the device. This field will always be present.
        # Corresponds to the JSON property `deviceId`
        # @return [String]
        attr_accessor :device_id
      
        # Identifies the extent to which the device is controlled by an Android EMM in
        # various deployment configurations.
        # Possible values include:
        # - "managedDevice", a device where the DPC is set as device owner,
        # - "managedProfile", a device where the DPC is set as profile owner.
        # Corresponds to the JSON property `managementType`
        # @return [String]
        attr_accessor :management_type
      
        # The ID of the user. This field will always be present.
        # Corresponds to the JSON property `userId`
        # @return [String]
        attr_accessor :user_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @device_id = args[:device_id] if args.key?(:device_id)
          @management_type = args[:management_type] if args.key?(:management_type)
          @user_id = args[:user_id] if args.key?(:user_id)
        end
      end
      
      # An event generated when new permissions are added to an app.
      class NewPermissionsEvent
        include Google::Apis::Core::Hashable
      
        # The set of permissions that the enterprise admin has already approved for this
        # application. Use Permissions.Get on the EMM API to retrieve details about
        # these permissions.
        # Corresponds to the JSON property `approvedPermissions`
        # @return [Array<String>]
        attr_accessor :approved_permissions
      
        # The id of the product (e.g. "app:com.google.android.gm") for which new
        # permissions were added. This field will always be present.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # The set of permissions that the app is currently requesting. Use Permissions.
        # Get on the EMM API to retrieve details about these permissions.
        # Corresponds to the JSON property `requestedPermissions`
        # @return [Array<String>]
        attr_accessor :requested_permissions
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @approved_permissions = args[:approved_permissions] if args.key?(:approved_permissions)
          @product_id = args[:product_id] if args.key?(:product_id)
          @requested_permissions = args[:requested_permissions] if args.key?(:requested_permissions)
        end
      end
      
      # A notification of one event relating to an enterprise.
      class Notification
        include Google::Apis::Core::Hashable
      
        # An event generated when a new app version is uploaded to Google Play and its
        # app restrictions schema changed. To fetch the app restrictions schema for an
        # app, use Products.getAppRestrictionsSchema on the EMM API.
        # Corresponds to the JSON property `appRestrictionsSchemaChangeEvent`
        # @return [Google::Apis::AndroidenterpriseV1::AppRestrictionsSchemaChangeEvent]
        attr_accessor :app_restrictions_schema_change_event
      
        # An event generated when a new version of an app is uploaded to Google Play.
        # Notifications are sent for new public versions only: alpha, beta, or canary
        # versions do not generate this event. To fetch up-to-date version history for
        # an app, use Products.Get on the EMM API.
        # Corresponds to the JSON property `appUpdateEvent`
        # @return [Google::Apis::AndroidenterpriseV1::AppUpdateEvent]
        attr_accessor :app_update_event
      
        # The ID of the enterprise for which the notification is sent. This will always
        # be present.
        # Corresponds to the JSON property `enterpriseId`
        # @return [String]
        attr_accessor :enterprise_id
      
        # An event generated when an app installation failed on a device
        # Corresponds to the JSON property `installFailureEvent`
        # @return [Google::Apis::AndroidenterpriseV1::InstallFailureEvent]
        attr_accessor :install_failure_event
      
        # An event generated when a new device is ready to be managed.
        # Corresponds to the JSON property `newDeviceEvent`
        # @return [Google::Apis::AndroidenterpriseV1::NewDeviceEvent]
        attr_accessor :new_device_event
      
        # An event generated when new permissions are added to an app.
        # Corresponds to the JSON property `newPermissionsEvent`
        # @return [Google::Apis::AndroidenterpriseV1::NewPermissionsEvent]
        attr_accessor :new_permissions_event
      
        # Type of the notification.
        # Corresponds to the JSON property `notificationType`
        # @return [String]
        attr_accessor :notification_type
      
        # An event generated when a product's approval status is changed.
        # Corresponds to the JSON property `productApprovalEvent`
        # @return [Google::Apis::AndroidenterpriseV1::ProductApprovalEvent]
        attr_accessor :product_approval_event
      
        # An event generated whenever a product's availability changes.
        # Corresponds to the JSON property `productAvailabilityChangeEvent`
        # @return [Google::Apis::AndroidenterpriseV1::ProductAvailabilityChangeEvent]
        attr_accessor :product_availability_change_event
      
        # The time when the notification was published in milliseconds since 1970-01-
        # 01T00:00:00Z. This will always be present.
        # Corresponds to the JSON property `timestampMillis`
        # @return [Fixnum]
        attr_accessor :timestamp_millis
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @app_restrictions_schema_change_event = args[:app_restrictions_schema_change_event] if args.key?(:app_restrictions_schema_change_event)
          @app_update_event = args[:app_update_event] if args.key?(:app_update_event)
          @enterprise_id = args[:enterprise_id] if args.key?(:enterprise_id)
          @install_failure_event = args[:install_failure_event] if args.key?(:install_failure_event)
          @new_device_event = args[:new_device_event] if args.key?(:new_device_event)
          @new_permissions_event = args[:new_permissions_event] if args.key?(:new_permissions_event)
          @notification_type = args[:notification_type] if args.key?(:notification_type)
          @product_approval_event = args[:product_approval_event] if args.key?(:product_approval_event)
          @product_availability_change_event = args[:product_availability_change_event] if args.key?(:product_availability_change_event)
          @timestamp_millis = args[:timestamp_millis] if args.key?(:timestamp_millis)
        end
      end
      
      # A resource returned by the PullNotificationSet API, which contains a
      # collection of notifications for enterprises associated with the service
      # account authenticated for the request.
      class NotificationSet
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#notificationSet".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The notifications received, or empty if no notifications are present.
        # Corresponds to the JSON property `notification`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Notification>]
        attr_accessor :notification
      
        # The notification set ID, required to mark the notification as received with
        # the Enterprises.AcknowledgeNotification API. This will be omitted if no
        # notifications are present.
        # Corresponds to the JSON property `notificationSetId`
        # @return [String]
        attr_accessor :notification_set_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @notification = args[:notification] if args.key?(:notification)
          @notification_set_id = args[:notification_set_id] if args.key?(:notification_set_id)
        end
      end
      
      # 
      class PageInfo
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `resultPerPage`
        # @return [Fixnum]
        attr_accessor :result_per_page
      
        # 
        # Corresponds to the JSON property `startIndex`
        # @return [Fixnum]
        attr_accessor :start_index
      
        # 
        # Corresponds to the JSON property `totalResults`
        # @return [Fixnum]
        attr_accessor :total_results
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @result_per_page = args[:result_per_page] if args.key?(:result_per_page)
          @start_index = args[:start_index] if args.key?(:start_index)
          @total_results = args[:total_results] if args.key?(:total_results)
        end
      end
      
      # A Permissions resource represents some extra capability, to be granted to an
      # Android app, which requires explicit consent. An enterprise admin must consent
      # to these permissions on behalf of their users before an entitlement for the
      # app can be created.
      # The permissions collection is read-only. The information provided for each
      # permission (localized name and description) is intended to be used in the MDM
      # user interface when obtaining consent from the enterprise.
      class Permission
        include Google::Apis::Core::Hashable
      
        # A longer description of the Permissions resource, giving more details of what
        # it affects.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#permission".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The name of the permission.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # An opaque string uniquely identifying the permission.
        # Corresponds to the JSON property `permissionId`
        # @return [String]
        attr_accessor :permission_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @description = args[:description] if args.key?(:description)
          @kind = args[:kind] if args.key?(:kind)
          @name = args[:name] if args.key?(:name)
          @permission_id = args[:permission_id] if args.key?(:permission_id)
        end
      end
      
      # A Products resource represents an app in the Google Play store that is
      # available to at least some users in the enterprise. (Some apps are restricted
      # to a single enterprise, and no information about them is made available
      # outside that enterprise.)
      # The information provided for each product (localized name, icon, link to the
      # full Google Play details page) is intended to allow a basic representation of
      # the product within an EMM user interface.
      class Product
        include Google::Apis::Core::Hashable
      
        # App versions currently available for this product.
        # Corresponds to the JSON property `appVersion`
        # @return [Array<Google::Apis::AndroidenterpriseV1::AppVersion>]
        attr_accessor :app_version
      
        # The name of the author of the product (for example, the app developer).
        # Corresponds to the JSON property `authorName`
        # @return [String]
        attr_accessor :author_name
      
        # A link to the (consumer) Google Play details page for the product.
        # Corresponds to the JSON property `detailsUrl`
        # @return [String]
        attr_accessor :details_url
      
        # How and to whom the package is made available. The value publicGoogleHosted
        # means that the package is available through the Play store and not restricted
        # to a specific enterprise. The value privateGoogleHosted means that the package
        # is a private app (restricted to an enterprise) but hosted by Google. The value
        # privateSelfHosted means that the package is a private app (restricted to an
        # enterprise) and is privately hosted.
        # Corresponds to the JSON property `distributionChannel`
        # @return [String]
        attr_accessor :distribution_channel
      
        # A link to an image that can be used as an icon for the product. This image is
        # suitable for use at up to 512px x 512px.
        # Corresponds to the JSON property `iconUrl`
        # @return [String]
        attr_accessor :icon_url
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#product".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A string of the form app:<package name>. For example, app:com.google.android.
        # gm represents the Gmail app.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # Whether this product is free, free with in-app purchases, or paid. If the
        # pricing is unknown, this means the product is not generally available anymore (
        # even though it might still be available to people who own it).
        # Corresponds to the JSON property `productPricing`
        # @return [String]
        attr_accessor :product_pricing
      
        # Deprecated.
        # Corresponds to the JSON property `requiresContainerApp`
        # @return [Boolean]
        attr_accessor :requires_container_app
        alias_method :requires_container_app?, :requires_container_app
      
        # The certificate used to sign this product.
        # Corresponds to the JSON property `signingCertificate`
        # @return [Google::Apis::AndroidenterpriseV1::ProductSigningCertificate]
        attr_accessor :signing_certificate
      
        # A link to a smaller image that can be used as an icon for the product. This
        # image is suitable for use at up to 128px x 128px.
        # Corresponds to the JSON property `smallIconUrl`
        # @return [String]
        attr_accessor :small_icon_url
      
        # The name of the product.
        # Corresponds to the JSON property `title`
        # @return [String]
        attr_accessor :title
      
        # A link to the managed Google Play details page for the product, for use by an
        # Enterprise admin.
        # Corresponds to the JSON property `workDetailsUrl`
        # @return [String]
        attr_accessor :work_details_url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @app_version = args[:app_version] if args.key?(:app_version)
          @author_name = args[:author_name] if args.key?(:author_name)
          @details_url = args[:details_url] if args.key?(:details_url)
          @distribution_channel = args[:distribution_channel] if args.key?(:distribution_channel)
          @icon_url = args[:icon_url] if args.key?(:icon_url)
          @kind = args[:kind] if args.key?(:kind)
          @product_id = args[:product_id] if args.key?(:product_id)
          @product_pricing = args[:product_pricing] if args.key?(:product_pricing)
          @requires_container_app = args[:requires_container_app] if args.key?(:requires_container_app)
          @signing_certificate = args[:signing_certificate] if args.key?(:signing_certificate)
          @small_icon_url = args[:small_icon_url] if args.key?(:small_icon_url)
          @title = args[:title] if args.key?(:title)
          @work_details_url = args[:work_details_url] if args.key?(:work_details_url)
        end
      end
      
      # An event generated when a product's approval status is changed.
      class ProductApprovalEvent
        include Google::Apis::Core::Hashable
      
        # Whether the product was approved or unapproved. This field will always be
        # present.
        # Corresponds to the JSON property `approved`
        # @return [String]
        attr_accessor :approved
      
        # The id of the product (e.g. "app:com.google.android.gm") for which the
        # approval status has changed. This field will always be present.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @approved = args[:approved] if args.key?(:approved)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # An event generated whenever a product's availability changes.
      class ProductAvailabilityChangeEvent
        include Google::Apis::Core::Hashable
      
        # The new state of the product. This field will always be present.
        # Corresponds to the JSON property `availabilityStatus`
        # @return [String]
        attr_accessor :availability_status
      
        # The id of the product (e.g. "app:com.google.android.gm") for which the product
        # availability changed. This field will always be present.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @availability_status = args[:availability_status] if args.key?(:availability_status)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # A product permissions resource represents the set of permissions required by a
      # specific app and whether or not they have been accepted by an enterprise admin.
      # The API can be used to read the set of permissions, and also to update the set
      # to indicate that permissions have been accepted.
      class ProductPermission
        include Google::Apis::Core::Hashable
      
        # An opaque string uniquely identifying the permission.
        # Corresponds to the JSON property `permissionId`
        # @return [String]
        attr_accessor :permission_id
      
        # Whether the permission has been accepted or not.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @permission_id = args[:permission_id] if args.key?(:permission_id)
          @state = args[:state] if args.key?(:state)
        end
      end
      
      # Information about the permissions required by a specific app and whether they
      # have been accepted by the enterprise.
      class ProductPermissions
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#productPermissions".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The permissions required by the app.
        # Corresponds to the JSON property `permission`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ProductPermission>]
        attr_accessor :permission
      
        # The ID of the app that the permissions relate to, e.g. "app:com.google.android.
        # gm".
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @permission = args[:permission] if args.key?(:permission)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # A set of products.
      class ProductSet
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#productSet".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The list of product IDs making up the set of products.
        # Corresponds to the JSON property `productId`
        # @return [Array<String>]
        attr_accessor :product_id
      
        # The interpretation of this product set. "unknown" should never be sent and is
        # ignored if received. "whitelist" means that the user is entitled to access the
        # product set. "includeAll" means that all products are accessible, including
        # products that are approved, products with revoked approval, and products that
        # have never been approved. "allApproved" means that the user is entitled to
        # access all products that are approved for the enterprise. If the value is "
        # allApproved" or "includeAll", the productId field is ignored. If no value is
        # provided, it is interpreted as "whitelist" for backwards compatibility.
        # Further "allApproved" or "includeAll" does not enable automatic visibility of "
        # alpha" or "beta" tracks for Android app. Use ProductVisibility to enable "
        # alpha" or "beta" tracks per user.
        # Corresponds to the JSON property `productSetBehavior`
        # @return [String]
        attr_accessor :product_set_behavior
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @product_id = args[:product_id] if args.key?(:product_id)
          @product_set_behavior = args[:product_set_behavior] if args.key?(:product_set_behavior)
        end
      end
      
      # 
      class ProductSigningCertificate
        include Google::Apis::Core::Hashable
      
        # The base64 urlsafe encoded SHA1 hash of the certificate. (This field is
        # deprecated in favor of SHA2-256. It should not be used and may be removed at
        # any time.)
        # Corresponds to the JSON property `certificateHashSha1`
        # @return [String]
        attr_accessor :certificate_hash_sha1
      
        # The base64 urlsafe encoded SHA2-256 hash of the certificate.
        # Corresponds to the JSON property `certificateHashSha256`
        # @return [String]
        attr_accessor :certificate_hash_sha256
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @certificate_hash_sha1 = args[:certificate_hash_sha1] if args.key?(:certificate_hash_sha1)
          @certificate_hash_sha256 = args[:certificate_hash_sha256] if args.key?(:certificate_hash_sha256)
        end
      end
      
      # 
      class ApproveProductRequest
        include Google::Apis::Core::Hashable
      
        # Information on an approval URL.
        # Corresponds to the JSON property `approvalUrlInfo`
        # @return [Google::Apis::AndroidenterpriseV1::ApprovalUrlInfo]
        attr_accessor :approval_url_info
      
        # Sets how new permission requests for the product are handled. "allPermissions"
        # automatically approves all current and future permissions for the product. "
        # currentPermissionsOnly" approves the current set of permissions for the
        # product, but any future permissions added through updates will require manual
        # reapproval. If not specified, only the current set of permissions will be
        # approved.
        # Corresponds to the JSON property `approvedPermissions`
        # @return [String]
        attr_accessor :approved_permissions
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @approval_url_info = args[:approval_url_info] if args.key?(:approval_url_info)
          @approved_permissions = args[:approved_permissions] if args.key?(:approved_permissions)
        end
      end
      
      # 
      class GenerateProductApprovalUrlResponse
        include Google::Apis::Core::Hashable
      
        # A URL that can be rendered in an iframe to display the permissions (if any) of
        # a product. This URL can be used to approve the product only once and only
        # within 24 hours of being generated, using the Products.approve call. If the
        # product is currently unapproved and has no permissions, this URL will point to
        # an empty page. If the product is currently approved, a URL will only be
        # generated if that product has added permissions since it was last approved,
        # and the URL will only display those new permissions that have not yet been
        # accepted.
        # Corresponds to the JSON property `url`
        # @return [String]
        attr_accessor :url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # The matching products.
      class ProductsListResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#productsListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # General pagination information.
        # Corresponds to the JSON property `pageInfo`
        # @return [Google::Apis::AndroidenterpriseV1::PageInfo]
        attr_accessor :page_info
      
        # Information about a product (e.g. an app) in the Google Play store, for
        # display to an enterprise admin.
        # Corresponds to the JSON property `product`
        # @return [Array<Google::Apis::AndroidenterpriseV1::Product>]
        attr_accessor :product
      
        # Pagination information for token pagination.
        # Corresponds to the JSON property `tokenPagination`
        # @return [Google::Apis::AndroidenterpriseV1::TokenPagination]
        attr_accessor :token_pagination
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @page_info = args[:page_info] if args.key?(:page_info)
          @product = args[:product] if args.key?(:product)
          @token_pagination = args[:token_pagination] if args.key?(:token_pagination)
        end
      end
      
      # A service account identity, including the name and credentials that can be
      # used to authenticate as the service account.
      class ServiceAccount
        include Google::Apis::Core::Hashable
      
        # Credentials that can be used to authenticate as a service account.
        # Corresponds to the JSON property `key`
        # @return [Google::Apis::AndroidenterpriseV1::ServiceAccountKey]
        attr_accessor :key
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#serviceAccount".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The account name of the service account, in the form of an email address.
        # Assigned by the server.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @key = args[:key] if args.key?(:key)
          @kind = args[:kind] if args.key?(:kind)
          @name = args[:name] if args.key?(:name)
        end
      end
      
      # Credentials that can be used to authenticate as a service account.
      class ServiceAccountKey
        include Google::Apis::Core::Hashable
      
        # The body of the private key credentials file, in string format. This is only
        # populated when the ServiceAccountKey is created, and is not stored by Google.
        # Corresponds to the JSON property `data`
        # @return [String]
        attr_accessor :data
      
        # An opaque, unique identifier for this ServiceAccountKey. Assigned by the
        # server.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#serviceAccountKey".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Public key data for the credentials file. This is an X.509 cert. If you are
        # using the googleCredentials key type, this is identical to the cert that can
        # be retrieved by using the X.509 cert url inside of the credentials file.
        # Corresponds to the JSON property `publicData`
        # @return [String]
        attr_accessor :public_data
      
        # The file format of the generated key data.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @data = args[:data] if args.key?(:data)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @public_data = args[:public_data] if args.key?(:public_data)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # 
      class ServiceAccountKeysListResponse
        include Google::Apis::Core::Hashable
      
        # The service account credentials.
        # Corresponds to the JSON property `serviceAccountKey`
        # @return [Array<Google::Apis::AndroidenterpriseV1::ServiceAccountKey>]
        attr_accessor :service_account_key
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @service_account_key = args[:service_account_key] if args.key?(:service_account_key)
        end
      end
      
      # A resource returned by the GenerateSignupUrl API, which contains the Signup
      # URL and Completion Token.
      class SignupInfo
        include Google::Apis::Core::Hashable
      
        # An opaque token that will be required, along with the Enterprise Token, for
        # obtaining the enterprise resource from CompleteSignup.
        # Corresponds to the JSON property `completionToken`
        # @return [String]
        attr_accessor :completion_token
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#signupInfo".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A URL under which the Admin can sign up for an enterprise. The page pointed to
        # cannot be rendered in an iframe.
        # Corresponds to the JSON property `url`
        # @return [String]
        attr_accessor :url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @completion_token = args[:completion_token] if args.key?(:completion_token)
          @kind = args[:kind] if args.key?(:kind)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # Definition of a managed Google Play store cluster, a list of products
      # displayed as part of a store page.
      class StoreCluster
        include Google::Apis::Core::Hashable
      
        # Unique ID of this cluster. Assigned by the server. Immutable once assigned.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#storeCluster".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Ordered list of localized strings giving the name of this page. The text
        # displayed is the one that best matches the user locale, or the first entry if
        # there is no good match. There needs to be at least one entry.
        # Corresponds to the JSON property `name`
        # @return [Array<Google::Apis::AndroidenterpriseV1::LocalizedText>]
        attr_accessor :name
      
        # String (US-ASCII only) used to determine order of this cluster within the
        # parent page's elements. Page elements are sorted in lexicographic order of
        # this field. Duplicated values are allowed, but ordering between elements with
        # duplicate order is undefined.
        # The value of this field is never visible to a user, it is used solely for the
        # purpose of defining an ordering. Maximum length is 256 characters.
        # Corresponds to the JSON property `orderInPage`
        # @return [String]
        attr_accessor :order_in_page
      
        # List of products in the order they are displayed in the cluster. There should
        # not be duplicates within a cluster.
        # Corresponds to the JSON property `productId`
        # @return [Array<String>]
        attr_accessor :product_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @name = args[:name] if args.key?(:name)
          @order_in_page = args[:order_in_page] if args.key?(:order_in_page)
          @product_id = args[:product_id] if args.key?(:product_id)
        end
      end
      
      # General setting for the managed Google Play store layout, currently only
      # specifying the page to display the first time the store is opened.
      class StoreLayout
        include Google::Apis::Core::Hashable
      
        # The ID of the store page to be used as the homepage. The homepage is the first
        # page shown in the managed Google Play Store.
        # Not specifying a homepage is equivalent to setting the store layout type to "
        # basic".
        # Corresponds to the JSON property `homepageId`
        # @return [String]
        attr_accessor :homepage_id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#storeLayout".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The store layout type. By default, this value is set to "basic" if the
        # homepageId field is not set, and to "custom" otherwise. If set to "basic", the
        # layout will consist of all approved apps that have been whitelisted for the
        # user.
        # Corresponds to the JSON property `storeLayoutType`
        # @return [String]
        attr_accessor :store_layout_type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @homepage_id = args[:homepage_id] if args.key?(:homepage_id)
          @kind = args[:kind] if args.key?(:kind)
          @store_layout_type = args[:store_layout_type] if args.key?(:store_layout_type)
        end
      end
      
      # The store page resources for the enterprise.
      class StoreLayoutClustersListResponse
        include Google::Apis::Core::Hashable
      
        # A store cluster of an enterprise.
        # Corresponds to the JSON property `cluster`
        # @return [Array<Google::Apis::AndroidenterpriseV1::StoreCluster>]
        attr_accessor :cluster
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#storeLayoutClustersListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cluster = args[:cluster] if args.key?(:cluster)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # The store page resources for the enterprise.
      class StoreLayoutPagesListResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#storeLayoutPagesListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A store page of an enterprise.
        # Corresponds to the JSON property `page`
        # @return [Array<Google::Apis::AndroidenterpriseV1::StorePage>]
        attr_accessor :page
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @page = args[:page] if args.key?(:page)
        end
      end
      
      # Definition of a managed Google Play store page, made of a localized name and
      # links to other pages. A page also contains clusters defined as a subcollection.
      class StorePage
        include Google::Apis::Core::Hashable
      
        # Unique ID of this page. Assigned by the server. Immutable once assigned.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#storePage".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Ordered list of pages a user should be able to reach from this page. The pages
        # must exist, must not be this page, and once a link is created the page linked
        # to cannot be deleted until all links to it are removed. It is recommended that
        # the basic pages are created first, before adding the links between pages.
        # No attempt is made to verify that all pages are reachable from the homepage.
        # Corresponds to the JSON property `link`
        # @return [Array<String>]
        attr_accessor :link
      
        # Ordered list of localized strings giving the name of this page. The text
        # displayed is the one that best matches the user locale, or the first entry if
        # there is no good match. There needs to be at least one entry.
        # Corresponds to the JSON property `name`
        # @return [Array<Google::Apis::AndroidenterpriseV1::LocalizedText>]
        attr_accessor :name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @link = args[:link] if args.key?(:link)
          @name = args[:name] if args.key?(:name)
        end
      end
      
      # 
      class TokenPagination
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # 
        # Corresponds to the JSON property `previousPageToken`
        # @return [String]
        attr_accessor :previous_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @previous_page_token = args[:previous_page_token] if args.key?(:previous_page_token)
        end
      end
      
      # A Users resource represents an account associated with an enterprise. The
      # account may be specific to a device or to an individual user (who can then use
      # the account across multiple devices). The account may provide access to
      # managed Google Play only, or to other Google services, depending on the
      # identity model:
      # - The Google managed domain identity model requires synchronization to Google
      # account sources (via primaryEmail).
      # - The managed Google Play Accounts identity model provides a dynamic means for
      # enterprises to create user or device accounts as needed. These accounts
      # provide access to managed Google Play.
      class User
        include Google::Apis::Core::Hashable
      
        # A unique identifier you create for this user, such as "user342" or "asset#
        # 44418". Do not use personally identifiable information (PII) for this property.
        # Must always be set for EMM-managed users. Not set for Google-managed users.
        # Corresponds to the JSON property `accountIdentifier`
        # @return [String]
        attr_accessor :account_identifier
      
        # The type of account that this user represents. A userAccount can be installed
        # on multiple devices, but a deviceAccount is specific to a single device. An
        # EMM-managed user (emmManaged) can be either type (userAccount, deviceAccount),
        # but a Google-managed user (googleManaged) is always a userAccount.
        # Corresponds to the JSON property `accountType`
        # @return [String]
        attr_accessor :account_type
      
        # The name that will appear in user interfaces. Setting this property is
        # optional when creating EMM-managed users. If you do set this property, use
        # something generic about the organization (such as "Example, Inc.") or your
        # name (as EMM). Not used for Google-managed user accounts.
        # Corresponds to the JSON property `displayName`
        # @return [String]
        attr_accessor :display_name
      
        # The unique ID for the user.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#user".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The entity that manages the user. With googleManaged users, the source of
        # truth is Google so EMMs have to make sure a Google Account exists for the user.
        # With emmManaged users, the EMM is in charge.
        # Corresponds to the JSON property `managementType`
        # @return [String]
        attr_accessor :management_type
      
        # The user's primary email address, for example, "jsmith@example.com". Will
        # always be set for Google managed users and not set for EMM managed users.
        # Corresponds to the JSON property `primaryEmail`
        # @return [String]
        attr_accessor :primary_email
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @account_identifier = args[:account_identifier] if args.key?(:account_identifier)
          @account_type = args[:account_type] if args.key?(:account_type)
          @display_name = args[:display_name] if args.key?(:display_name)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @management_type = args[:management_type] if args.key?(:management_type)
          @primary_email = args[:primary_email] if args.key?(:primary_email)
        end
      end
      
      # A UserToken is used by a user when setting up a managed device or profile with
      # their managed Google Play account on a device. When the user enters their
      # email address and token (activation code) the appropriate EMM app can be
      # automatically downloaded.
      class UserToken
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#userToken".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The token (activation code) to be entered by the user. This consists of a
        # sequence of decimal digits. Note that the leading digit may be 0.
        # Corresponds to the JSON property `token`
        # @return [String]
        attr_accessor :token
      
        # The unique ID for the user.
        # Corresponds to the JSON property `userId`
        # @return [String]
        attr_accessor :user_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @token = args[:token] if args.key?(:token)
          @user_id = args[:user_id] if args.key?(:user_id)
        end
      end
      
      # The matching user resources.
      class ListUsersResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidenterprise#usersListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A user of an enterprise.
        # Corresponds to the JSON property `user`
        # @return [Array<Google::Apis::AndroidenterpriseV1::User>]
        attr_accessor :user
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @user = args[:user] if args.key?(:user)
        end
      end
    end
  end
end
