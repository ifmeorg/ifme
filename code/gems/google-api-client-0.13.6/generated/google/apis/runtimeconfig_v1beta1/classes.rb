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
    module RuntimeconfigV1beta1
      
      # Associates `members` with a `role`.
      class Binding
        include Google::Apis::Core::Hashable
      
        # Specifies the identities requesting access for a Cloud Platform resource.
        # `members` can have the following values:
        # * `allUsers`: A special identifier that represents anyone who is
        # on the internet; with or without a Google account.
        # * `allAuthenticatedUsers`: A special identifier that represents anyone
        # who is authenticated with a Google account or a service account.
        # * `user:`emailid``: An email address that represents a specific Google
        # account. For example, `alice@gmail.com` or `joe@example.com`.
        # * `serviceAccount:`emailid``: An email address that represents a service
        # account. For example, `my-other-app@appspot.gserviceaccount.com`.
        # * `group:`emailid``: An email address that represents a Google group.
        # For example, `admins@example.com`.
        # * `domain:`domain``: A Google Apps domain name that represents all the
        # users of that domain. For example, `google.com` or `example.com`.
        # Corresponds to the JSON property `members`
        # @return [Array<String>]
        attr_accessor :members
      
        # Role that is assigned to `members`.
        # For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
        # Required
        # Corresponds to the JSON property `role`
        # @return [String]
        attr_accessor :role
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @members = args[:members] if args.key?(:members)
          @role = args[:role] if args.key?(:role)
        end
      end
      
      # A Cardinality condition for the Waiter resource. A cardinality condition is
      # met when the number of variables under a specified path prefix reaches a
      # predefined number. For example, if you set a Cardinality condition where
      # the `path` is set to `/foo` and the number of paths is set to 2, the
      # following variables would meet the condition in a RuntimeConfig resource:
      # + `/foo/variable1 = "value1"`
      # + `/foo/variable2 = "value2"`
      # + `/bar/variable3 = "value3"`
      # It would not would not satisify the same condition with the `number` set to
      # 3, however, because there is only 2 paths that start with `/foo`.
      # Cardinality conditions are recursive; all subtrees under the specific
      # path prefix are counted.
      class Cardinality
        include Google::Apis::Core::Hashable
      
        # The number variables under the `path` that must exist to meet this
        # condition. Defaults to 1 if not specified.
        # Corresponds to the JSON property `number`
        # @return [Fixnum]
        attr_accessor :number
      
        # The root of the variable subtree to monitor. For example, `/foo`.
        # Corresponds to the JSON property `path`
        # @return [String]
        attr_accessor :path
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @number = args[:number] if args.key?(:number)
          @path = args[:path] if args.key?(:path)
        end
      end
      
      # A generic empty message that you can re-use to avoid defining duplicated
      # empty messages in your APIs. A typical example is to use it as the request
      # or the response type of an API method. For instance:
      # service Foo `
      # rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
      # `
      # The JSON representation for `Empty` is empty JSON object ````.
      class Empty
        include Google::Apis::Core::Hashable
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
        end
      end
      
      # The condition that a Waiter resource is waiting for.
      class EndCondition
        include Google::Apis::Core::Hashable
      
        # A Cardinality condition for the Waiter resource. A cardinality condition is
        # met when the number of variables under a specified path prefix reaches a
        # predefined number. For example, if you set a Cardinality condition where
        # the `path` is set to `/foo` and the number of paths is set to 2, the
        # following variables would meet the condition in a RuntimeConfig resource:
        # + `/foo/variable1 = "value1"`
        # + `/foo/variable2 = "value2"`
        # + `/bar/variable3 = "value3"`
        # It would not would not satisify the same condition with the `number` set to
        # 3, however, because there is only 2 paths that start with `/foo`.
        # Cardinality conditions are recursive; all subtrees under the specific
        # path prefix are counted.
        # Corresponds to the JSON property `cardinality`
        # @return [Google::Apis::RuntimeconfigV1beta1::Cardinality]
        attr_accessor :cardinality
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cardinality = args[:cardinality] if args.key?(:cardinality)
        end
      end
      
      # `ListConfigs()` returns the following response. The order of returned
      # objects is arbitrary; that is, it is not ordered in any particular way.
      class ListConfigsResponse
        include Google::Apis::Core::Hashable
      
        # A list of the configurations in the project. The order of returned
        # objects is arbitrary; that is, it is not ordered in any particular way.
        # Corresponds to the JSON property `configs`
        # @return [Array<Google::Apis::RuntimeconfigV1beta1::RuntimeConfig>]
        attr_accessor :configs
      
        # This token allows you to get the next page of results for list requests.
        # If the number of results is larger than `pageSize`, use the `nextPageToken`
        # as a value for the query parameter `pageToken` in the next list request.
        # Subsequent list requests will have their own `nextPageToken` to continue
        # paging through the results
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @configs = args[:configs] if args.key?(:configs)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
        end
      end
      
      # Response for the `ListVariables()` method.
      class ListVariablesResponse
        include Google::Apis::Core::Hashable
      
        # This token allows you to get the next page of results for list requests.
        # If the number of results is larger than `pageSize`, use the `nextPageToken`
        # as a value for the query parameter `pageToken` in the next list request.
        # Subsequent list requests will have their own `nextPageToken` to continue
        # paging through the results
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # A list of variables and their values. The order of returned variable
        # objects is arbitrary.
        # Corresponds to the JSON property `variables`
        # @return [Array<Google::Apis::RuntimeconfigV1beta1::Variable>]
        attr_accessor :variables
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @variables = args[:variables] if args.key?(:variables)
        end
      end
      
      # Response for the `ListWaiters()` method.
      # Order of returned waiter objects is arbitrary.
      class ListWaitersResponse
        include Google::Apis::Core::Hashable
      
        # This token allows you to get the next page of results for list requests.
        # If the number of results is larger than `pageSize`, use the `nextPageToken`
        # as a value for the query parameter `pageToken` in the next list request.
        # Subsequent list requests will have their own `nextPageToken` to continue
        # paging through the results
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # Found waiters in the project.
        # Corresponds to the JSON property `waiters`
        # @return [Array<Google::Apis::RuntimeconfigV1beta1::Waiter>]
        attr_accessor :waiters
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @waiters = args[:waiters] if args.key?(:waiters)
        end
      end
      
      # This resource represents a long-running operation that is the result of a
      # network API call.
      class Operation
        include Google::Apis::Core::Hashable
      
        # If the value is `false`, it means the operation is still in progress.
        # If `true`, the operation is completed, and either `error` or `response` is
        # available.
        # Corresponds to the JSON property `done`
        # @return [Boolean]
        attr_accessor :done
        alias_method :done?, :done
      
        # The `Status` type defines a logical error model that is suitable for different
        # programming environments, including REST APIs and RPC APIs. It is used by
        # [gRPC](https://github.com/grpc). The error model is designed to be:
        # - Simple to use and understand for most users
        # - Flexible enough to meet unexpected needs
        # # Overview
        # The `Status` message contains three pieces of data: error code, error message,
        # and error details. The error code should be an enum value of
        # google.rpc.Code, but it may accept additional error codes if needed.  The
        # error message should be a developer-facing English message that helps
        # developers *understand* and *resolve* the error. If a localized user-facing
        # error message is needed, put the localized message in the error details or
        # localize it in the client. The optional error details may contain arbitrary
        # information about the error. There is a predefined set of error detail types
        # in the package `google.rpc` that can be used for common error conditions.
        # # Language mapping
        # The `Status` message is the logical representation of the error model, but it
        # is not necessarily the actual wire format. When the `Status` message is
        # exposed in different client libraries and different wire protocols, it can be
        # mapped differently. For example, it will likely be mapped to some exceptions
        # in Java, but more likely mapped to some error codes in C.
        # # Other uses
        # The error model and the `Status` message can be used in a variety of
        # environments, either with or without APIs, to provide a
        # consistent developer experience across different environments.
        # Example uses of this error model include:
        # - Partial errors. If a service needs to return partial errors to the client,
        # it may embed the `Status` in the normal response to indicate the partial
        # errors.
        # - Workflow errors. A typical workflow has multiple steps. Each step may
        # have a `Status` message for error reporting.
        # - Batch operations. If a client uses batch request and batch response, the
        # `Status` message should be used directly inside batch response, one for
        # each error sub-response.
        # - Asynchronous operations. If an API call embeds asynchronous operation
        # results in its response, the status of those operations should be
        # represented directly using the `Status` message.
        # - Logging. If some API errors are stored in logs, the message `Status` could
        # be used directly after any stripping needed for security/privacy reasons.
        # Corresponds to the JSON property `error`
        # @return [Google::Apis::RuntimeconfigV1beta1::Status]
        attr_accessor :error
      
        # Service-specific metadata associated with the operation.  It typically
        # contains progress information and common metadata such as create time.
        # Some services might not provide such metadata.  Any method that returns a
        # long-running operation should document the metadata type, if any.
        # Corresponds to the JSON property `metadata`
        # @return [Hash<String,Object>]
        attr_accessor :metadata
      
        # The server-assigned name, which is only unique within the same service that
        # originally returns it. If you use the default HTTP mapping, the
        # `name` should have the format of `operations/some/unique/name`.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The normal response of the operation in case of success.  If the original
        # method returns no data on success, such as `Delete`, the response is
        # `google.protobuf.Empty`.  If the original method is standard
        # `Get`/`Create`/`Update`, the response should be the resource.  For other
        # methods, the response should have the type `XxxResponse`, where `Xxx`
        # is the original method name.  For example, if the original method name
        # is `TakeSnapshot()`, the inferred response type is
        # `TakeSnapshotResponse`.
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
      
      # Defines an Identity and Access Management (IAM) policy. It is used to
      # specify access control policies for Cloud Platform resources.
      # A `Policy` consists of a list of `bindings`. A `Binding` binds a list of
      # `members` to a `role`, where the members can be user accounts, Google groups,
      # Google domains, and service accounts. A `role` is a named list of permissions
      # defined by IAM.
      # **Example**
      # `
      # "bindings": [
      # `
      # "role": "roles/owner",
      # "members": [
      # "user:mike@example.com",
      # "group:admins@example.com",
      # "domain:google.com",
      # "serviceAccount:my-other-app@appspot.gserviceaccount.com",
      # ]
      # `,
      # `
      # "role": "roles/viewer",
      # "members": ["user:sean@example.com"]
      # `
      # ]
      # `
      # For a description of IAM and its features, see the
      # [IAM developer's guide](https://cloud.google.com/iam).
      class Policy
        include Google::Apis::Core::Hashable
      
        # Associates a list of `members` to a `role`.
        # `bindings` with no members will result in an error.
        # Corresponds to the JSON property `bindings`
        # @return [Array<Google::Apis::RuntimeconfigV1beta1::Binding>]
        attr_accessor :bindings
      
        # `etag` is used for optimistic concurrency control as a way to help
        # prevent simultaneous updates of a policy from overwriting each other.
        # It is strongly suggested that systems make use of the `etag` in the
        # read-modify-write cycle to perform policy updates in order to avoid race
        # conditions: An `etag` is returned in the response to `getIamPolicy`, and
        # systems are expected to put that etag in the request to `setIamPolicy` to
        # ensure that their change will be applied to the same version of the policy.
        # If no `etag` is provided in the call to `setIamPolicy`, then the existing
        # policy is overwritten blindly.
        # Corresponds to the JSON property `etag`
        # NOTE: Values are automatically base64 encoded/decoded in the client library.
        # @return [String]
        attr_accessor :etag
      
        # Version of the `Policy`. The default version is 0.
        # Corresponds to the JSON property `version`
        # @return [Fixnum]
        attr_accessor :version
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bindings = args[:bindings] if args.key?(:bindings)
          @etag = args[:etag] if args.key?(:etag)
          @version = args[:version] if args.key?(:version)
        end
      end
      
      # A RuntimeConfig resource is the primary resource in the Cloud RuntimeConfig
      # service. A RuntimeConfig resource consists of metadata and a hierarchy of
      # variables.
      class RuntimeConfig
        include Google::Apis::Core::Hashable
      
        # An optional description of the RuntimeConfig object.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # The resource name of a runtime config. The name must have the format:
        # projects/[PROJECT_ID]/configs/[CONFIG_NAME]
        # The `[PROJECT_ID]` must be a valid project ID, and `[CONFIG_NAME]` is an
        # arbitrary name that matches RFC 1035 segment specification. The length of
        # `[CONFIG_NAME]` must be less than 64 bytes.
        # You pick the RuntimeConfig resource name, but the server will validate that
        # the name adheres to this format. After you create the resource, you cannot
        # change the resource's name.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @description = args[:description] if args.key?(:description)
          @name = args[:name] if args.key?(:name)
        end
      end
      
      # Request message for `SetIamPolicy` method.
      class SetIamPolicyRequest
        include Google::Apis::Core::Hashable
      
        # Defines an Identity and Access Management (IAM) policy. It is used to
        # specify access control policies for Cloud Platform resources.
        # A `Policy` consists of a list of `bindings`. A `Binding` binds a list of
        # `members` to a `role`, where the members can be user accounts, Google groups,
        # Google domains, and service accounts. A `role` is a named list of permissions
        # defined by IAM.
        # **Example**
        # `
        # "bindings": [
        # `
        # "role": "roles/owner",
        # "members": [
        # "user:mike@example.com",
        # "group:admins@example.com",
        # "domain:google.com",
        # "serviceAccount:my-other-app@appspot.gserviceaccount.com",
        # ]
        # `,
        # `
        # "role": "roles/viewer",
        # "members": ["user:sean@example.com"]
        # `
        # ]
        # `
        # For a description of IAM and its features, see the
        # [IAM developer's guide](https://cloud.google.com/iam).
        # Corresponds to the JSON property `policy`
        # @return [Google::Apis::RuntimeconfigV1beta1::Policy]
        attr_accessor :policy
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @policy = args[:policy] if args.key?(:policy)
        end
      end
      
      # The `Status` type defines a logical error model that is suitable for different
      # programming environments, including REST APIs and RPC APIs. It is used by
      # [gRPC](https://github.com/grpc). The error model is designed to be:
      # - Simple to use and understand for most users
      # - Flexible enough to meet unexpected needs
      # # Overview
      # The `Status` message contains three pieces of data: error code, error message,
      # and error details. The error code should be an enum value of
      # google.rpc.Code, but it may accept additional error codes if needed.  The
      # error message should be a developer-facing English message that helps
      # developers *understand* and *resolve* the error. If a localized user-facing
      # error message is needed, put the localized message in the error details or
      # localize it in the client. The optional error details may contain arbitrary
      # information about the error. There is a predefined set of error detail types
      # in the package `google.rpc` that can be used for common error conditions.
      # # Language mapping
      # The `Status` message is the logical representation of the error model, but it
      # is not necessarily the actual wire format. When the `Status` message is
      # exposed in different client libraries and different wire protocols, it can be
      # mapped differently. For example, it will likely be mapped to some exceptions
      # in Java, but more likely mapped to some error codes in C.
      # # Other uses
      # The error model and the `Status` message can be used in a variety of
      # environments, either with or without APIs, to provide a
      # consistent developer experience across different environments.
      # Example uses of this error model include:
      # - Partial errors. If a service needs to return partial errors to the client,
      # it may embed the `Status` in the normal response to indicate the partial
      # errors.
      # - Workflow errors. A typical workflow has multiple steps. Each step may
      # have a `Status` message for error reporting.
      # - Batch operations. If a client uses batch request and batch response, the
      # `Status` message should be used directly inside batch response, one for
      # each error sub-response.
      # - Asynchronous operations. If an API call embeds asynchronous operation
      # results in its response, the status of those operations should be
      # represented directly using the `Status` message.
      # - Logging. If some API errors are stored in logs, the message `Status` could
      # be used directly after any stripping needed for security/privacy reasons.
      class Status
        include Google::Apis::Core::Hashable
      
        # The status code, which should be an enum value of google.rpc.Code.
        # Corresponds to the JSON property `code`
        # @return [Fixnum]
        attr_accessor :code
      
        # A list of messages that carry the error details.  There is a common set of
        # message types for APIs to use.
        # Corresponds to the JSON property `details`
        # @return [Array<Hash<String,Object>>]
        attr_accessor :details
      
        # A developer-facing error message, which should be in English. Any
        # user-facing error message should be localized and sent in the
        # google.rpc.Status.details field, or localized by the client.
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
      
      # Request message for `TestIamPermissions` method.
      class TestIamPermissionsRequest
        include Google::Apis::Core::Hashable
      
        # The set of permissions to check for the `resource`. Permissions with
        # wildcards (such as '*' or 'storage.*') are not allowed. For more
        # information see
        # [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
        # Corresponds to the JSON property `permissions`
        # @return [Array<String>]
        attr_accessor :permissions
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @permissions = args[:permissions] if args.key?(:permissions)
        end
      end
      
      # Response message for `TestIamPermissions` method.
      class TestIamPermissionsResponse
        include Google::Apis::Core::Hashable
      
        # A subset of `TestPermissionsRequest.permissions` that the caller is
        # allowed.
        # Corresponds to the JSON property `permissions`
        # @return [Array<String>]
        attr_accessor :permissions
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @permissions = args[:permissions] if args.key?(:permissions)
        end
      end
      
      # Describes a single variable within a RuntimeConfig resource.
      # The name denotes the hierarchical variable name. For example,
      # `ports/serving_port` is a valid variable name. The variable value is an
      # opaque string and only leaf variables can have values (that is, variables
      # that do not have any child variables).
      class Variable
        include Google::Apis::Core::Hashable
      
        # The name of the variable resource, in the format:
        # projects/[PROJECT_ID]/configs/[CONFIG_NAME]/variables/[VARIABLE_NAME]
        # The `[PROJECT_ID]` must be a valid project ID, `[CONFIG_NAME]` must be a
        # valid RuntimeConfig reource and `[VARIABLE_NAME]` follows Unix file system
        # file path naming.
        # The `[VARIABLE_NAME]` can contain ASCII letters, numbers, slashes and
        # dashes. Slashes are used as path element separators and are not part of the
        # `[VARIABLE_NAME]` itself, so `[VARIABLE_NAME]` must contain at least one
        # non-slash character. Multiple slashes are coalesced into single slash
        # character. Each path segment should follow RFC 1035 segment specification.
        # The length of a `[VARIABLE_NAME]` must be less than 256 bytes.
        # Once you create a variable, you cannot change the variable name.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # [Ouput only] The current state of the variable. The variable state indicates
        # the outcome of the `variables().watch` call and is visible through the
        # `get` and `list` calls.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        # The string value of the variable. The length of the value must be less
        # than 4096 bytes. Empty values are also accepted. For example,
        # `text: "my text value"`. The string must be valid UTF-8.
        # Corresponds to the JSON property `text`
        # @return [String]
        attr_accessor :text
      
        # [Output Only] The time of the last variable update.
        # Corresponds to the JSON property `updateTime`
        # @return [String]
        attr_accessor :update_time
      
        # The binary value of the variable. The length of the value must be less
        # than 4096 bytes. Empty values are also accepted. The value must be
        # base64 encoded. Only one of `value` or `text` can be set.
        # Corresponds to the JSON property `value`
        # NOTE: Values are automatically base64 encoded/decoded in the client library.
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @name = args[:name] if args.key?(:name)
          @state = args[:state] if args.key?(:state)
          @text = args[:text] if args.key?(:text)
          @update_time = args[:update_time] if args.key?(:update_time)
          @value = args[:value] if args.key?(:value)
        end
      end
      
      # A Waiter resource waits for some end condition within a RuntimeConfig resource
      # to be met before it returns. For example, assume you have a distributed
      # system where each node writes to a Variable resource indidicating the node's
      # readiness as part of the startup process.
      # You then configure a Waiter resource with the success condition set to wait
      # until some number of nodes have checked in. Afterwards, your application
      # runs some arbitrary code after the condition has been met and the waiter
      # returns successfully.
      # Once created, a Waiter resource is immutable.
      # To learn more about using waiters, read the
      # [Creating a Waiter](/deployment-manager/runtime-configurator/creating-a-waiter)
      # documentation.
      class Waiter
        include Google::Apis::Core::Hashable
      
        # [Output Only] The instant at which this Waiter resource was created. Adding
        # the value of `timeout` to this instant yields the timeout deadline for the
        # waiter.
        # Corresponds to the JSON property `createTime`
        # @return [String]
        attr_accessor :create_time
      
        # [Output Only] If the value is `false`, it means the waiter is still waiting
        # for one of its conditions to be met.
        # If true, the waiter has finished. If the waiter finished due to a timeout
        # or failure, `error` will be set.
        # Corresponds to the JSON property `done`
        # @return [Boolean]
        attr_accessor :done
        alias_method :done?, :done
      
        # The `Status` type defines a logical error model that is suitable for different
        # programming environments, including REST APIs and RPC APIs. It is used by
        # [gRPC](https://github.com/grpc). The error model is designed to be:
        # - Simple to use and understand for most users
        # - Flexible enough to meet unexpected needs
        # # Overview
        # The `Status` message contains three pieces of data: error code, error message,
        # and error details. The error code should be an enum value of
        # google.rpc.Code, but it may accept additional error codes if needed.  The
        # error message should be a developer-facing English message that helps
        # developers *understand* and *resolve* the error. If a localized user-facing
        # error message is needed, put the localized message in the error details or
        # localize it in the client. The optional error details may contain arbitrary
        # information about the error. There is a predefined set of error detail types
        # in the package `google.rpc` that can be used for common error conditions.
        # # Language mapping
        # The `Status` message is the logical representation of the error model, but it
        # is not necessarily the actual wire format. When the `Status` message is
        # exposed in different client libraries and different wire protocols, it can be
        # mapped differently. For example, it will likely be mapped to some exceptions
        # in Java, but more likely mapped to some error codes in C.
        # # Other uses
        # The error model and the `Status` message can be used in a variety of
        # environments, either with or without APIs, to provide a
        # consistent developer experience across different environments.
        # Example uses of this error model include:
        # - Partial errors. If a service needs to return partial errors to the client,
        # it may embed the `Status` in the normal response to indicate the partial
        # errors.
        # - Workflow errors. A typical workflow has multiple steps. Each step may
        # have a `Status` message for error reporting.
        # - Batch operations. If a client uses batch request and batch response, the
        # `Status` message should be used directly inside batch response, one for
        # each error sub-response.
        # - Asynchronous operations. If an API call embeds asynchronous operation
        # results in its response, the status of those operations should be
        # represented directly using the `Status` message.
        # - Logging. If some API errors are stored in logs, the message `Status` could
        # be used directly after any stripping needed for security/privacy reasons.
        # Corresponds to the JSON property `error`
        # @return [Google::Apis::RuntimeconfigV1beta1::Status]
        attr_accessor :error
      
        # The condition that a Waiter resource is waiting for.
        # Corresponds to the JSON property `failure`
        # @return [Google::Apis::RuntimeconfigV1beta1::EndCondition]
        attr_accessor :failure
      
        # The name of the Waiter resource, in the format:
        # projects/[PROJECT_ID]/configs/[CONFIG_NAME]/waiters/[WAITER_NAME]
        # The `[PROJECT_ID]` must be a valid Google Cloud project ID,
        # the `[CONFIG_NAME]` must be a valid RuntimeConfig resource, the
        # `[WAITER_NAME]` must match RFC 1035 segment specification, and the length
        # of `[WAITER_NAME]` must be less than 64 bytes.
        # After you create a Waiter resource, you cannot change the resource name.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The condition that a Waiter resource is waiting for.
        # Corresponds to the JSON property `success`
        # @return [Google::Apis::RuntimeconfigV1beta1::EndCondition]
        attr_accessor :success
      
        # [Required] Specifies the timeout of the waiter in seconds, beginning from
        # the instant that `waiters().create` method is called. If this time elapses
        # before the success or failure conditions are met, the waiter fails and sets
        # the `error` code to `DEADLINE_EXCEEDED`.
        # Corresponds to the JSON property `timeout`
        # @return [String]
        attr_accessor :timeout
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @create_time = args[:create_time] if args.key?(:create_time)
          @done = args[:done] if args.key?(:done)
          @error = args[:error] if args.key?(:error)
          @failure = args[:failure] if args.key?(:failure)
          @name = args[:name] if args.key?(:name)
          @success = args[:success] if args.key?(:success)
          @timeout = args[:timeout] if args.key?(:timeout)
        end
      end
      
      # Request for the `WatchVariable()` method.
      class WatchVariableRequest
        include Google::Apis::Core::Hashable
      
        # If specified, checks the current timestamp of the variable and if the
        # current timestamp is newer than `newerThan` timestamp, the method returns
        # immediately.
        # If not specified or the variable has an older timestamp, the watcher waits
        # for a the value to change before returning.
        # Corresponds to the JSON property `newerThan`
        # @return [String]
        attr_accessor :newer_than
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @newer_than = args[:newer_than] if args.key?(:newer_than)
        end
      end
    end
  end
end
