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
    module CloudfunctionsV1beta2
      
      # Request for the `CallFunction` method.
      class CallFunctionRequest
        include Google::Apis::Core::Hashable
      
        # Input to be passed to the function.
        # Corresponds to the JSON property `data`
        # @return [String]
        attr_accessor :data
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @data = args[:data] if args.key?(:data)
        end
      end
      
      # Response of `CallFunction` method.
      class CallFunctionResponse
        include Google::Apis::Core::Hashable
      
        # Either system or user-function generated error. Set if execution
        # was not successful.
        # Corresponds to the JSON property `error`
        # @return [String]
        attr_accessor :error
      
        # Execution id of function invocation.
        # Corresponds to the JSON property `executionId`
        # @return [String]
        attr_accessor :execution_id
      
        # Result populated for successful execution of synchronous function. Will
        # not be populated if function does not return a result through context.
        # Corresponds to the JSON property `result`
        # @return [String]
        attr_accessor :result
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @error = args[:error] if args.key?(:error)
          @execution_id = args[:execution_id] if args.key?(:execution_id)
          @result = args[:result] if args.key?(:result)
        end
      end
      
      # Describes a Cloud Function that contains user computation executed in
      # response to an event. It encapsulate function and triggers configurations.
      class CloudFunction
        include Google::Apis::Core::Hashable
      
        # The amount of memory in MB available for a function.
        # Defaults to 256MB.
        # Corresponds to the JSON property `availableMemoryMb`
        # @return [Fixnum]
        attr_accessor :available_memory_mb
      
        # The name of the function (as defined in source code) that will be
        # executed. Defaults to the resource name suffix, if not specified. For
        # backward compatibility, if function with given name is not found, then the
        # system will try to use function named "function".
        # For Node.js this is name of a function exported by the module specified
        # in `source_location`.
        # Corresponds to the JSON property `entryPoint`
        # @return [String]
        attr_accessor :entry_point
      
        # Describes EventTrigger, used to request events be sent from another
        # service.
        # Corresponds to the JSON property `eventTrigger`
        # @return [Google::Apis::CloudfunctionsV1beta2::EventTrigger]
        attr_accessor :event_trigger
      
        # Describes HTTPSTrigger, could be used to connect web hooks to function.
        # Corresponds to the JSON property `httpsTrigger`
        # @return [Google::Apis::CloudfunctionsV1beta2::HttpsTrigger]
        attr_accessor :https_trigger
      
        # Output only. Name of the most recent operation modifying the function. If
        # the function status is `DEPLOYING` or `DELETING`, then it points to the
        # active operation.
        # Corresponds to the JSON property `latestOperation`
        # @return [String]
        attr_accessor :latest_operation
      
        # A user-defined name of the function. Function names must be unique
        # globally and match pattern `projects/*/locations/*/functions/*`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Output only. The service account of the function.
        # Corresponds to the JSON property `serviceAccount`
        # @return [String]
        attr_accessor :service_account
      
        # The Google Cloud Storage URL, starting with gs://, pointing to the zip
        # archive which contains the function.
        # Corresponds to the JSON property `sourceArchiveUrl`
        # @return [String]
        attr_accessor :source_archive_url
      
        # Describes the location of the function source in a remote repository.
        # Corresponds to the JSON property `sourceRepository`
        # @return [Google::Apis::CloudfunctionsV1beta2::SourceRepository]
        attr_accessor :source_repository
      
        # The URL pointing to the hosted repository where the function is defined.
        # There are supported Cloud Source Repository URLs in the following
        # formats:
        # To refer to a specific commit:
        # `https://source.developers.google.com/projects/*/repos/*/revisions/*/paths/*`
        # To refer to a moveable alias (branch):
        # `https://source.developers.google.com/projects/*/repos/*/aliases/movable/*/
        # paths/*`
        # In particular, to refer to HEAD use `master` moveable alias.
        # To refer to a specific fixed alias (tag):
        # `https://source.developers.google.com/projects/*/repos/*/aliases/fixed/*/paths/
        # *`
        # You may omit `paths/*` if you want to use the main directory.
        # Corresponds to the JSON property `sourceRepositoryUrl`
        # @return [String]
        attr_accessor :source_repository_url
      
        # Output only. Status of the function deployment.
        # Corresponds to the JSON property `status`
        # @return [String]
        attr_accessor :status
      
        # The function execution timeout. Execution is considered failed and
        # can be terminated if the function is not completed at the end of the
        # timeout period. Defaults to 60 seconds.
        # Corresponds to the JSON property `timeout`
        # @return [String]
        attr_accessor :timeout
      
        # Output only. The last update timestamp of a Cloud Function.
        # Corresponds to the JSON property `updateTime`
        # @return [String]
        attr_accessor :update_time
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @available_memory_mb = args[:available_memory_mb] if args.key?(:available_memory_mb)
          @entry_point = args[:entry_point] if args.key?(:entry_point)
          @event_trigger = args[:event_trigger] if args.key?(:event_trigger)
          @https_trigger = args[:https_trigger] if args.key?(:https_trigger)
          @latest_operation = args[:latest_operation] if args.key?(:latest_operation)
          @name = args[:name] if args.key?(:name)
          @service_account = args[:service_account] if args.key?(:service_account)
          @source_archive_url = args[:source_archive_url] if args.key?(:source_archive_url)
          @source_repository = args[:source_repository] if args.key?(:source_repository)
          @source_repository_url = args[:source_repository_url] if args.key?(:source_repository_url)
          @status = args[:status] if args.key?(:status)
          @timeout = args[:timeout] if args.key?(:timeout)
          @update_time = args[:update_time] if args.key?(:update_time)
        end
      end
      
      # Describes EventTrigger, used to request events be sent from another
      # service.
      class EventTrigger
        include Google::Apis::Core::Hashable
      
        # `event_type` names contain the service that is sending an event and the
        # kind of event that was fired. Must be of the form
        # `providers/*/eventTypes/*` e.g. Directly handle a Message published to
        # Google Cloud Pub/Sub `providers/cloud.pubsub/eventTypes/topic.publish`
        # Handle an object changing in Google Cloud Storage
        # `providers/cloud.storage/eventTypes/object.change`
        # Handle a write to the Firebase Realtime Database
        # `providers/firebase.database/eventTypes/data.write`
        # Corresponds to the JSON property `eventType`
        # @return [String]
        attr_accessor :event_type
      
        # Describes the policy in case of function's execution failure.
        # If empty, then defaults to ignoring failures (i.e. not retrying them).
        # Corresponds to the JSON property `failurePolicy`
        # @return [Google::Apis::CloudfunctionsV1beta2::FailurePolicy]
        attr_accessor :failure_policy
      
        # Which instance of the source's service should send events. E.g. for Pub/Sub
        # this would be a Pub/Sub topic at `projects/*/topics/*`. For Google Cloud
        # Storage this would be a bucket at `projects/*/buckets/*`. For any source
        # that only supports one instance per-project, this should be the name of the
        # project (`projects/*`)
        # Corresponds to the JSON property `resource`
        # @return [String]
        attr_accessor :resource
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @event_type = args[:event_type] if args.key?(:event_type)
          @failure_policy = args[:failure_policy] if args.key?(:failure_policy)
          @resource = args[:resource] if args.key?(:resource)
        end
      end
      
      # Describes the policy in case of function's execution failure.
      # If empty, then defaults to ignoring failures (i.e. not retrying them).
      class FailurePolicy
        include Google::Apis::Core::Hashable
      
        # Describes the retry policy in case of function's execution failure.
        # A function execution will be retried on any failure.
        # A failed execution will be retried up to 7 days with an exponential backoff
        # (capped at 10 seconds).
        # Retried execution is charged as any other execution.
        # Corresponds to the JSON property `retry`
        # @return [Google::Apis::CloudfunctionsV1beta2::Retry]
        attr_accessor :retry
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @retry = args[:retry] if args.key?(:retry)
        end
      end
      
      # Describes HTTPSTrigger, could be used to connect web hooks to function.
      class HttpsTrigger
        include Google::Apis::Core::Hashable
      
        # Output only. The deployed url for the function.
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
      
      # Response for the `ListFunctions` method.
      class ListFunctionsResponse
        include Google::Apis::Core::Hashable
      
        # The functions that match the request.
        # Corresponds to the JSON property `functions`
        # @return [Array<Google::Apis::CloudfunctionsV1beta2::CloudFunction>]
        attr_accessor :functions
      
        # If not empty, indicates that there may be more functions that match
        # the request; this value should be passed in a new
        # google.cloud.functions.v1beta2.ListFunctionsRequest
        # to get more functions.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @functions = args[:functions] if args.key?(:functions)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
        end
      end
      
      # The response message for Locations.ListLocations.
      class ListLocationsResponse
        include Google::Apis::Core::Hashable
      
        # A list of locations that matches the specified filter in the request.
        # Corresponds to the JSON property `locations`
        # @return [Array<Google::Apis::CloudfunctionsV1beta2::Location>]
        attr_accessor :locations
      
        # The standard List next-page token.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @locations = args[:locations] if args.key?(:locations)
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
        # @return [Array<Google::Apis::CloudfunctionsV1beta2::Operation>]
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
      
      # A resource that represents Google Cloud Platform location.
      class Location
        include Google::Apis::Core::Hashable
      
        # Cross-service attributes for the location. For example
        # `"cloud.googleapis.com/region": "us-east1"`
        # Corresponds to the JSON property `labels`
        # @return [Hash<String,String>]
        attr_accessor :labels
      
        # The canonical id for this location. For example: `"us-east1"`.
        # Corresponds to the JSON property `locationId`
        # @return [String]
        attr_accessor :location_id
      
        # Service-specific metadata. For example the available capacity at the given
        # location.
        # Corresponds to the JSON property `metadata`
        # @return [Hash<String,Object>]
        attr_accessor :metadata
      
        # Resource name for the location, which may vary between implementations.
        # For example: `"projects/example-project/locations/us-east1"`
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @labels = args[:labels] if args.key?(:labels)
          @location_id = args[:location_id] if args.key?(:location_id)
          @metadata = args[:metadata] if args.key?(:metadata)
          @name = args[:name] if args.key?(:name)
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
        # @return [Google::Apis::CloudfunctionsV1beta2::Status]
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
      
      # Metadata describing an Operation
      class OperationMetadataV1Beta2
        include Google::Apis::Core::Hashable
      
        # The original request that started the operation.
        # Corresponds to the JSON property `request`
        # @return [Hash<String,Object>]
        attr_accessor :request
      
        # Target of the operation - for example
        # projects/project-1/locations/region-1/functions/function-1
        # Corresponds to the JSON property `target`
        # @return [String]
        attr_accessor :target
      
        # Type of operation.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @request = args[:request] if args.key?(:request)
          @target = args[:target] if args.key?(:target)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # Describes the retry policy in case of function's execution failure.
      # A function execution will be retried on any failure.
      # A failed execution will be retried up to 7 days with an exponential backoff
      # (capped at 10 seconds).
      # Retried execution is charged as any other execution.
      class Retry
        include Google::Apis::Core::Hashable
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
        end
      end
      
      # Describes the location of the function source in a remote repository.
      class SourceRepository
        include Google::Apis::Core::Hashable
      
        # The name of the branch from which the function should be fetched.
        # Corresponds to the JSON property `branch`
        # @return [String]
        attr_accessor :branch
      
        # Output only. The id of the revision that was resolved at the moment of
        # function creation or update. For example when a user deployed from a
        # branch, it will be the revision id of the latest change on this branch at
        # that time. If user deployed from revision then this value will be always
        # equal to the revision specified by the user.
        # Corresponds to the JSON property `deployedRevision`
        # @return [String]
        attr_accessor :deployed_revision
      
        # URL to the hosted repository where the function is defined. Only paths in
        # https://source.developers.google.com domain are supported. The path should
        # contain the name of the repository.
        # Corresponds to the JSON property `repositoryUrl`
        # @return [String]
        attr_accessor :repository_url
      
        # The id of the revision that captures the state of the repository from
        # which the function should be fetched.
        # Corresponds to the JSON property `revision`
        # @return [String]
        attr_accessor :revision
      
        # The path within the repository where the function is defined. The path
        # should point to the directory where Cloud Functions files are located. Use
        # "/" if the function is defined directly in the root directory of a
        # repository.
        # Corresponds to the JSON property `sourcePath`
        # @return [String]
        attr_accessor :source_path
      
        # The name of the tag that captures the state of the repository from
        # which the function should be fetched.
        # Corresponds to the JSON property `tag`
        # @return [String]
        attr_accessor :tag
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @branch = args[:branch] if args.key?(:branch)
          @deployed_revision = args[:deployed_revision] if args.key?(:deployed_revision)
          @repository_url = args[:repository_url] if args.key?(:repository_url)
          @revision = args[:revision] if args.key?(:revision)
          @source_path = args[:source_path] if args.key?(:source_path)
          @tag = args[:tag] if args.key?(:tag)
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
    end
  end
end
