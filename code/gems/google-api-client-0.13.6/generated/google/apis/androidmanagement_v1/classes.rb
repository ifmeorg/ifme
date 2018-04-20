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
    module AndroidmanagementV1
      
      # A compliance rule condition which is satisfied if the Android Framework API
      # level on the device does not meet a minimum requirement. There can only be one
      # rule with this type of condition per policy.
      class ApiLevelCondition
        include Google::Apis::Core::Hashable
      
        # The minimum desired Android Framework API level. If the device does not meet
        # the minimum requirement, this condition is satisfied. Must be greater than
        # zero.
        # Corresponds to the JSON property `minApiLevel`
        # @return [Fixnum]
        attr_accessor :min_api_level
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @min_api_level = args[:min_api_level] if args.key?(:min_api_level)
        end
      end
      
      # Application information.
      class Application
        include Google::Apis::Core::Hashable
      
        # The set of managed properties available to be pre-configured for the
        # application.
        # Corresponds to the JSON property `managedProperties`
        # @return [Array<Google::Apis::AndroidmanagementV1::ManagedProperty>]
        attr_accessor :managed_properties
      
        # The name of the application in the form enterprises/`enterpriseId`/
        # applications/`package_name`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The permissions required by the app.
        # Corresponds to the JSON property `permissions`
        # @return [Array<Google::Apis::AndroidmanagementV1::ApplicationPermission>]
        attr_accessor :permissions
      
        # The title of the application. Localized.
        # Corresponds to the JSON property `title`
        # @return [String]
        attr_accessor :title
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @managed_properties = args[:managed_properties] if args.key?(:managed_properties)
          @name = args[:name] if args.key?(:name)
          @permissions = args[:permissions] if args.key?(:permissions)
          @title = args[:title] if args.key?(:title)
        end
      end
      
      # Application permission.
      class ApplicationPermission
        include Google::Apis::Core::Hashable
      
        # A longer description of the permission, giving more details of what it affects.
        # Localized.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # The name of the permission. Localized.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # An opaque string uniquely identifying the permission. Not localized.
        # Corresponds to the JSON property `permissionId`
        # @return [String]
        attr_accessor :permission_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @description = args[:description] if args.key?(:description)
          @name = args[:name] if args.key?(:name)
          @permission_id = args[:permission_id] if args.key?(:permission_id)
        end
      end
      
      # Policy for an individual app.
      class ApplicationPolicy
        include Google::Apis::Core::Hashable
      
        # The default policy for all permissions requested by the app. If specified,
        # this overrides the policy-level default_permission_policy which applies to all
        # apps.
        # Corresponds to the JSON property `defaultPermissionPolicy`
        # @return [String]
        attr_accessor :default_permission_policy
      
        # The type of installation to perform.
        # Corresponds to the JSON property `installType`
        # @return [String]
        attr_accessor :install_type
      
        # Whether the application is allowed to lock itself in full-screen mode.
        # Corresponds to the JSON property `lockTaskAllowed`
        # @return [Boolean]
        attr_accessor :lock_task_allowed
        alias_method :lock_task_allowed?, :lock_task_allowed
      
        # Managed configuration applied to the app. The format for the configuration is
        # dictated by the ManagedProperty values supported by the app. Each field name
        # in the managed configuration must match the key field of the ManagedProperty.
        # The field value must be compatible with the type of the ManagedProperty: <
        # table> <tr><td><i>type</i></td><td><i>JSON value</i></td></tr> <tr><td>BOOL</
        # td><td>true or false</td></tr> <tr><td>STRING</td><td>string</td></tr> <tr><td>
        # INTEGER</td><td>number</td></tr> <tr><td>CHOICE</td><td>string</td></tr> <tr><
        # td>MULTISELECT</td><td>array of strings</td></tr> <tr><td>HIDDEN</td><td>
        # string</td></tr> <tr><td>BUNDLE_ARRAY</td><td>array of objects</td></tr> </
        # table>
        # Corresponds to the JSON property `managedConfiguration`
        # @return [Hash<String,Object>]
        attr_accessor :managed_configuration
      
        # The package name of the app, e.g. com.google.android.youtube for the YouTube
        # app.
        # Corresponds to the JSON property `packageName`
        # @return [String]
        attr_accessor :package_name
      
        # Explicit permission grants or denials for the app. These values override the
        # default_permission_policy.
        # Corresponds to the JSON property `permissionGrants`
        # @return [Array<Google::Apis::AndroidmanagementV1::PermissionGrant>]
        attr_accessor :permission_grants
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_permission_policy = args[:default_permission_policy] if args.key?(:default_permission_policy)
          @install_type = args[:install_type] if args.key?(:install_type)
          @lock_task_allowed = args[:lock_task_allowed] if args.key?(:lock_task_allowed)
          @managed_configuration = args[:managed_configuration] if args.key?(:managed_configuration)
          @package_name = args[:package_name] if args.key?(:package_name)
          @permission_grants = args[:permission_grants] if args.key?(:permission_grants)
        end
      end
      
      # A command.
      class Command
        include Google::Apis::Core::Hashable
      
        # The timestamp at which the command was created. The timestamp is automatically
        # generated by the server.
        # Corresponds to the JSON property `createTime`
        # @return [String]
        attr_accessor :create_time
      
        # The duration for which the command is valid. The command will expire if not
        # executed by the device during this time. The default duration if unspecified
        # is ten minutes. There is no maximum duration.
        # Corresponds to the JSON property `duration`
        # @return [String]
        attr_accessor :duration
      
        # For commands of type RESET_PASSWORD, optionally specifies the new password.
        # Corresponds to the JSON property `newPassword`
        # @return [String]
        attr_accessor :new_password
      
        # For commands of type RESET_PASSWORD, optionally specifies flags.
        # Corresponds to the JSON property `resetPasswordFlags`
        # @return [Array<String>]
        attr_accessor :reset_password_flags
      
        # The type of the command.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @create_time = args[:create_time] if args.key?(:create_time)
          @duration = args[:duration] if args.key?(:duration)
          @new_password = args[:new_password] if args.key?(:new_password)
          @reset_password_flags = args[:reset_password_flags] if args.key?(:reset_password_flags)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # A rule declaring which mitigating actions to take when a device is not
      # compliant with its policy. For every rule, there is always an implicit
      # mitigating action to set policy_compliant to false for the Device resource,
      # and display a message on the device indicating that the device is not
      # compliant with its policy. Other mitigating actions may optionally be taken as
      # well, depending on the field values in the rule.
      class ComplianceRule
        include Google::Apis::Core::Hashable
      
        # A compliance rule condition which is satisfied if the Android Framework API
        # level on the device does not meet a minimum requirement. There can only be one
        # rule with this type of condition per policy.
        # Corresponds to the JSON property `apiLevelCondition`
        # @return [Google::Apis::AndroidmanagementV1::ApiLevelCondition]
        attr_accessor :api_level_condition
      
        # If set to true, the rule includes a mitigating action to disable applications
        # so that the device is effectively disabled, but application data is preserved.
        # If the device is running an app in locked task mode, the app will be closed
        # and a UI showing the reason for non-compliance will be displayed.
        # Corresponds to the JSON property `disableApps`
        # @return [Boolean]
        attr_accessor :disable_apps
        alias_method :disable_apps?, :disable_apps
      
        # A compliance rule condition which is satisfied if there exists any matching
        # NonComplianceDetail for the device. A NonComplianceDetail matches a
        # NonComplianceDetailCondition if all the fields which are set within the
        # NonComplianceDetailCondition match the corresponding NonComplianceDetail
        # fields.
        # Corresponds to the JSON property `nonComplianceDetailCondition`
        # @return [Google::Apis::AndroidmanagementV1::NonComplianceDetailCondition]
        attr_accessor :non_compliance_detail_condition
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @api_level_condition = args[:api_level_condition] if args.key?(:api_level_condition)
          @disable_apps = args[:disable_apps] if args.key?(:disable_apps)
          @non_compliance_detail_condition = args[:non_compliance_detail_condition] if args.key?(:non_compliance_detail_condition)
        end
      end
      
      # A device owned by an enterprise. Unless otherwise noted, all fields are read-
      # only and cannot be modified by an update device request.
      class Device
        include Google::Apis::Core::Hashable
      
        # The API level of the Android platform version running on the device.
        # Corresponds to the JSON property `apiLevel`
        # @return [Fixnum]
        attr_accessor :api_level
      
        # The name of the policy that is currently applied by the device.
        # Corresponds to the JSON property `appliedPolicyName`
        # @return [String]
        attr_accessor :applied_policy_name
      
        # The version of the policy that is currently applied by the device.
        # Corresponds to the JSON property `appliedPolicyVersion`
        # @return [Fixnum]
        attr_accessor :applied_policy_version
      
        # The state that is currently applied by the device.
        # Corresponds to the JSON property `appliedState`
        # @return [String]
        attr_accessor :applied_state
      
        # Provides user facing message with locale info. The maximum message length is
        # 4096 characters.
        # Corresponds to the JSON property `disabledReason`
        # @return [Google::Apis::AndroidmanagementV1::UserFacingMessage]
        attr_accessor :disabled_reason
      
        # Displays on the device. This information is only available when
        # displayInfoEnabled is true in the device's policy.
        # Corresponds to the JSON property `displays`
        # @return [Array<Google::Apis::AndroidmanagementV1::DisplayProp>]
        attr_accessor :displays
      
        # The time of device enrollment.
        # Corresponds to the JSON property `enrollmentTime`
        # @return [String]
        attr_accessor :enrollment_time
      
        # If this device was enrolled with an enrollment token with additional data
        # provided, this field contains that data.
        # Corresponds to the JSON property `enrollmentTokenData`
        # @return [String]
        attr_accessor :enrollment_token_data
      
        # If this device was enrolled with an enrollment token, this field contains the
        # name of the token.
        # Corresponds to the JSON property `enrollmentTokenName`
        # @return [String]
        attr_accessor :enrollment_token_name
      
        # Information about device hardware. The fields related to temperature
        # thresholds are only available when hardwareStatusEnabled is true in the device'
        # s policy.
        # Corresponds to the JSON property `hardwareInfo`
        # @return [Google::Apis::AndroidmanagementV1::HardwareInfo]
        attr_accessor :hardware_info
      
        # Hardware status samples in chronological order. This information is only
        # available when hardwareStatusEnabled is true in the device's policy.
        # Corresponds to the JSON property `hardwareStatusSamples`
        # @return [Array<Google::Apis::AndroidmanagementV1::HardwareStatus>]
        attr_accessor :hardware_status_samples
      
        # The last time the device sent a policy compliance report.
        # Corresponds to the JSON property `lastPolicyComplianceReportTime`
        # @return [String]
        attr_accessor :last_policy_compliance_report_time
      
        # The last time the device fetched its policy.
        # Corresponds to the JSON property `lastPolicySyncTime`
        # @return [String]
        attr_accessor :last_policy_sync_time
      
        # The last time the device sent a status report.
        # Corresponds to the JSON property `lastStatusReportTime`
        # @return [String]
        attr_accessor :last_status_report_time
      
        # Events related to memory and storage measurements in chronological order. This
        # information is only available when memoryInfoEnabled is true in the device's
        # policy.
        # Corresponds to the JSON property `memoryEvents`
        # @return [Array<Google::Apis::AndroidmanagementV1::MemoryEvent>]
        attr_accessor :memory_events
      
        # Information about device memory and storage.
        # Corresponds to the JSON property `memoryInfo`
        # @return [Google::Apis::AndroidmanagementV1::MemoryInfo]
        attr_accessor :memory_info
      
        # The name of the device in the form enterprises/`enterpriseId`/devices/`
        # deviceId`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Device network info.
        # Corresponds to the JSON property `networkInfo`
        # @return [Google::Apis::AndroidmanagementV1::NetworkInfo]
        attr_accessor :network_info
      
        # Details about policy settings for which the device is not in compliance.
        # Corresponds to the JSON property `nonComplianceDetails`
        # @return [Array<Google::Apis::AndroidmanagementV1::NonComplianceDetail>]
        attr_accessor :non_compliance_details
      
        # Whether the device is compliant with its policy.
        # Corresponds to the JSON property `policyCompliant`
        # @return [Boolean]
        attr_accessor :policy_compliant
        alias_method :policy_compliant?, :policy_compliant
      
        # The name of the policy that is intended to be applied to the device. If empty,
        # the policy with id default is applied. This field may be modified by an update
        # request. The name of the policy is in the form enterprises/`enterpriseId`/
        # policies/`policyId`. It is also permissible to only specify the policyId when
        # updating this field as long as the policyId contains no slashes since the rest
        # of the policy name can be inferred from context.
        # Corresponds to the JSON property `policyName`
        # @return [String]
        attr_accessor :policy_name
      
        # Power management events on the device in chronological order. This information
        # is only available when powerManagementEventsEnabled is true in the device's
        # policy.
        # Corresponds to the JSON property `powerManagementEvents`
        # @return [Array<Google::Apis::AndroidmanagementV1::PowerManagementEvent>]
        attr_accessor :power_management_events
      
        # The previous device names used for the same physical device when it has been
        # enrolled multiple times. The serial number is used as the unique identifier to
        # determine if the same physical device has enrolled previously. The names are
        # in chronological order.
        # Corresponds to the JSON property `previousDeviceNames`
        # @return [Array<String>]
        attr_accessor :previous_device_names
      
        # Information about device software.
        # Corresponds to the JSON property `softwareInfo`
        # @return [Google::Apis::AndroidmanagementV1::SoftwareInfo]
        attr_accessor :software_info
      
        # The state that is intended to be applied to the device. This field may be
        # modified by an update request. Note that UpdateDevice only handles toggling
        # between ACTIVE and DISABLED states. Use the delete device method to cause the
        # device to enter the DELETED state.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        # The resource name of the user of the device in the form enterprises/`
        # enterpriseId`/users/`userId`. This is the name of the device account
        # automatically created for this device.
        # Corresponds to the JSON property `userName`
        # @return [String]
        attr_accessor :user_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @api_level = args[:api_level] if args.key?(:api_level)
          @applied_policy_name = args[:applied_policy_name] if args.key?(:applied_policy_name)
          @applied_policy_version = args[:applied_policy_version] if args.key?(:applied_policy_version)
          @applied_state = args[:applied_state] if args.key?(:applied_state)
          @disabled_reason = args[:disabled_reason] if args.key?(:disabled_reason)
          @displays = args[:displays] if args.key?(:displays)
          @enrollment_time = args[:enrollment_time] if args.key?(:enrollment_time)
          @enrollment_token_data = args[:enrollment_token_data] if args.key?(:enrollment_token_data)
          @enrollment_token_name = args[:enrollment_token_name] if args.key?(:enrollment_token_name)
          @hardware_info = args[:hardware_info] if args.key?(:hardware_info)
          @hardware_status_samples = args[:hardware_status_samples] if args.key?(:hardware_status_samples)
          @last_policy_compliance_report_time = args[:last_policy_compliance_report_time] if args.key?(:last_policy_compliance_report_time)
          @last_policy_sync_time = args[:last_policy_sync_time] if args.key?(:last_policy_sync_time)
          @last_status_report_time = args[:last_status_report_time] if args.key?(:last_status_report_time)
          @memory_events = args[:memory_events] if args.key?(:memory_events)
          @memory_info = args[:memory_info] if args.key?(:memory_info)
          @name = args[:name] if args.key?(:name)
          @network_info = args[:network_info] if args.key?(:network_info)
          @non_compliance_details = args[:non_compliance_details] if args.key?(:non_compliance_details)
          @policy_compliant = args[:policy_compliant] if args.key?(:policy_compliant)
          @policy_name = args[:policy_name] if args.key?(:policy_name)
          @power_management_events = args[:power_management_events] if args.key?(:power_management_events)
          @previous_device_names = args[:previous_device_names] if args.key?(:previous_device_names)
          @software_info = args[:software_info] if args.key?(:software_info)
          @state = args[:state] if args.key?(:state)
          @user_name = args[:user_name] if args.key?(:user_name)
        end
      end
      
      # Device display information.
      class DisplayProp
        include Google::Apis::Core::Hashable
      
        # Display density expressed as dots-per-inch.
        # Corresponds to the JSON property `density`
        # @return [Fixnum]
        attr_accessor :density
      
        # Unique display id.
        # Corresponds to the JSON property `displayId`
        # @return [Fixnum]
        attr_accessor :display_id
      
        # Display height in pixels.
        # Corresponds to the JSON property `height`
        # @return [Fixnum]
        attr_accessor :height
      
        # Name of the display.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Refresh rate of the display in frames per second.
        # Corresponds to the JSON property `refreshRate`
        # @return [Fixnum]
        attr_accessor :refresh_rate
      
        # State of the display.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        # Display width in pixels.
        # Corresponds to the JSON property `width`
        # @return [Fixnum]
        attr_accessor :width
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @density = args[:density] if args.key?(:density)
          @display_id = args[:display_id] if args.key?(:display_id)
          @height = args[:height] if args.key?(:height)
          @name = args[:name] if args.key?(:name)
          @refresh_rate = args[:refresh_rate] if args.key?(:refresh_rate)
          @state = args[:state] if args.key?(:state)
          @width = args[:width] if args.key?(:width)
        end
      end
      
      # A generic empty message that you can re-use to avoid defining duplicated empty
      # messages in your APIs. A typical example is to use it as the request or the
      # response type of an API method. For instance:
      # service Foo `
      # rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
      # `
      # The JSON representation for Empty is empty JSON object ``.
      class Empty
        include Google::Apis::Core::Hashable
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
        end
      end
      
      # An enrollment token.
      class EnrollmentToken
        include Google::Apis::Core::Hashable
      
        # Optional, arbitrary data associated with the enrollment token. This could
        # contain, for example, the id of an org unit to which the device is assigned
        # after enrollment. After a device enrolls with the token, this data will be
        # exposed in the enrollment_token_data field of the Device resource. The data
        # must be 1024 characters or less; otherwise, the creation request will fail.
        # Corresponds to the JSON property `additionalData`
        # @return [String]
        attr_accessor :additional_data
      
        # The duration of the token. If not specified, the duration will be 1 hour. The
        # allowed range is 1 minute to 30 days.
        # Corresponds to the JSON property `duration`
        # @return [String]
        attr_accessor :duration
      
        # The expiration time of the token. This is a read-only field generated by the
        # server.
        # Corresponds to the JSON property `expirationTimestamp`
        # @return [String]
        attr_accessor :expiration_timestamp
      
        # The name of the enrollment token, which is generated by the server during
        # creation, in the form enterprises/`enterpriseId`/enrollmentTokens/`
        # enrollmentTokenId`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The name of the policy that will be initially applied to the enrolled device
        # in the form enterprises/`enterpriseId`/policies/`policyId`. If not specified,
        # the policy with id default is applied. It is permissible to only specify the
        # policyId when updating this field as long as the policyId contains no slashes
        # since the rest of the policy name can be inferred from context.
        # Corresponds to the JSON property `policyName`
        # @return [String]
        attr_accessor :policy_name
      
        # A JSON string whose UTF-8 representation can be used to generate a QR code to
        # enroll a device with this enrollment token. To enroll a device using NFC, the
        # NFC record must contain a serialized java.util.Properties representation of
        # the properties in the JSON.
        # Corresponds to the JSON property `qrCode`
        # @return [String]
        attr_accessor :qr_code
      
        # The token value which is passed to the device and authorizes the device to
        # enroll. This is a read-only field generated by the server.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @additional_data = args[:additional_data] if args.key?(:additional_data)
          @duration = args[:duration] if args.key?(:duration)
          @expiration_timestamp = args[:expiration_timestamp] if args.key?(:expiration_timestamp)
          @name = args[:name] if args.key?(:name)
          @policy_name = args[:policy_name] if args.key?(:policy_name)
          @qr_code = args[:qr_code] if args.key?(:qr_code)
          @value = args[:value] if args.key?(:value)
        end
      end
      
      # The configuration applied to an enterprise.
      class Enterprise
        include Google::Apis::Core::Hashable
      
        # Whether app auto-approval is enabled. When enabled, apps installed via policy
        # for this enterprise have all permissions automatically approved. When enabled,
        # it is the caller's responsibility to display the permissions required by an
        # app to the enterprise admin before setting the app to be installed in a policy.
        # Corresponds to the JSON property `appAutoApprovalEnabled`
        # @return [Boolean]
        attr_accessor :app_auto_approval_enabled
        alias_method :app_auto_approval_enabled?, :app_auto_approval_enabled
      
        # The notification types to enable via Google Cloud Pub/Sub.
        # Corresponds to the JSON property `enabledNotificationTypes`
        # @return [Array<String>]
        attr_accessor :enabled_notification_types
      
        # The name of the enterprise as it will appear to users.
        # Corresponds to the JSON property `enterpriseDisplayName`
        # @return [String]
        attr_accessor :enterprise_display_name
      
        # Data hosted at an external location. The data is to be downloaded by Android
        # Device Policy and verified against the hash.
        # Corresponds to the JSON property `logo`
        # @return [Google::Apis::AndroidmanagementV1::ExternalData]
        attr_accessor :logo
      
        # The name of the enterprise which is generated by the server during creation,
        # in the form enterprises/`enterpriseId`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # A color in RGB format indicating the predominant color to display in the
        # device management app UI. The color components are stored as follows: (red <<
        # 16) | (green << 8) | blue, where each component may take a value between 0 and
        # 255 inclusive.
        # Corresponds to the JSON property `primaryColor`
        # @return [Fixnum]
        attr_accessor :primary_color
      
        # When Cloud Pub/Sub notifications are enabled, this field is required to
        # indicate the topic to which the notifications will be published. The format of
        # this field is projects/`project`/topics/`topic`. You must have granted the
        # publish permission on this topic to android-cloud-policy@system.
        # gserviceaccount.com
        # Corresponds to the JSON property `pubsubTopic`
        # @return [String]
        attr_accessor :pubsub_topic
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @app_auto_approval_enabled = args[:app_auto_approval_enabled] if args.key?(:app_auto_approval_enabled)
          @enabled_notification_types = args[:enabled_notification_types] if args.key?(:enabled_notification_types)
          @enterprise_display_name = args[:enterprise_display_name] if args.key?(:enterprise_display_name)
          @logo = args[:logo] if args.key?(:logo)
          @name = args[:name] if args.key?(:name)
          @primary_color = args[:primary_color] if args.key?(:primary_color)
          @pubsub_topic = args[:pubsub_topic] if args.key?(:pubsub_topic)
        end
      end
      
      # Data hosted at an external location. The data is to be downloaded by Android
      # Device Policy and verified against the hash.
      class ExternalData
        include Google::Apis::Core::Hashable
      
        # The base-64 encoded SHA-256 hash of the content hosted at url. If the content
        # does not match this hash, Android Device Policy will not use the data.
        # Corresponds to the JSON property `sha256Hash`
        # @return [String]
        attr_accessor :sha256_hash
      
        # The absolute URL to the data, which must use either the http or https scheme.
        # Android Device Policy does not provide any credentials in the GET request, so
        # the URL must be publicly accessible. Including a long, random component in the
        # URL may be used to prevent attackers from discovering the URL.
        # Corresponds to the JSON property `url`
        # @return [String]
        attr_accessor :url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @sha256_hash = args[:sha256_hash] if args.key?(:sha256_hash)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # Information about device hardware. The fields related to temperature
      # thresholds are only available when hardwareStatusEnabled is true in the device'
      # s policy.
      class HardwareInfo
        include Google::Apis::Core::Hashable
      
        # Battery shutdown temperature thresholds in Celsius for each battery on the
        # device.
        # Corresponds to the JSON property `batteryShutdownTemperatures`
        # @return [Array<Float>]
        attr_accessor :battery_shutdown_temperatures
      
        # Battery throttling temperature thresholds in Celsius for each battery on the
        # device.
        # Corresponds to the JSON property `batteryThrottlingTemperatures`
        # @return [Array<Float>]
        attr_accessor :battery_throttling_temperatures
      
        # Brand of the device, e.g. Google.
        # Corresponds to the JSON property `brand`
        # @return [String]
        attr_accessor :brand
      
        # CPU shutdown temperature thresholds in Celsius for each CPU on the device.
        # Corresponds to the JSON property `cpuShutdownTemperatures`
        # @return [Array<Float>]
        attr_accessor :cpu_shutdown_temperatures
      
        # CPU throttling temperature thresholds in Celsius for each CPU on the device.
        # Corresponds to the JSON property `cpuThrottlingTemperatures`
        # @return [Array<Float>]
        attr_accessor :cpu_throttling_temperatures
      
        # Baseband version, e.g. MDM9625_104662.22.05.34p.
        # Corresponds to the JSON property `deviceBasebandVersion`
        # @return [String]
        attr_accessor :device_baseband_version
      
        # GPU shutdown temperature thresholds in Celsius for each GPU on the device.
        # Corresponds to the JSON property `gpuShutdownTemperatures`
        # @return [Array<Float>]
        attr_accessor :gpu_shutdown_temperatures
      
        # GPU throttling temperature thresholds in Celsius for each GPU on the device.
        # Corresponds to the JSON property `gpuThrottlingTemperatures`
        # @return [Array<Float>]
        attr_accessor :gpu_throttling_temperatures
      
        # Name of the hardware, e.g. Angler.
        # Corresponds to the JSON property `hardware`
        # @return [String]
        attr_accessor :hardware
      
        # Manufacturer, e.g. Motorola.
        # Corresponds to the JSON property `manufacturer`
        # @return [String]
        attr_accessor :manufacturer
      
        # The model of the device, e.g. Asus Nexus 7.
        # Corresponds to the JSON property `model`
        # @return [String]
        attr_accessor :model
      
        # The device serial number.
        # Corresponds to the JSON property `serialNumber`
        # @return [String]
        attr_accessor :serial_number
      
        # Device skin shutdown temperature thresholds in Celsius.
        # Corresponds to the JSON property `skinShutdownTemperatures`
        # @return [Array<Float>]
        attr_accessor :skin_shutdown_temperatures
      
        # Device skin throttling temperature thresholds in Celsius.
        # Corresponds to the JSON property `skinThrottlingTemperatures`
        # @return [Array<Float>]
        attr_accessor :skin_throttling_temperatures
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @battery_shutdown_temperatures = args[:battery_shutdown_temperatures] if args.key?(:battery_shutdown_temperatures)
          @battery_throttling_temperatures = args[:battery_throttling_temperatures] if args.key?(:battery_throttling_temperatures)
          @brand = args[:brand] if args.key?(:brand)
          @cpu_shutdown_temperatures = args[:cpu_shutdown_temperatures] if args.key?(:cpu_shutdown_temperatures)
          @cpu_throttling_temperatures = args[:cpu_throttling_temperatures] if args.key?(:cpu_throttling_temperatures)
          @device_baseband_version = args[:device_baseband_version] if args.key?(:device_baseband_version)
          @gpu_shutdown_temperatures = args[:gpu_shutdown_temperatures] if args.key?(:gpu_shutdown_temperatures)
          @gpu_throttling_temperatures = args[:gpu_throttling_temperatures] if args.key?(:gpu_throttling_temperatures)
          @hardware = args[:hardware] if args.key?(:hardware)
          @manufacturer = args[:manufacturer] if args.key?(:manufacturer)
          @model = args[:model] if args.key?(:model)
          @serial_number = args[:serial_number] if args.key?(:serial_number)
          @skin_shutdown_temperatures = args[:skin_shutdown_temperatures] if args.key?(:skin_shutdown_temperatures)
          @skin_throttling_temperatures = args[:skin_throttling_temperatures] if args.key?(:skin_throttling_temperatures)
        end
      end
      
      # Hardware status. Temperatures may be compared to the temperature thresholds
      # available in hardwareInfo to determine hardware health.
      class HardwareStatus
        include Google::Apis::Core::Hashable
      
        # Current battery temperatures in Celsius for each battery on the device.
        # Corresponds to the JSON property `batteryTemperatures`
        # @return [Array<Float>]
        attr_accessor :battery_temperatures
      
        # Current CPU temperatures in Celsius for each CPU on the device.
        # Corresponds to the JSON property `cpuTemperatures`
        # @return [Array<Float>]
        attr_accessor :cpu_temperatures
      
        # CPU usages in percentage for each core available on the device. Usage is 0 for
        # each unplugged core. Empty array implies that CPU usage is not supported in
        # the system.
        # Corresponds to the JSON property `cpuUsages`
        # @return [Array<Float>]
        attr_accessor :cpu_usages
      
        # The time the measurements were taken.
        # Corresponds to the JSON property `createTime`
        # @return [String]
        attr_accessor :create_time
      
        # Fan speeds in RPM for each fan on the device. Empty array means that there are
        # no fans or fan speed is not supported on the system.
        # Corresponds to the JSON property `fanSpeeds`
        # @return [Array<Float>]
        attr_accessor :fan_speeds
      
        # Current GPU temperatures in Celsius for each GPU on the device.
        # Corresponds to the JSON property `gpuTemperatures`
        # @return [Array<Float>]
        attr_accessor :gpu_temperatures
      
        # Current device skin temperatures in Celsius.
        # Corresponds to the JSON property `skinTemperatures`
        # @return [Array<Float>]
        attr_accessor :skin_temperatures
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @battery_temperatures = args[:battery_temperatures] if args.key?(:battery_temperatures)
          @cpu_temperatures = args[:cpu_temperatures] if args.key?(:cpu_temperatures)
          @cpu_usages = args[:cpu_usages] if args.key?(:cpu_usages)
          @create_time = args[:create_time] if args.key?(:create_time)
          @fan_speeds = args[:fan_speeds] if args.key?(:fan_speeds)
          @gpu_temperatures = args[:gpu_temperatures] if args.key?(:gpu_temperatures)
          @skin_temperatures = args[:skin_temperatures] if args.key?(:skin_temperatures)
        end
      end
      
      # Response to a request to list devices for a given enterprise.
      class ListDevicesResponse
        include Google::Apis::Core::Hashable
      
        # The list of devices.
        # Corresponds to the JSON property `devices`
        # @return [Array<Google::Apis::AndroidmanagementV1::Device>]
        attr_accessor :devices
      
        # If there are more results, a token to retrieve next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @devices = args[:devices] if args.key?(:devices)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
        end
      end
      
      # The response message for Operations.ListOperations.
      class ListOperationsResponse
        include Google::Apis::Core::Hashable
      
        # The standard List next-page token.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # A list of operations that matches the specified filter in the request.
        # Corresponds to the JSON property `operations`
        # @return [Array<Google::Apis::AndroidmanagementV1::Operation>]
        attr_accessor :operations
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @operations = args[:operations] if args.key?(:operations)
        end
      end
      
      # Response to a request to list policies for a given enterprise.
      class ListPoliciesResponse
        include Google::Apis::Core::Hashable
      
        # If there are more results, a token to retrieve next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # The list of policies.
        # Corresponds to the JSON property `policies`
        # @return [Array<Google::Apis::AndroidmanagementV1::Policy>]
        attr_accessor :policies
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @policies = args[:policies] if args.key?(:policies)
        end
      end
      
      # Managed property.
      class ManagedProperty
        include Google::Apis::Core::Hashable
      
        # The default value of the properties. BUNDLE_ARRAY properties never have a
        # default value.
        # Corresponds to the JSON property `defaultValue`
        # @return [Object]
        attr_accessor :default_value
      
        # A longer description of the property, giving more detail of what it affects.
        # Localized.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # For CHOICE or MULTISELECT properties, the list of possible entries.
        # Corresponds to the JSON property `entries`
        # @return [Array<Google::Apis::AndroidmanagementV1::ManagedPropertyEntry>]
        attr_accessor :entries
      
        # The unique key that the application uses to identify the property, e.g. "com.
        # google.android.gm.fieldname".
        # Corresponds to the JSON property `key`
        # @return [String]
        attr_accessor :key
      
        # For BUNDLE_ARRAY properties, the list of nested properties. A BUNDLE_ARRAY
        # property is at most two levels deep.
        # Corresponds to the JSON property `nestedProperties`
        # @return [Array<Google::Apis::AndroidmanagementV1::ManagedProperty>]
        attr_accessor :nested_properties
      
        # The name of the property. Localized.
        # Corresponds to the JSON property `title`
        # @return [String]
        attr_accessor :title
      
        # The type of the property.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_value = args[:default_value] if args.key?(:default_value)
          @description = args[:description] if args.key?(:description)
          @entries = args[:entries] if args.key?(:entries)
          @key = args[:key] if args.key?(:key)
          @nested_properties = args[:nested_properties] if args.key?(:nested_properties)
          @title = args[:title] if args.key?(:title)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # An entry of a managed property.
      class ManagedPropertyEntry
        include Google::Apis::Core::Hashable
      
        # The human-readable name of the value. Localized.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The machine-readable value of the entry, which should be used in the
        # configuration. Not localized.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @name = args[:name] if args.key?(:name)
          @value = args[:value] if args.key?(:value)
        end
      end
      
      # An event related to memory and storage measurements.
      class MemoryEvent
        include Google::Apis::Core::Hashable
      
        # The number of free bytes in the medium, or for EXTERNAL_STORAGE_DETECTED, the
        # total capacity in bytes of the storage medium.
        # Corresponds to the JSON property `byteCount`
        # @return [Fixnum]
        attr_accessor :byte_count
      
        # The creation time of the event.
        # Corresponds to the JSON property `createTime`
        # @return [String]
        attr_accessor :create_time
      
        # Event type.
        # Corresponds to the JSON property `eventType`
        # @return [String]
        attr_accessor :event_type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @byte_count = args[:byte_count] if args.key?(:byte_count)
          @create_time = args[:create_time] if args.key?(:create_time)
          @event_type = args[:event_type] if args.key?(:event_type)
        end
      end
      
      # Information about device memory and storage.
      class MemoryInfo
        include Google::Apis::Core::Hashable
      
        # Total internal storage on device in bytes.
        # Corresponds to the JSON property `totalInternalStorage`
        # @return [Fixnum]
        attr_accessor :total_internal_storage
      
        # Total RAM on device in bytes.
        # Corresponds to the JSON property `totalRam`
        # @return [Fixnum]
        attr_accessor :total_ram
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @total_internal_storage = args[:total_internal_storage] if args.key?(:total_internal_storage)
          @total_ram = args[:total_ram] if args.key?(:total_ram)
        end
      end
      
      # Device network info.
      class NetworkInfo
        include Google::Apis::Core::Hashable
      
        # IMEI number of the GSM device, e.g. A1000031212.
        # Corresponds to the JSON property `imei`
        # @return [String]
        attr_accessor :imei
      
        # MEID number of the CDMA device, e.g. A00000292788E1.
        # Corresponds to the JSON property `meid`
        # @return [String]
        attr_accessor :meid
      
        # WiFi MAC address of the device, e.g. 7c:11:11:11:11:11.
        # Corresponds to the JSON property `wifiMacAddress`
        # @return [String]
        attr_accessor :wifi_mac_address
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @imei = args[:imei] if args.key?(:imei)
          @meid = args[:meid] if args.key?(:meid)
          @wifi_mac_address = args[:wifi_mac_address] if args.key?(:wifi_mac_address)
        end
      end
      
      # Provides detail about non-compliance with a policy setting.
      class NonComplianceDetail
        include Google::Apis::Core::Hashable
      
        # If the policy setting could not be applied, the current value of the setting
        # on the device.
        # Corresponds to the JSON property `currentValue`
        # @return [Object]
        attr_accessor :current_value
      
        # For settings with nested fields, if a particular nested field is out of
        # compliance, this specifies the full path to the offending field. The path is
        # formatted in the same way the policy JSON field would be referenced in
        # JavaScript, that is: 1) For object-typed fields, the field name is followed by
        # a dot then by a  subfield name. 2) For array-typed fields, the field name is
        # followed by the array index  enclosed in brackets. For example, to indicate a
        # problem with the url field in the externalData field in the 3rd application,
        # the path would be applications[2].externalData.url
        # Corresponds to the JSON property `fieldPath`
        # @return [String]
        attr_accessor :field_path
      
        # If package_name is set and the non-compliance reason is APP_NOT_INSTALLED, the
        # detailed reason the app cannot be installed.
        # Corresponds to the JSON property `installationFailureReason`
        # @return [String]
        attr_accessor :installation_failure_reason
      
        # The reason the device is not in compliance with the setting.
        # Corresponds to the JSON property `nonComplianceReason`
        # @return [String]
        attr_accessor :non_compliance_reason
      
        # The package name indicating which application is out of compliance, if
        # applicable.
        # Corresponds to the JSON property `packageName`
        # @return [String]
        attr_accessor :package_name
      
        # The name of the policy setting. This is the JSON field name of a top-level
        # Policy  field.
        # Corresponds to the JSON property `settingName`
        # @return [String]
        attr_accessor :setting_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @current_value = args[:current_value] if args.key?(:current_value)
          @field_path = args[:field_path] if args.key?(:field_path)
          @installation_failure_reason = args[:installation_failure_reason] if args.key?(:installation_failure_reason)
          @non_compliance_reason = args[:non_compliance_reason] if args.key?(:non_compliance_reason)
          @package_name = args[:package_name] if args.key?(:package_name)
          @setting_name = args[:setting_name] if args.key?(:setting_name)
        end
      end
      
      # A compliance rule condition which is satisfied if there exists any matching
      # NonComplianceDetail for the device. A NonComplianceDetail matches a
      # NonComplianceDetailCondition if all the fields which are set within the
      # NonComplianceDetailCondition match the corresponding NonComplianceDetail
      # fields.
      class NonComplianceDetailCondition
        include Google::Apis::Core::Hashable
      
        # The reason the device is not in compliance with the setting. If not set, then
        # this condition matches any reason.
        # Corresponds to the JSON property `nonComplianceReason`
        # @return [String]
        attr_accessor :non_compliance_reason
      
        # The package name indicating which application is out of compliance. If not set,
        # then this condition matches any package name. If this field is set, then
        # setting_name must be unset or set to applications; otherwise, the condition
        # would never be satisfied.
        # Corresponds to the JSON property `packageName`
        # @return [String]
        attr_accessor :package_name
      
        # The name of the policy setting. This is the JSON field name of a top-level
        # Policy field. If not set, then this condition matches any setting name.
        # Corresponds to the JSON property `settingName`
        # @return [String]
        attr_accessor :setting_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @non_compliance_reason = args[:non_compliance_reason] if args.key?(:non_compliance_reason)
          @package_name = args[:package_name] if args.key?(:package_name)
          @setting_name = args[:setting_name] if args.key?(:setting_name)
        end
      end
      
      # This resource represents a long-running operation that is the result of a
      # network API call.
      class Operation
        include Google::Apis::Core::Hashable
      
        # If the value is false, it means the operation is still in progress. If true,
        # the operation is completed, and either error or response is available.
        # Corresponds to the JSON property `done`
        # @return [Boolean]
        attr_accessor :done
        alias_method :done?, :done
      
        # The Status type defines a logical error model that is suitable for different
        # programming environments, including REST APIs and RPC APIs. It is used by gRPC
        # (https://github.com/grpc). The error model is designed to be:
        # Simple to use and understand for most users
        # Flexible enough to meet unexpected needsOverviewThe Status message contains
        # three pieces of data: error code, error message, and error details. The error
        # code should be an enum value of google.rpc.Code, but it may accept additional
        # error codes if needed. The error message should be a developer-facing English
        # message that helps developers understand and resolve the error. If a localized
        # user-facing error message is needed, put the localized message in the error
        # details or localize it in the client. The optional error details may contain
        # arbitrary information about the error. There is a predefined set of error
        # detail types in the package google.rpc that can be used for common error
        # conditions.Language mappingThe Status message is the logical representation of
        # the error model, but it is not necessarily the actual wire format. When the
        # Status message is exposed in different client libraries and different wire
        # protocols, it can be mapped differently. For example, it will likely be mapped
        # to some exceptions in Java, but more likely mapped to some error codes in C.
        # Other usesThe error model and the Status message can be used in a variety of
        # environments, either with or without APIs, to provide a consistent developer
        # experience across different environments.Example uses of this error model
        # include:
        # Partial errors. If a service needs to return partial errors to the client, it
        # may embed the Status in the normal response to indicate the partial errors.
        # Workflow errors. A typical workflow has multiple steps. Each step may have a
        # Status message for error reporting.
        # Batch operations. If a client uses batch request and batch response, the
        # Status message should be used directly inside batch response, one for each
        # error sub-response.
        # Asynchronous operations. If an API call embeds asynchronous operation results
        # in its response, the status of those operations should be represented directly
        # using the Status message.
        # Logging. If some API errors are stored in logs, the message Status could be
        # used directly after any stripping needed for security/privacy reasons.
        # Corresponds to the JSON property `error`
        # @return [Google::Apis::AndroidmanagementV1::Status]
        attr_accessor :error
      
        # Service-specific metadata associated with the operation. It typically contains
        # progress information and common metadata such as create time. Some services
        # might not provide such metadata. Any method that returns a long-running
        # operation should document the metadata type, if any.
        # Corresponds to the JSON property `metadata`
        # @return [Hash<String,Object>]
        attr_accessor :metadata
      
        # The server-assigned name, which is only unique within the same service that
        # originally returns it. If you use the default HTTP mapping, the name should
        # have the format of operations/some/unique/name.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The normal response of the operation in case of success. If the original
        # method returns no data on success, such as Delete, the response is google.
        # protobuf.Empty. If the original method is standard Get/Create/Update, the
        # response should be the resource. For other methods, the response should have
        # the type XxxResponse, where Xxx is the original method name. For example, if
        # the original method name is TakeSnapshot(), the inferred response type is
        # TakeSnapshotResponse.
        # Corresponds to the JSON property `response`
        # @return [Hash<String,Object>]
        attr_accessor :response
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @done = args[:done] if args.key?(:done)
          @error = args[:error] if args.key?(:error)
          @metadata = args[:metadata] if args.key?(:metadata)
          @name = args[:name] if args.key?(:name)
          @response = args[:response] if args.key?(:response)
        end
      end
      
      # Requirements for the password used to unlock a device.
      class PasswordRequirements
        include Google::Apis::Core::Hashable
      
        # A device will be wiped after too many incorrect device-unlock passwords have
        # been entered. A value of 0 means there is no restriction.
        # Corresponds to the JSON property `maximumFailedPasswordsForWipe`
        # @return [Fixnum]
        attr_accessor :maximum_failed_passwords_for_wipe
      
        # Password expiration timeout.
        # Corresponds to the JSON property `passwordExpirationTimeout`
        # @return [String]
        attr_accessor :password_expiration_timeout
      
        # The length of the password history. After setting this, the user will not be
        # able to enter a new password that is the same as any password in the history.
        # A value of 0 means there is no restriction.
        # Corresponds to the JSON property `passwordHistoryLength`
        # @return [Fixnum]
        attr_accessor :password_history_length
      
        # The minimum allowed password length. A value of 0 means there is no
        # restriction. Only enforced when password_quality is NUMERIC, NUMERIC_COMPLEX,
        # ALPHABETIC, ALPHANUMERIC, or COMPLEX.
        # Corresponds to the JSON property `passwordMinimumLength`
        # @return [Fixnum]
        attr_accessor :password_minimum_length
      
        # Minimum number of letters required in the password. Only enforced when
        # password_quality is COMPLEX.
        # Corresponds to the JSON property `passwordMinimumLetters`
        # @return [Fixnum]
        attr_accessor :password_minimum_letters
      
        # Minimum number of lower case letters required in the password. Only enforced
        # when password_quality is COMPLEX.
        # Corresponds to the JSON property `passwordMinimumLowerCase`
        # @return [Fixnum]
        attr_accessor :password_minimum_lower_case
      
        # Minimum number of non-letter characters (numerical digits or symbols) required
        # in the password. Only enforced when password_quality is COMPLEX.
        # Corresponds to the JSON property `passwordMinimumNonLetter`
        # @return [Fixnum]
        attr_accessor :password_minimum_non_letter
      
        # Minimum number of numerical digits required in the password. Only enforced
        # when password_quality is COMPLEX.
        # Corresponds to the JSON property `passwordMinimumNumeric`
        # @return [Fixnum]
        attr_accessor :password_minimum_numeric
      
        # Minimum number of symbols required in the password. Only enforced when
        # password_quality is COMPLEX.
        # Corresponds to the JSON property `passwordMinimumSymbols`
        # @return [Fixnum]
        attr_accessor :password_minimum_symbols
      
        # Minimum number of upper case letters required in the password. Only enforced
        # when password_quality is COMPLEX.
        # Corresponds to the JSON property `passwordMinimumUpperCase`
        # @return [Fixnum]
        attr_accessor :password_minimum_upper_case
      
        # The required password quality.
        # Corresponds to the JSON property `passwordQuality`
        # @return [String]
        attr_accessor :password_quality
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @maximum_failed_passwords_for_wipe = args[:maximum_failed_passwords_for_wipe] if args.key?(:maximum_failed_passwords_for_wipe)
          @password_expiration_timeout = args[:password_expiration_timeout] if args.key?(:password_expiration_timeout)
          @password_history_length = args[:password_history_length] if args.key?(:password_history_length)
          @password_minimum_length = args[:password_minimum_length] if args.key?(:password_minimum_length)
          @password_minimum_letters = args[:password_minimum_letters] if args.key?(:password_minimum_letters)
          @password_minimum_lower_case = args[:password_minimum_lower_case] if args.key?(:password_minimum_lower_case)
          @password_minimum_non_letter = args[:password_minimum_non_letter] if args.key?(:password_minimum_non_letter)
          @password_minimum_numeric = args[:password_minimum_numeric] if args.key?(:password_minimum_numeric)
          @password_minimum_symbols = args[:password_minimum_symbols] if args.key?(:password_minimum_symbols)
          @password_minimum_upper_case = args[:password_minimum_upper_case] if args.key?(:password_minimum_upper_case)
          @password_quality = args[:password_quality] if args.key?(:password_quality)
        end
      end
      
      # Configuration for an Android permission and its grant state.
      class PermissionGrant
        include Google::Apis::Core::Hashable
      
        # The android permission, e.g. android.permission.READ_CALENDAR.
        # Corresponds to the JSON property `permission`
        # @return [String]
        attr_accessor :permission
      
        # The policy for granting the permission.
        # Corresponds to the JSON property `policy`
        # @return [String]
        attr_accessor :policy
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @permission = args[:permission] if args.key?(:permission)
          @policy = args[:policy] if args.key?(:policy)
        end
      end
      
      # A default activity for handling intents that match a particular intent filter.
      class PersistentPreferredActivity
        include Google::Apis::Core::Hashable
      
        # The intent actions to match in the filter. If any actions are included in the
        # filter, then an intent's action must be one of those values for it to match.
        # If no actions are included, the intent action is ignored.
        # Corresponds to the JSON property `actions`
        # @return [Array<String>]
        attr_accessor :actions
      
        # The intent categories to match in the filter. An intent includes the
        # categories that it requires, all of which must be included in the filter in
        # order to match. In other words, adding a category to the filter has no impact
        # on matching unless that category is specified in the intent.
        # Corresponds to the JSON property `categories`
        # @return [Array<String>]
        attr_accessor :categories
      
        # The activity that should be the default intent handler. This should be an
        # Android component name, e.g. com.android.enterprise.app/.MainActivity.
        # Alternatively, the value may be the package name of an app, which causes
        # Android Device Policy to choose an appropriate activity from the app to handle
        # the intent.
        # Corresponds to the JSON property `receiverActivity`
        # @return [String]
        attr_accessor :receiver_activity
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @actions = args[:actions] if args.key?(:actions)
          @categories = args[:categories] if args.key?(:categories)
          @receiver_activity = args[:receiver_activity] if args.key?(:receiver_activity)
        end
      end
      
      # A policy, which governs behavior for a device.
      class Policy
        include Google::Apis::Core::Hashable
      
        # Whether adding new users and profiles is disabled.
        # Corresponds to the JSON property `addUserDisabled`
        # @return [Boolean]
        attr_accessor :add_user_disabled
        alias_method :add_user_disabled?, :add_user_disabled
      
        # Whether adjusting the master volume is disabled.
        # Corresponds to the JSON property `adjustVolumeDisabled`
        # @return [Boolean]
        attr_accessor :adjust_volume_disabled
        alias_method :adjust_volume_disabled?, :adjust_volume_disabled
      
        # Policy applied to apps.
        # Corresponds to the JSON property `applications`
        # @return [Array<Google::Apis::AndroidmanagementV1::ApplicationPolicy>]
        attr_accessor :applications
      
        # Whether applications other than the ones configured in applications are
        # blocked from being installed. When set, applications that were installed under
        # a previous policy but no longer appear in the policy are automatically
        # uninstalled.
        # Corresponds to the JSON property `blockApplicationsEnabled`
        # @return [Boolean]
        attr_accessor :block_applications_enabled
        alias_method :block_applications_enabled?, :block_applications_enabled
      
        # Whether all cameras on the device are disabled.
        # Corresponds to the JSON property `cameraDisabled`
        # @return [Boolean]
        attr_accessor :camera_disabled
        alias_method :camera_disabled?, :camera_disabled
      
        # Rules declaring which mitigating actions to take when a device is not
        # compliant with its policy. When the conditions for multiple rules are
        # satisfied, all of the mitigating actions for the rules are taken. There is a
        # maximum limit of 100 rules.
        # Corresponds to the JSON property `complianceRules`
        # @return [Array<Google::Apis::AndroidmanagementV1::ComplianceRule>]
        attr_accessor :compliance_rules
      
        # Whether the user is allowed to enable debugging features.
        # Corresponds to the JSON property `debuggingFeaturesAllowed`
        # @return [Boolean]
        attr_accessor :debugging_features_allowed
        alias_method :debugging_features_allowed?, :debugging_features_allowed
      
        # The default permission policy for requests for runtime permissions.
        # Corresponds to the JSON property `defaultPermissionPolicy`
        # @return [String]
        attr_accessor :default_permission_policy
      
        # Whether factory resetting from settings is disabled.
        # Corresponds to the JSON property `factoryResetDisabled`
        # @return [Boolean]
        attr_accessor :factory_reset_disabled
        alias_method :factory_reset_disabled?, :factory_reset_disabled
      
        # Email addresses of device administrators for factory reset protection. When
        # the device is factory reset, it will require one of these admins to log in
        # with the Google account email and password to unlock the device. If no admins
        # are specified, the device will not provide factory reset protection.
        # Corresponds to the JSON property `frpAdminEmails`
        # @return [Array<String>]
        attr_accessor :frp_admin_emails
      
        # Whether the user is allowed to have fun. Controls whether the Easter egg game
        # in Settings is disabled.
        # Corresponds to the JSON property `funDisabled`
        # @return [Boolean]
        attr_accessor :fun_disabled
        alias_method :fun_disabled?, :fun_disabled
      
        # Whether the user is allowed to enable the "Unknown Sources" setting, which
        # allows installation of apps from unknown sources.
        # Corresponds to the JSON property `installUnknownSourcesAllowed`
        # @return [Boolean]
        attr_accessor :install_unknown_sources_allowed
        alias_method :install_unknown_sources_allowed?, :install_unknown_sources_allowed
      
        # Whether the keyguard is disabled.
        # Corresponds to the JSON property `keyguardDisabled`
        # @return [Boolean]
        attr_accessor :keyguard_disabled
        alias_method :keyguard_disabled?, :keyguard_disabled
      
        # Maximum time in milliseconds for user activity until the device will lock. A
        # value of 0 means there is no restriction.
        # Corresponds to the JSON property `maximumTimeToLock`
        # @return [Fixnum]
        attr_accessor :maximum_time_to_lock
      
        # Whether adding or removing accounts is disabled.
        # Corresponds to the JSON property `modifyAccountsDisabled`
        # @return [Boolean]
        attr_accessor :modify_accounts_disabled
        alias_method :modify_accounts_disabled?, :modify_accounts_disabled
      
        # The name of the policy in the form enterprises/`enterpriseId`/policies/`
        # policyId`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Flag to specify if network escape hatch is enabled. If this flag has been
        # enabled then upon device boot if device has no network connection, then an
        # activity will be shown that allows the user to temporarily connect to a
        # network to fetch the latest policy. The launched activity will time out if no
        # network has been connected for a given while and will return to the previous
        # activity that was shown.
        # Corresponds to the JSON property `networkEscapeHatchEnabled`
        # @return [Boolean]
        attr_accessor :network_escape_hatch_enabled
        alias_method :network_escape_hatch_enabled?, :network_escape_hatch_enabled
      
        # Network configuration for the device. See configure networks for more
        # information.
        # Corresponds to the JSON property `openNetworkConfiguration`
        # @return [Hash<String,Object>]
        attr_accessor :open_network_configuration
      
        # Requirements for the password used to unlock a device.
        # Corresponds to the JSON property `passwordRequirements`
        # @return [Google::Apis::AndroidmanagementV1::PasswordRequirements]
        attr_accessor :password_requirements
      
        # Default intent handler activities.
        # Corresponds to the JSON property `persistentPreferredActivities`
        # @return [Array<Google::Apis::AndroidmanagementV1::PersistentPreferredActivity>]
        attr_accessor :persistent_preferred_activities
      
        # Whether removing other users is disabled.
        # Corresponds to the JSON property `removeUserDisabled`
        # @return [Boolean]
        attr_accessor :remove_user_disabled
        alias_method :remove_user_disabled?, :remove_user_disabled
      
        # Whether rebooting the device into safe boot is disabled.
        # Corresponds to the JSON property `safeBootDisabled`
        # @return [Boolean]
        attr_accessor :safe_boot_disabled
        alias_method :safe_boot_disabled?, :safe_boot_disabled
      
        # Whether screen capture is disabled.
        # Corresponds to the JSON property `screenCaptureDisabled`
        # @return [Boolean]
        attr_accessor :screen_capture_disabled
        alias_method :screen_capture_disabled?, :screen_capture_disabled
      
        # Whether the status bar is disabled. This disables notifications, quick
        # settings and other screen overlays that allow escape from full-screen mode.
        # Corresponds to the JSON property `statusBarDisabled`
        # @return [Boolean]
        attr_accessor :status_bar_disabled
        alias_method :status_bar_disabled?, :status_bar_disabled
      
        # Settings controlling the behavior of status reports.
        # Corresponds to the JSON property `statusReportingSettings`
        # @return [Google::Apis::AndroidmanagementV1::StatusReportingSettings]
        attr_accessor :status_reporting_settings
      
        # The battery plugged in modes for which the device stays on. When using this
        # setting, it is recommended to clear maximum_time_to_lock so that the device
        # doesn't lock itself while it stays on.
        # Corresponds to the JSON property `stayOnPluggedModes`
        # @return [Array<String>]
        attr_accessor :stay_on_plugged_modes
      
        # Configuration for managing system updates
        # Corresponds to the JSON property `systemUpdate`
        # @return [Google::Apis::AndroidmanagementV1::SystemUpdate]
        attr_accessor :system_update
      
        # Whether the microphone is muted and adjusting microphone volume is disabled.
        # Corresponds to the JSON property `unmuteMicrophoneDisabled`
        # @return [Boolean]
        attr_accessor :unmute_microphone_disabled
        alias_method :unmute_microphone_disabled?, :unmute_microphone_disabled
      
        # The version of the policy. This is a read-only field. The version is
        # incremented each time the policy is updated.
        # Corresponds to the JSON property `version`
        # @return [Fixnum]
        attr_accessor :version
      
        # Whether configuring WiFi access points is disabled.
        # Corresponds to the JSON property `wifiConfigDisabled`
        # @return [Boolean]
        attr_accessor :wifi_config_disabled
        alias_method :wifi_config_disabled?, :wifi_config_disabled
      
        # Whether WiFi networks defined in Open Network Configuration are locked so they
        # cannot be edited by the user.
        # Corresponds to the JSON property `wifiConfigsLockdownEnabled`
        # @return [Boolean]
        attr_accessor :wifi_configs_lockdown_enabled
        alias_method :wifi_configs_lockdown_enabled?, :wifi_configs_lockdown_enabled
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @add_user_disabled = args[:add_user_disabled] if args.key?(:add_user_disabled)
          @adjust_volume_disabled = args[:adjust_volume_disabled] if args.key?(:adjust_volume_disabled)
          @applications = args[:applications] if args.key?(:applications)
          @block_applications_enabled = args[:block_applications_enabled] if args.key?(:block_applications_enabled)
          @camera_disabled = args[:camera_disabled] if args.key?(:camera_disabled)
          @compliance_rules = args[:compliance_rules] if args.key?(:compliance_rules)
          @debugging_features_allowed = args[:debugging_features_allowed] if args.key?(:debugging_features_allowed)
          @default_permission_policy = args[:default_permission_policy] if args.key?(:default_permission_policy)
          @factory_reset_disabled = args[:factory_reset_disabled] if args.key?(:factory_reset_disabled)
          @frp_admin_emails = args[:frp_admin_emails] if args.key?(:frp_admin_emails)
          @fun_disabled = args[:fun_disabled] if args.key?(:fun_disabled)
          @install_unknown_sources_allowed = args[:install_unknown_sources_allowed] if args.key?(:install_unknown_sources_allowed)
          @keyguard_disabled = args[:keyguard_disabled] if args.key?(:keyguard_disabled)
          @maximum_time_to_lock = args[:maximum_time_to_lock] if args.key?(:maximum_time_to_lock)
          @modify_accounts_disabled = args[:modify_accounts_disabled] if args.key?(:modify_accounts_disabled)
          @name = args[:name] if args.key?(:name)
          @network_escape_hatch_enabled = args[:network_escape_hatch_enabled] if args.key?(:network_escape_hatch_enabled)
          @open_network_configuration = args[:open_network_configuration] if args.key?(:open_network_configuration)
          @password_requirements = args[:password_requirements] if args.key?(:password_requirements)
          @persistent_preferred_activities = args[:persistent_preferred_activities] if args.key?(:persistent_preferred_activities)
          @remove_user_disabled = args[:remove_user_disabled] if args.key?(:remove_user_disabled)
          @safe_boot_disabled = args[:safe_boot_disabled] if args.key?(:safe_boot_disabled)
          @screen_capture_disabled = args[:screen_capture_disabled] if args.key?(:screen_capture_disabled)
          @status_bar_disabled = args[:status_bar_disabled] if args.key?(:status_bar_disabled)
          @status_reporting_settings = args[:status_reporting_settings] if args.key?(:status_reporting_settings)
          @stay_on_plugged_modes = args[:stay_on_plugged_modes] if args.key?(:stay_on_plugged_modes)
          @system_update = args[:system_update] if args.key?(:system_update)
          @unmute_microphone_disabled = args[:unmute_microphone_disabled] if args.key?(:unmute_microphone_disabled)
          @version = args[:version] if args.key?(:version)
          @wifi_config_disabled = args[:wifi_config_disabled] if args.key?(:wifi_config_disabled)
          @wifi_configs_lockdown_enabled = args[:wifi_configs_lockdown_enabled] if args.key?(:wifi_configs_lockdown_enabled)
        end
      end
      
      # A power management event.
      class PowerManagementEvent
        include Google::Apis::Core::Hashable
      
        # For BATTERY_LEVEL_COLLECTED events, the battery level as a percentage.
        # Corresponds to the JSON property `batteryLevel`
        # @return [Float]
        attr_accessor :battery_level
      
        # The creation time of the event.
        # Corresponds to the JSON property `createTime`
        # @return [String]
        attr_accessor :create_time
      
        # Event type.
        # Corresponds to the JSON property `eventType`
        # @return [String]
        attr_accessor :event_type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @battery_level = args[:battery_level] if args.key?(:battery_level)
          @create_time = args[:create_time] if args.key?(:create_time)
          @event_type = args[:event_type] if args.key?(:event_type)
        end
      end
      
      # An enterprise signup URL.
      class SignupUrl
        include Google::Apis::Core::Hashable
      
        # The name of the resource. This must be included in the create enterprise
        # request at the end of the signup flow.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
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
          @name = args[:name] if args.key?(:name)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # Information about device software.
      class SoftwareInfo
        include Google::Apis::Core::Hashable
      
        # Android build Id string meant for displaying to the user, e.g. shamu-userdebug
        # 6.0.1 MOB30I 2756745 dev-keys.
        # Corresponds to the JSON property `androidBuildNumber`
        # @return [String]
        attr_accessor :android_build_number
      
        # Build time.
        # Corresponds to the JSON property `androidBuildTime`
        # @return [String]
        attr_accessor :android_build_time
      
        # The user visible Android version string, e.g. 6.0.1.
        # Corresponds to the JSON property `androidVersion`
        # @return [String]
        attr_accessor :android_version
      
        # The system bootloader version number, e.g. 0.6.7.
        # Corresponds to the JSON property `bootloaderVersion`
        # @return [String]
        attr_accessor :bootloader_version
      
        # Kernel version, e.g. 2.6.32.9-g103d848.
        # Corresponds to the JSON property `deviceKernelVersion`
        # @return [String]
        attr_accessor :device_kernel_version
      
        # Security patch level, e.g. 2016-05-01.
        # Corresponds to the JSON property `securityPatchLevel`
        # @return [String]
        attr_accessor :security_patch_level
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @android_build_number = args[:android_build_number] if args.key?(:android_build_number)
          @android_build_time = args[:android_build_time] if args.key?(:android_build_time)
          @android_version = args[:android_version] if args.key?(:android_version)
          @bootloader_version = args[:bootloader_version] if args.key?(:bootloader_version)
          @device_kernel_version = args[:device_kernel_version] if args.key?(:device_kernel_version)
          @security_patch_level = args[:security_patch_level] if args.key?(:security_patch_level)
        end
      end
      
      # The Status type defines a logical error model that is suitable for different
      # programming environments, including REST APIs and RPC APIs. It is used by gRPC
      # (https://github.com/grpc). The error model is designed to be:
      # Simple to use and understand for most users
      # Flexible enough to meet unexpected needsOverviewThe Status message contains
      # three pieces of data: error code, error message, and error details. The error
      # code should be an enum value of google.rpc.Code, but it may accept additional
      # error codes if needed. The error message should be a developer-facing English
      # message that helps developers understand and resolve the error. If a localized
      # user-facing error message is needed, put the localized message in the error
      # details or localize it in the client. The optional error details may contain
      # arbitrary information about the error. There is a predefined set of error
      # detail types in the package google.rpc that can be used for common error
      # conditions.Language mappingThe Status message is the logical representation of
      # the error model, but it is not necessarily the actual wire format. When the
      # Status message is exposed in different client libraries and different wire
      # protocols, it can be mapped differently. For example, it will likely be mapped
      # to some exceptions in Java, but more likely mapped to some error codes in C.
      # Other usesThe error model and the Status message can be used in a variety of
      # environments, either with or without APIs, to provide a consistent developer
      # experience across different environments.Example uses of this error model
      # include:
      # Partial errors. If a service needs to return partial errors to the client, it
      # may embed the Status in the normal response to indicate the partial errors.
      # Workflow errors. A typical workflow has multiple steps. Each step may have a
      # Status message for error reporting.
      # Batch operations. If a client uses batch request and batch response, the
      # Status message should be used directly inside batch response, one for each
      # error sub-response.
      # Asynchronous operations. If an API call embeds asynchronous operation results
      # in its response, the status of those operations should be represented directly
      # using the Status message.
      # Logging. If some API errors are stored in logs, the message Status could be
      # used directly after any stripping needed for security/privacy reasons.
      class Status
        include Google::Apis::Core::Hashable
      
        # The status code, which should be an enum value of google.rpc.Code.
        # Corresponds to the JSON property `code`
        # @return [Fixnum]
        attr_accessor :code
      
        # A list of messages that carry the error details. There is a common set of
        # message types for APIs to use.
        # Corresponds to the JSON property `details`
        # @return [Array<Hash<String,Object>>]
        attr_accessor :details
      
        # A developer-facing error message, which should be in English. Any user-facing
        # error message should be localized and sent in the google.rpc.Status.details
        # field, or localized by the client.
        # Corresponds to the JSON property `message`
        # @return [String]
        attr_accessor :message
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @code = args[:code] if args.key?(:code)
          @details = args[:details] if args.key?(:details)
          @message = args[:message] if args.key?(:message)
        end
      end
      
      # Settings controlling the behavior of status reports.
      class StatusReportingSettings
        include Google::Apis::Core::Hashable
      
        # Whether displays reporting is enabled.
        # Corresponds to the JSON property `displayInfoEnabled`
        # @return [Boolean]
        attr_accessor :display_info_enabled
        alias_method :display_info_enabled?, :display_info_enabled
      
        # Whether hardware status reporting is enabled.
        # Corresponds to the JSON property `hardwareStatusEnabled`
        # @return [Boolean]
        attr_accessor :hardware_status_enabled
        alias_method :hardware_status_enabled?, :hardware_status_enabled
      
        # Whether memory info reporting is enabled.
        # Corresponds to the JSON property `memoryInfoEnabled`
        # @return [Boolean]
        attr_accessor :memory_info_enabled
        alias_method :memory_info_enabled?, :memory_info_enabled
      
        # Whether network info reporting is enabled.
        # Corresponds to the JSON property `networkInfoEnabled`
        # @return [Boolean]
        attr_accessor :network_info_enabled
        alias_method :network_info_enabled?, :network_info_enabled
      
        # Whether power management event reporting is enabled.
        # Corresponds to the JSON property `powerManagementEventsEnabled`
        # @return [Boolean]
        attr_accessor :power_management_events_enabled
        alias_method :power_management_events_enabled?, :power_management_events_enabled
      
        # Whether software info reporting is enabled.
        # Corresponds to the JSON property `softwareInfoEnabled`
        # @return [Boolean]
        attr_accessor :software_info_enabled
        alias_method :software_info_enabled?, :software_info_enabled
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @display_info_enabled = args[:display_info_enabled] if args.key?(:display_info_enabled)
          @hardware_status_enabled = args[:hardware_status_enabled] if args.key?(:hardware_status_enabled)
          @memory_info_enabled = args[:memory_info_enabled] if args.key?(:memory_info_enabled)
          @network_info_enabled = args[:network_info_enabled] if args.key?(:network_info_enabled)
          @power_management_events_enabled = args[:power_management_events_enabled] if args.key?(:power_management_events_enabled)
          @software_info_enabled = args[:software_info_enabled] if args.key?(:software_info_enabled)
        end
      end
      
      # Configuration for managing system updates
      class SystemUpdate
        include Google::Apis::Core::Hashable
      
        # If the type is WINDOWED, the end of the maintenance window, measured as the
        # number of minutes after midnight in device local time. This value must be
        # between 0 and 1439, inclusive. If this value is less than start_minutes, then
        # the maintenance window spans midnight. If the maintenance window specified is
        # smaller than 30 minutes, the actual window is extended to 30 minutes beyond
        # the start time.
        # Corresponds to the JSON property `endMinutes`
        # @return [Fixnum]
        attr_accessor :end_minutes
      
        # If the type is WINDOWED, the start of the maintenance window, measured as the
        # number of minutes after midnight in device local time. This value must be
        # between 0 and 1439, inclusive.
        # Corresponds to the JSON property `startMinutes`
        # @return [Fixnum]
        attr_accessor :start_minutes
      
        # The type of system update to configure.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @end_minutes = args[:end_minutes] if args.key?(:end_minutes)
          @start_minutes = args[:start_minutes] if args.key?(:start_minutes)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # Provides user facing message with locale info. The maximum message length is
      # 4096 characters.
      class UserFacingMessage
        include Google::Apis::Core::Hashable
      
        # The default message that gets displayed if no localized message is specified,
        # or the user's locale does not match with any of the localized messages. A
        # default message must be provided if any localized messages are provided.
        # Corresponds to the JSON property `defaultMessage`
        # @return [String]
        attr_accessor :default_message
      
        # A map which contains <locale, message> pairs. The locale is a BCP 47 language
        # code, e.g. en-US, es-ES, fr.
        # Corresponds to the JSON property `localizedMessages`
        # @return [Hash<String,String>]
        attr_accessor :localized_messages
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_message = args[:default_message] if args.key?(:default_message)
          @localized_messages = args[:localized_messages] if args.key?(:localized_messages)
        end
      end
      
      # A web token used to access an embeddable managed Google Play web UI.
      class WebToken
        include Google::Apis::Core::Hashable
      
        # The name of the web token, which is generated by the server during creation,
        # in the form enterprises/`enterpriseId`/webTokens/`webTokenId`.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The URL of the parent frame hosting the iframe with the embedded UI. To
        # prevent XSS, the iframe may not be hosted at other URLs. The URL must use the
        # https scheme.
        # Corresponds to the JSON property `parentFrameUrl`
        # @return [String]
        attr_accessor :parent_frame_url
      
        # Permissions the admin may exercise in the embedded UI. The admin must have all
        # of these permissions in order to view the UI.
        # Corresponds to the JSON property `permissions`
        # @return [Array<String>]
        attr_accessor :permissions
      
        # The token value which is used in the hosting page to generate the iframe with
        # the embedded UI. This is a read-only field generated by the server.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @name = args[:name] if args.key?(:name)
          @parent_frame_url = args[:parent_frame_url] if args.key?(:parent_frame_url)
          @permissions = args[:permissions] if args.key?(:permissions)
          @value = args[:value] if args.key?(:value)
        end
      end
    end
  end
end
