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
    module AndroidpublisherV2
      # Google Play Developer API
      #
      # Lets Android application developers access their Google Play accounts.
      #
      # @example
      #    require 'google/apis/androidpublisher_v2'
      #
      #    Androidpublisher = Google::Apis::AndroidpublisherV2 # Alias the module
      #    service = Androidpublisher::AndroidPublisherService.new
      #
      # @see https://developers.google.com/android-publisher
      class AndroidPublisherService < Google::Apis::Core::BaseService
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
          super('https://www.googleapis.com/', 'androidpublisher/v2/applications/')
          @batch_path = 'batch/androidpublisher/v2'
        end
        
        # Commits/applies the changes made in this edit back to the app.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppEdit] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppEdit]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def commit_edit(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/edits/{editId}:commit', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::AppEdit::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppEdit
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes an edit for an app. Creating a new edit will automatically delete any
        # of your previous edits so this method need only be called if you want to
        # preemptively abandon an edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        def delete_edit(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns information about the edit specified. Calls will fail if the edit is
        # no long active (e.g. has been deleted, superseded or expired).
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppEdit] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppEdit]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_edit(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::AppEdit::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppEdit
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new edit for an app, populated with the app's current state.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [Google::Apis::AndroidpublisherV2::AppEdit] app_edit_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppEdit] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppEdit]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def insert_edit(package_name, app_edit_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/edits', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::AppEdit::Representation
          command.request_object = app_edit_object
          command.response_representation = Google::Apis::AndroidpublisherV2::AppEdit::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppEdit
          command.params['packageName'] = package_name unless package_name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Checks that the edit can be successfully committed. The edit's changes are not
        # applied to the live app.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppEdit] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppEdit]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def validate_edit(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/edits/{editId}:validate', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::AppEdit::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppEdit
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes the APK-specific localized listing for a specified APK and language
        # code.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The APK version code whose APK-specific listings should be read or modified.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the APK-specific localized
        #   listing to read or modify. For example, to select Austrian German, pass "de-AT"
        #   .
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
        def delete_apk_listing(package_name, edit_id, apk_version_code, language, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}/apks/{apkVersionCode}/listings/{language}', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes all the APK-specific localized listings for a specified APK.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The APK version code whose APK-specific listings should be read or modified.
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
        def delete_all_apk_listings(package_name, edit_id, apk_version_code, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}/apks/{apkVersionCode}/listings', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetches the APK-specific localized listing for a specified APK and language
        # code.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The APK version code whose APK-specific listings should be read or modified.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the APK-specific localized
        #   listing to read or modify. For example, to select Austrian German, pass "de-AT"
        #   .
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ApkListing] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ApkListing]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_apk_listing(package_name, edit_id, apk_version_code, language, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/apks/{apkVersionCode}/listings/{language}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ApkListing::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ApkListing
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all the APK-specific localized listings for a specified APK.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The APK version code whose APK-specific listings should be read or modified.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListApkListingsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListApkListingsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_apk_listings(package_name, edit_id, apk_version_code, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/apks/{apkVersionCode}/listings', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListApkListingsResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListApkListingsResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates or creates the APK-specific localized listing for a specified APK and
        # language code. This method supports patch semantics.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The APK version code whose APK-specific listings should be read or modified.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the APK-specific localized
        #   listing to read or modify. For example, to select Austrian German, pass "de-AT"
        #   .
        # @param [Google::Apis::AndroidpublisherV2::ApkListing] apk_listing_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ApkListing] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ApkListing]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_apk_listing(package_name, edit_id, apk_version_code, language, apk_listing_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/edits/{editId}/apks/{apkVersionCode}/listings/{language}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::ApkListing::Representation
          command.request_object = apk_listing_object
          command.response_representation = Google::Apis::AndroidpublisherV2::ApkListing::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ApkListing
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates or creates the APK-specific localized listing for a specified APK and
        # language code.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The APK version code whose APK-specific listings should be read or modified.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the APK-specific localized
        #   listing to read or modify. For example, to select Austrian German, pass "de-AT"
        #   .
        # @param [Google::Apis::AndroidpublisherV2::ApkListing] apk_listing_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ApkListing] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ApkListing]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_apk_listing(package_name, edit_id, apk_version_code, language, apk_listing_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/edits/{editId}/apks/{apkVersionCode}/listings/{language}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::ApkListing::Representation
          command.request_object = apk_listing_object
          command.response_representation = Google::Apis::AndroidpublisherV2::ApkListing::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ApkListing
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new APK without uploading the APK itself to Google Play, instead
        # hosting the APK at a specified URL. This function is only available to
        # enterprises using Google Play for Work whose application is configured to
        # restrict distribution to the enterprise domain.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Google::Apis::AndroidpublisherV2::ApksAddExternallyHostedRequest] apks_add_externally_hosted_request_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ApksAddExternallyHostedResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ApksAddExternallyHostedResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def add_externally_hosted_apk(package_name, edit_id, apks_add_externally_hosted_request_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/edits/{editId}/apks/externallyHosted', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::ApksAddExternallyHostedRequest::Representation
          command.request_object = apks_add_externally_hosted_request_object
          command.response_representation = Google::Apis::AndroidpublisherV2::ApksAddExternallyHostedResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ApksAddExternallyHostedResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # 
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListApksResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListApksResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_apks(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/apks', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListApksResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListApksResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # 
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [IO, String] upload_source
        #   IO stream or filename containing content to upload
        # @param [String] content_type
        #   Content type of the uploaded content.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Apk] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Apk]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def upload_apk(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, upload_source: nil, content_type: nil, options: nil, &block)
          if upload_source.nil?
            command =  make_simple_command(:post, '{packageName}/edits/{editId}/apks', options)
          else
            command = make_upload_command(:post, '{packageName}/edits/{editId}/apks', options)
            command.upload_source = upload_source
            command.upload_content_type = content_type
          end
          command.response_representation = Google::Apis::AndroidpublisherV2::Apk::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Apk
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Uploads the deobfuscation file of the specified APK. If a deobfuscation file
        # already exists, it will be replaced.
        # @param [String] package_name
        #   Unique identifier of the Android app for which the deobfuscatiuon files are
        #   being uploaded; for example, "com.spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The version code of the APK whose deobfuscation file is being uploaded.
        # @param [String] deobfuscation_file_type
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [IO, String] upload_source
        #   IO stream or filename containing content to upload
        # @param [String] content_type
        #   Content type of the uploaded content.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::AndroidpublisherV2::DeobfuscationFilesUploadResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::DeobfuscationFilesUploadResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def upload_edit_deobfuscationfile(package_name, edit_id, apk_version_code, deobfuscation_file_type, fields: nil, quota_user: nil, user_ip: nil, upload_source: nil, content_type: nil, options: nil, &block)
          if upload_source.nil?
            command =  make_simple_command(:post, '{packageName}/edits/{editId}/apks/{apkVersionCode}/deobfuscationFiles/{deobfuscationFileType}', options)
          else
            command = make_upload_command(:post, '{packageName}/edits/{editId}/apks/{apkVersionCode}/deobfuscationFiles/{deobfuscationFileType}', options)
            command.upload_source = upload_source
            command.upload_content_type = content_type
          end
          command.response_representation = Google::Apis::AndroidpublisherV2::DeobfuscationFilesUploadResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::DeobfuscationFilesUploadResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['deobfuscationFileType'] = deobfuscation_file_type unless deobfuscation_file_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetches app details for this edit. This includes the default language and
        # developer support contact information.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppDetails] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppDetails]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_detail(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/details', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::AppDetails::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppDetails
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates app details for this edit. This method supports patch semantics.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Google::Apis::AndroidpublisherV2::AppDetails] app_details_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppDetails] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppDetails]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_detail(package_name, edit_id, app_details_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/edits/{editId}/details', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::AppDetails::Representation
          command.request_object = app_details_object
          command.response_representation = Google::Apis::AndroidpublisherV2::AppDetails::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppDetails
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates app details for this edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Google::Apis::AndroidpublisherV2::AppDetails] app_details_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::AppDetails] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::AppDetails]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_detail(package_name, edit_id, app_details_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/edits/{editId}/details', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::AppDetails::Representation
          command.request_object = app_details_object
          command.response_representation = Google::Apis::AndroidpublisherV2::AppDetails::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::AppDetails
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetches the Expansion File configuration for the APK specified.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The version code of the APK whose Expansion File configuration is being read
        #   or modified.
        # @param [String] expansion_file_type
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ExpansionFile] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ExpansionFile]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_expansion_file(package_name, edit_id, apk_version_code, expansion_file_type, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/apks/{apkVersionCode}/expansionFiles/{expansionFileType}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ExpansionFile::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ExpansionFile
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['expansionFileType'] = expansion_file_type unless expansion_file_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the APK's Expansion File configuration to reference another APK's
        # Expansion Files. To add a new Expansion File use the Upload method. This
        # method supports patch semantics.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The version code of the APK whose Expansion File configuration is being read
        #   or modified.
        # @param [String] expansion_file_type
        # @param [Google::Apis::AndroidpublisherV2::ExpansionFile] expansion_file_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ExpansionFile] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ExpansionFile]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_expansion_file(package_name, edit_id, apk_version_code, expansion_file_type, expansion_file_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/edits/{editId}/apks/{apkVersionCode}/expansionFiles/{expansionFileType}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::ExpansionFile::Representation
          command.request_object = expansion_file_object
          command.response_representation = Google::Apis::AndroidpublisherV2::ExpansionFile::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ExpansionFile
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['expansionFileType'] = expansion_file_type unless expansion_file_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the APK's Expansion File configuration to reference another APK's
        # Expansion Files. To add a new Expansion File use the Upload method.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The version code of the APK whose Expansion File configuration is being read
        #   or modified.
        # @param [String] expansion_file_type
        # @param [Google::Apis::AndroidpublisherV2::ExpansionFile] expansion_file_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ExpansionFile] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ExpansionFile]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_expansion_file(package_name, edit_id, apk_version_code, expansion_file_type, expansion_file_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/edits/{editId}/apks/{apkVersionCode}/expansionFiles/{expansionFileType}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::ExpansionFile::Representation
          command.request_object = expansion_file_object
          command.response_representation = Google::Apis::AndroidpublisherV2::ExpansionFile::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ExpansionFile
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['expansionFileType'] = expansion_file_type unless expansion_file_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Uploads and attaches a new Expansion File to the APK specified.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [Fixnum] apk_version_code
        #   The version code of the APK whose Expansion File configuration is being read
        #   or modified.
        # @param [String] expansion_file_type
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [IO, String] upload_source
        #   IO stream or filename containing content to upload
        # @param [String] content_type
        #   Content type of the uploaded content.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::AndroidpublisherV2::UploadExpansionFilesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::UploadExpansionFilesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def upload_expansion_file(package_name, edit_id, apk_version_code, expansion_file_type, fields: nil, quota_user: nil, user_ip: nil, upload_source: nil, content_type: nil, options: nil, &block)
          if upload_source.nil?
            command =  make_simple_command(:post, '{packageName}/edits/{editId}/apks/{apkVersionCode}/expansionFiles/{expansionFileType}', options)
          else
            command = make_upload_command(:post, '{packageName}/edits/{editId}/apks/{apkVersionCode}/expansionFiles/{expansionFileType}', options)
            command.upload_source = upload_source
            command.upload_content_type = content_type
          end
          command.response_representation = Google::Apis::AndroidpublisherV2::UploadExpansionFilesResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::UploadExpansionFilesResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['apkVersionCode'] = apk_version_code unless apk_version_code.nil?
          command.params['expansionFileType'] = expansion_file_type unless expansion_file_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes the image (specified by id) from the edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing whose
        #   images are to read or modified. For example, to select Austrian German, pass "
        #   de-AT".
        # @param [String] image_type
        # @param [String] image_id
        #   Unique identifier an image within the set of images attached to this edit.
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
        def delete_image(package_name, edit_id, language, image_type, image_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}/listings/{language}/{imageType}/{imageId}', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.params['imageType'] = image_type unless image_type.nil?
          command.params['imageId'] = image_id unless image_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes all images for the specified language and image type.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing whose
        #   images are to read or modified. For example, to select Austrian German, pass "
        #   de-AT".
        # @param [String] image_type
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::DeleteAllImagesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::DeleteAllImagesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_all_images(package_name, edit_id, language, image_type, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}/listings/{language}/{imageType}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::DeleteAllImagesResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::DeleteAllImagesResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.params['imageType'] = image_type unless image_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all images for the specified language and image type.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing whose
        #   images are to read or modified. For example, to select Austrian German, pass "
        #   de-AT".
        # @param [String] image_type
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListImagesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListImagesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_images(package_name, edit_id, language, image_type, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/listings/{language}/{imageType}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListImagesResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListImagesResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.params['imageType'] = image_type unless image_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Uploads a new image and adds it to the list of images for the specified
        # language and image type.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing whose
        #   images are to read or modified. For example, to select Austrian German, pass "
        #   de-AT".
        # @param [String] image_type
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        #   Overrides userIp if both are provided.
        # @param [String] user_ip
        #   IP address of the site where the request originates. Use this if you want to
        #   enforce per-user limits.
        # @param [IO, String] upload_source
        #   IO stream or filename containing content to upload
        # @param [String] content_type
        #   Content type of the uploaded content.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::AndroidpublisherV2::UploadImagesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::UploadImagesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def upload_image(package_name, edit_id, language, image_type, fields: nil, quota_user: nil, user_ip: nil, upload_source: nil, content_type: nil, options: nil, &block)
          if upload_source.nil?
            command =  make_simple_command(:post, '{packageName}/edits/{editId}/listings/{language}/{imageType}', options)
          else
            command = make_upload_command(:post, '{packageName}/edits/{editId}/listings/{language}/{imageType}', options)
            command.upload_source = upload_source
            command.upload_content_type = content_type
          end
          command.response_representation = Google::Apis::AndroidpublisherV2::UploadImagesResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::UploadImagesResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.params['imageType'] = image_type unless image_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes the specified localized store listing from an edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing to read or
        #   modify. For example, to select Austrian German, pass "de-AT".
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
        def delete_listing(package_name, edit_id, language, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}/listings/{language}', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes all localized listings from an edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        def delete_all_listings(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/edits/{editId}/listings', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetches information about a localized store listing.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing to read or
        #   modify. For example, to select Austrian German, pass "de-AT".
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Listing] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Listing]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_listing(package_name, edit_id, language, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/listings/{language}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::Listing::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Listing
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns all of the localized store listings attached to this edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListListingsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListListingsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_listings(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/listings', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListListingsResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListListingsResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates or updates a localized store listing. This method supports patch
        # semantics.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing to read or
        #   modify. For example, to select Austrian German, pass "de-AT".
        # @param [Google::Apis::AndroidpublisherV2::Listing] listing_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Listing] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Listing]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_listing(package_name, edit_id, language, listing_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/edits/{editId}/listings/{language}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::Listing::Representation
          command.request_object = listing_object
          command.response_representation = Google::Apis::AndroidpublisherV2::Listing::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Listing
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates or updates a localized store listing.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] language
        #   The language code (a BCP-47 language tag) of the localized listing to read or
        #   modify. For example, to select Austrian German, pass "de-AT".
        # @param [Google::Apis::AndroidpublisherV2::Listing] listing_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Listing] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Listing]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_listing(package_name, edit_id, language, listing_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/edits/{editId}/listings/{language}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::Listing::Representation
          command.request_object = listing_object
          command.response_representation = Google::Apis::AndroidpublisherV2::Listing::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Listing
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['language'] = language unless language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # 
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] track
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Testers] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Testers]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_tester(package_name, edit_id, track, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/testers/{track}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::Testers::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Testers
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['track'] = track unless track.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # 
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] track
        # @param [Google::Apis::AndroidpublisherV2::Testers] testers_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Testers] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Testers]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_tester(package_name, edit_id, track, testers_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/edits/{editId}/testers/{track}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::Testers::Representation
          command.request_object = testers_object
          command.response_representation = Google::Apis::AndroidpublisherV2::Testers::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Testers
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['track'] = track unless track.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # 
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] track
        # @param [Google::Apis::AndroidpublisherV2::Testers] testers_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Testers] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Testers]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_tester(package_name, edit_id, track, testers_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/edits/{editId}/testers/{track}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::Testers::Representation
          command.request_object = testers_object
          command.response_representation = Google::Apis::AndroidpublisherV2::Testers::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Testers
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['track'] = track unless track.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Fetches the track configuration for the specified track type. Includes the APK
        # version codes that are in this track.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] track
        #   The track type to read or modify.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Track] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Track]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_track(package_name, edit_id, track, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/tracks/{track}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::Track::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Track
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['track'] = track unless track.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all the track configurations for this edit.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListTracksResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListTracksResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_tracks(package_name, edit_id, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/edits/{editId}/tracks', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListTracksResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListTracksResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the track configuration for the specified track type. When halted, the
        # rollout track cannot be updated without adding new APKs, and adding new APKs
        # will cause it to resume. This method supports patch semantics.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] track
        #   The track type to read or modify.
        # @param [Google::Apis::AndroidpublisherV2::Track] track_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Track] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Track]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_track(package_name, edit_id, track, track_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/edits/{editId}/tracks/{track}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::Track::Representation
          command.request_object = track_object
          command.response_representation = Google::Apis::AndroidpublisherV2::Track::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Track
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['track'] = track unless track.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the track configuration for the specified track type. When halted, the
        # rollout track cannot be updated without adding new APKs, and adding new APKs
        # will cause it to resume.
        # @param [String] package_name
        #   Unique identifier for the Android app that is being updated; for example, "com.
        #   spiffygame".
        # @param [String] edit_id
        #   Unique identifier for this edit.
        # @param [String] track
        #   The track type to read or modify.
        # @param [Google::Apis::AndroidpublisherV2::Track] track_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Track] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Track]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_track(package_name, edit_id, track, track_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/edits/{editId}/tracks/{track}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::Track::Representation
          command.request_object = track_object
          command.response_representation = Google::Apis::AndroidpublisherV2::Track::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Track
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['editId'] = edit_id unless edit_id.nil?
          command.params['track'] = track unless track.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists the user's current inapp item or subscription entitlements
        # @param [String] package_name
        #   The package name of the application the inapp product was sold in (for example,
        #   'com.some.thing').
        # @param [Fixnum] max_results
        # @param [String] product_id
        #   The product id of the inapp product (for example, 'sku1'). This can be used to
        #   restrict the result set.
        # @param [Fixnum] start_index
        # @param [String] token
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListEntitlementsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListEntitlementsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_entitlements(package_name, max_results: nil, product_id: nil, start_index: nil, token: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/entitlements', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListEntitlementsResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListEntitlementsResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['productId'] = product_id unless product_id.nil?
          command.query['startIndex'] = start_index unless start_index.nil?
          command.query['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # 
        # @param [Google::Apis::AndroidpublisherV2::InAppProductsBatchRequest] in_app_products_batch_request_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::InAppProductsBatchResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::InAppProductsBatchResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def batch_update_in_app_products(in_app_products_batch_request_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, 'inappproducts/batch', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::InAppProductsBatchRequest::Representation
          command.request_object = in_app_products_batch_request_object
          command.response_representation = Google::Apis::AndroidpublisherV2::InAppProductsBatchResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::InAppProductsBatchResponse
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Delete an in-app product for an app.
        # @param [String] package_name
        #   Unique identifier for the Android app with the in-app product; for example, "
        #   com.spiffygame".
        # @param [String] sku
        #   Unique identifier for the in-app product.
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
        def delete_in_app_product(package_name, sku, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:delete, '{packageName}/inappproducts/{sku}', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['sku'] = sku unless sku.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns information about the in-app product specified.
        # @param [String] package_name
        # @param [String] sku
        #   Unique identifier for the in-app product.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::InAppProduct] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_in_app_product(package_name, sku, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/inappproducts/{sku}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::InAppProduct
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['sku'] = sku unless sku.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new in-app product for an app.
        # @param [String] package_name
        #   Unique identifier for the Android app; for example, "com.spiffygame".
        # @param [Google::Apis::AndroidpublisherV2::InAppProduct] in_app_product_object
        # @param [Boolean] auto_convert_missing_prices
        #   If true the prices for all regions targeted by the parent app that don't have
        #   a price specified for this in-app product will be auto converted to the target
        #   currency based on the default price. Defaults to false.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::InAppProduct] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def insert_in_app_product(package_name, in_app_product_object = nil, auto_convert_missing_prices: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/inappproducts', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.request_object = in_app_product_object
          command.response_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::InAppProduct
          command.params['packageName'] = package_name unless package_name.nil?
          command.query['autoConvertMissingPrices'] = auto_convert_missing_prices unless auto_convert_missing_prices.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # List all the in-app products for an Android app, both subscriptions and
        # managed in-app products..
        # @param [String] package_name
        #   Unique identifier for the Android app with in-app products; for example, "com.
        #   spiffygame".
        # @param [Fixnum] max_results
        # @param [Fixnum] start_index
        # @param [String] token
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ListInAppProductsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ListInAppProductsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_in_app_products(package_name, max_results: nil, start_index: nil, token: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/inappproducts', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ListInAppProductsResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ListInAppProductsResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['startIndex'] = start_index unless start_index.nil?
          command.query['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the details of an in-app product. This method supports patch semantics.
        # @param [String] package_name
        #   Unique identifier for the Android app with the in-app product; for example, "
        #   com.spiffygame".
        # @param [String] sku
        #   Unique identifier for the in-app product.
        # @param [Google::Apis::AndroidpublisherV2::InAppProduct] in_app_product_object
        # @param [Boolean] auto_convert_missing_prices
        #   If true the prices for all regions targeted by the parent app that don't have
        #   a price specified for this in-app product will be auto converted to the target
        #   currency based on the default price. Defaults to false.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::InAppProduct] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_in_app_product(package_name, sku, in_app_product_object = nil, auto_convert_missing_prices: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:patch, '{packageName}/inappproducts/{sku}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.request_object = in_app_product_object
          command.response_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::InAppProduct
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['sku'] = sku unless sku.nil?
          command.query['autoConvertMissingPrices'] = auto_convert_missing_prices unless auto_convert_missing_prices.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the details of an in-app product.
        # @param [String] package_name
        #   Unique identifier for the Android app with the in-app product; for example, "
        #   com.spiffygame".
        # @param [String] sku
        #   Unique identifier for the in-app product.
        # @param [Google::Apis::AndroidpublisherV2::InAppProduct] in_app_product_object
        # @param [Boolean] auto_convert_missing_prices
        #   If true the prices for all regions targeted by the parent app that don't have
        #   a price specified for this in-app product will be auto converted to the target
        #   currency based on the default price. Defaults to false.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::InAppProduct] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def update_in_app_product(package_name, sku, in_app_product_object = nil, auto_convert_missing_prices: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:put, '{packageName}/inappproducts/{sku}', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.request_object = in_app_product_object
          command.response_representation = Google::Apis::AndroidpublisherV2::InAppProduct::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::InAppProduct
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['sku'] = sku unless sku.nil?
          command.query['autoConvertMissingPrices'] = auto_convert_missing_prices unless auto_convert_missing_prices.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Checks the purchase and consumption status of an inapp item.
        # @param [String] package_name
        #   The package name of the application the inapp product was sold in (for example,
        #   'com.some.thing').
        # @param [String] product_id
        #   The inapp product SKU (for example, 'com.some.thing.inapp1').
        # @param [String] token
        #   The token provided to the user's device when the inapp product was purchased.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ProductPurchase] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ProductPurchase]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_purchase_product(package_name, product_id, token, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/purchases/products/{productId}/tokens/{token}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ProductPurchase::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ProductPurchase
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['productId'] = product_id unless product_id.nil?
          command.params['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Cancels a user's subscription purchase. The subscription remains valid until
        # its expiration time.
        # @param [String] package_name
        #   The package name of the application for which this subscription was purchased (
        #   for example, 'com.some.thing').
        # @param [String] subscription_id
        #   The purchased subscription ID (for example, 'monthly001').
        # @param [String] token
        #   The token provided to the user's device when the subscription was purchased.
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
        def cancel_purchase_subscription(package_name, subscription_id, token, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/purchases/subscriptions/{subscriptionId}/tokens/{token}:cancel', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['subscriptionId'] = subscription_id unless subscription_id.nil?
          command.params['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Defers a user's subscription purchase until a specified future expiration time.
        # @param [String] package_name
        #   The package name of the application for which this subscription was purchased (
        #   for example, 'com.some.thing').
        # @param [String] subscription_id
        #   The purchased subscription ID (for example, 'monthly001').
        # @param [String] token
        #   The token provided to the user's device when the subscription was purchased.
        # @param [Google::Apis::AndroidpublisherV2::DeferSubscriptionPurchasesRequest] defer_subscription_purchases_request_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::DeferSubscriptionPurchasesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::DeferSubscriptionPurchasesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def defer_purchase_subscription(package_name, subscription_id, token, defer_subscription_purchases_request_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/purchases/subscriptions/{subscriptionId}/tokens/{token}:defer', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::DeferSubscriptionPurchasesRequest::Representation
          command.request_object = defer_subscription_purchases_request_object
          command.response_representation = Google::Apis::AndroidpublisherV2::DeferSubscriptionPurchasesResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::DeferSubscriptionPurchasesResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['subscriptionId'] = subscription_id unless subscription_id.nil?
          command.params['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Checks whether a user's subscription purchase is valid and returns its expiry
        # time.
        # @param [String] package_name
        #   The package name of the application for which this subscription was purchased (
        #   for example, 'com.some.thing').
        # @param [String] subscription_id
        #   The purchased subscription ID (for example, 'monthly001').
        # @param [String] token
        #   The token provided to the user's device when the subscription was purchased.
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::SubscriptionPurchase] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::SubscriptionPurchase]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_purchase_subscription(package_name, subscription_id, token, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/purchases/subscriptions/{subscriptionId}/tokens/{token}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::SubscriptionPurchase::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::SubscriptionPurchase
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['subscriptionId'] = subscription_id unless subscription_id.nil?
          command.params['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Refunds a user's subscription purchase, but the subscription remains valid
        # until its expiration time and it will continue to recur.
        # @param [String] package_name
        #   The package name of the application for which this subscription was purchased (
        #   for example, 'com.some.thing').
        # @param [String] subscription_id
        #   The purchased subscription ID (for example, 'monthly001').
        # @param [String] token
        #   The token provided to the user's device when the subscription was purchased.
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
        def refund_purchase_subscription(package_name, subscription_id, token, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/purchases/subscriptions/{subscriptionId}/tokens/{token}:refund', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['subscriptionId'] = subscription_id unless subscription_id.nil?
          command.params['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Refunds and immediately revokes a user's subscription purchase. Access to the
        # subscription will be terminated immediately and it will stop recurring.
        # @param [String] package_name
        #   The package name of the application for which this subscription was purchased (
        #   for example, 'com.some.thing').
        # @param [String] subscription_id
        #   The purchased subscription ID (for example, 'monthly001').
        # @param [String] token
        #   The token provided to the user's device when the subscription was purchased.
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
        def revoke_purchase_subscription(package_name, subscription_id, token, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/purchases/subscriptions/{subscriptionId}/tokens/{token}:revoke', options)
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['subscriptionId'] = subscription_id unless subscription_id.nil?
          command.params['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists the purchases that were cancelled, refunded or charged-back.
        # @param [String] package_name
        #   The package name of the application for which voided purchases need to be
        #   returned (for example, 'com.some.thing').
        # @param [Fixnum] end_time
        #   The time, in milliseconds since the Epoch, of the newest voided in-app product
        #   purchase that you want to see in the response. The value of this parameter
        #   cannot be greater than the current time and is ignored if a pagination token
        #   is set. Default value is current time. Note: This filter is applied on the
        #   time at which the record is seen as voided by our systems and not the actual
        #   voided time returned in the response.
        # @param [Fixnum] max_results
        # @param [Fixnum] start_index
        # @param [Fixnum] start_time
        #   The time, in milliseconds since the Epoch, of the oldest voided in-app product
        #   purchase that you want to see in the response. The value of this parameter
        #   cannot be older than 30 days and is ignored if a pagination token is set.
        #   Default value is current time minus 30 days. Note: This filter is applied on
        #   the time at which the record is seen as voided by our systems and not the
        #   actual voided time returned in the response.
        # @param [String] token
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::VoidedPurchasesListResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::VoidedPurchasesListResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_purchase_voidedpurchases(package_name, end_time: nil, max_results: nil, start_index: nil, start_time: nil, token: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/purchases/voidedpurchases', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::VoidedPurchasesListResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::VoidedPurchasesListResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.query['endTime'] = end_time unless end_time.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['startIndex'] = start_index unless start_index.nil?
          command.query['startTime'] = start_time unless start_time.nil?
          command.query['token'] = token unless token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns a single review.
        # @param [String] package_name
        #   Unique identifier for the Android app for which we want reviews; for example, "
        #   com.spiffygame".
        # @param [String] review_id
        # @param [String] translation_language
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::Review] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::Review]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_review(package_name, review_id, translation_language: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/reviews/{reviewId}', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::Review::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::Review
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['reviewId'] = review_id unless review_id.nil?
          command.query['translationLanguage'] = translation_language unless translation_language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns a list of reviews. Only reviews from last week will be returned.
        # @param [String] package_name
        #   Unique identifier for the Android app for which we want reviews; for example, "
        #   com.spiffygame".
        # @param [Fixnum] max_results
        # @param [Fixnum] start_index
        # @param [String] token
        # @param [String] translation_language
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ReviewsListResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ReviewsListResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_reviews(package_name, max_results: nil, start_index: nil, token: nil, translation_language: nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:get, '{packageName}/reviews', options)
          command.response_representation = Google::Apis::AndroidpublisherV2::ReviewsListResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ReviewsListResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.query['maxResults'] = max_results unless max_results.nil?
          command.query['startIndex'] = start_index unless start_index.nil?
          command.query['token'] = token unless token.nil?
          command.query['translationLanguage'] = translation_language unless translation_language.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          command.query['userIp'] = user_ip unless user_ip.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Reply to a single review, or update an existing reply.
        # @param [String] package_name
        #   Unique identifier for the Android app for which we want reviews; for example, "
        #   com.spiffygame".
        # @param [String] review_id
        # @param [Google::Apis::AndroidpublisherV2::ReviewsReplyRequest] reviews_reply_request_object
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
        # @yieldparam result [Google::Apis::AndroidpublisherV2::ReviewsReplyResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::AndroidpublisherV2::ReviewsReplyResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def reply_review(package_name, review_id, reviews_reply_request_object = nil, fields: nil, quota_user: nil, user_ip: nil, options: nil, &block)
          command =  make_simple_command(:post, '{packageName}/reviews/{reviewId}:reply', options)
          command.request_representation = Google::Apis::AndroidpublisherV2::ReviewsReplyRequest::Representation
          command.request_object = reviews_reply_request_object
          command.response_representation = Google::Apis::AndroidpublisherV2::ReviewsReplyResponse::Representation
          command.response_class = Google::Apis::AndroidpublisherV2::ReviewsReplyResponse
          command.params['packageName'] = package_name unless package_name.nil?
          command.params['reviewId'] = review_id unless review_id.nil?
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
