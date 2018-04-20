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
    module AndroidpublisherV2
      
      # 
      class Apk
        include Google::Apis::Core::Hashable
      
        # Represents the binary payload of an APK.
        # Corresponds to the JSON property `binary`
        # @return [Google::Apis::AndroidpublisherV2::ApkBinary]
        attr_accessor :binary
      
        # The version code of the APK, as specified in the APK's manifest file.
        # Corresponds to the JSON property `versionCode`
        # @return [Fixnum]
        attr_accessor :version_code
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @binary = args[:binary] if args.key?(:binary)
          @version_code = args[:version_code] if args.key?(:version_code)
        end
      end
      
      # Represents the binary payload of an APK.
      class ApkBinary
        include Google::Apis::Core::Hashable
      
        # A sha1 hash of the APK payload, encoded as a hex string and matching the
        # output of the sha1sum command.
        # Corresponds to the JSON property `sha1`
        # @return [String]
        attr_accessor :sha1
      
        # A sha256 hash of the APK payload, encoded as a hex string and matching the
        # output of the sha256sum command.
        # Corresponds to the JSON property `sha256`
        # @return [String]
        attr_accessor :sha256
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @sha1 = args[:sha1] if args.key?(:sha1)
          @sha256 = args[:sha256] if args.key?(:sha256)
        end
      end
      
      # 
      class ApkListing
        include Google::Apis::Core::Hashable
      
        # The language code, in BCP 47 format (eg "en-US").
        # Corresponds to the JSON property `language`
        # @return [String]
        attr_accessor :language
      
        # Describe what's new in your APK.
        # Corresponds to the JSON property `recentChanges`
        # @return [String]
        attr_accessor :recent_changes
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @language = args[:language] if args.key?(:language)
          @recent_changes = args[:recent_changes] if args.key?(:recent_changes)
        end
      end
      
      # 
      class ListApkListingsResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidpublisher#apkListingsListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # 
        # Corresponds to the JSON property `listings`
        # @return [Array<Google::Apis::AndroidpublisherV2::ApkListing>]
        attr_accessor :listings
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @listings = args[:listings] if args.key?(:listings)
        end
      end
      
      # 
      class ApksAddExternallyHostedRequest
        include Google::Apis::Core::Hashable
      
        # Defines an APK available for this application that is hosted externally and
        # not uploaded to Google Play. This function is only available to enterprises
        # who are using Google Play for Work, and whos application is restricted to the
        # enterprise private channel
        # Corresponds to the JSON property `externallyHostedApk`
        # @return [Google::Apis::AndroidpublisherV2::ExternallyHostedApk]
        attr_accessor :externally_hosted_apk
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @externally_hosted_apk = args[:externally_hosted_apk] if args.key?(:externally_hosted_apk)
        end
      end
      
      # 
      class ApksAddExternallyHostedResponse
        include Google::Apis::Core::Hashable
      
        # Defines an APK available for this application that is hosted externally and
        # not uploaded to Google Play. This function is only available to enterprises
        # who are using Google Play for Work, and whos application is restricted to the
        # enterprise private channel
        # Corresponds to the JSON property `externallyHostedApk`
        # @return [Google::Apis::AndroidpublisherV2::ExternallyHostedApk]
        attr_accessor :externally_hosted_apk
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @externally_hosted_apk = args[:externally_hosted_apk] if args.key?(:externally_hosted_apk)
        end
      end
      
      # 
      class ListApksResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `apks`
        # @return [Array<Google::Apis::AndroidpublisherV2::Apk>]
        attr_accessor :apks
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidpublisher#apksListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @apks = args[:apks] if args.key?(:apks)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # 
      class AppDetails
        include Google::Apis::Core::Hashable
      
        # The user-visible support email for this app.
        # Corresponds to the JSON property `contactEmail`
        # @return [String]
        attr_accessor :contact_email
      
        # The user-visible support telephone number for this app.
        # Corresponds to the JSON property `contactPhone`
        # @return [String]
        attr_accessor :contact_phone
      
        # The user-visible website for this app.
        # Corresponds to the JSON property `contactWebsite`
        # @return [String]
        attr_accessor :contact_website
      
        # Default language code, in BCP 47 format (eg "en-US").
        # Corresponds to the JSON property `defaultLanguage`
        # @return [String]
        attr_accessor :default_language
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @contact_email = args[:contact_email] if args.key?(:contact_email)
          @contact_phone = args[:contact_phone] if args.key?(:contact_phone)
          @contact_website = args[:contact_website] if args.key?(:contact_website)
          @default_language = args[:default_language] if args.key?(:default_language)
        end
      end
      
      # Represents an edit of an app. An edit allows clients to make multiple changes
      # before committing them in one operation.
      class AppEdit
        include Google::Apis::Core::Hashable
      
        # The time at which the edit will expire and will be no longer valid for use in
        # any subsequent API calls (encoded as seconds since the Epoch).
        # Corresponds to the JSON property `expiryTimeSeconds`
        # @return [String]
        attr_accessor :expiry_time_seconds
      
        # The ID of the edit that can be used in subsequent API calls.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @expiry_time_seconds = args[:expiry_time_seconds] if args.key?(:expiry_time_seconds)
          @id = args[:id] if args.key?(:id)
        end
      end
      
      # 
      class Comment
        include Google::Apis::Core::Hashable
      
        # A comment from a developer.
        # Corresponds to the JSON property `developerComment`
        # @return [Google::Apis::AndroidpublisherV2::DeveloperComment]
        attr_accessor :developer_comment
      
        # A comment from a user.
        # Corresponds to the JSON property `userComment`
        # @return [Google::Apis::AndroidpublisherV2::UserComment]
        attr_accessor :user_comment
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @developer_comment = args[:developer_comment] if args.key?(:developer_comment)
          @user_comment = args[:user_comment] if args.key?(:user_comment)
        end
      end
      
      # Represents a deobfuscation file.
      class DeobfuscationFile
        include Google::Apis::Core::Hashable
      
        # The type of the deobfuscation file.
        # Corresponds to the JSON property `symbolType`
        # @return [String]
        attr_accessor :symbol_type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @symbol_type = args[:symbol_type] if args.key?(:symbol_type)
        end
      end
      
      # 
      class DeobfuscationFilesUploadResponse
        include Google::Apis::Core::Hashable
      
        # Represents a deobfuscation file.
        # Corresponds to the JSON property `deobfuscationFile`
        # @return [Google::Apis::AndroidpublisherV2::DeobfuscationFile]
        attr_accessor :deobfuscation_file
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @deobfuscation_file = args[:deobfuscation_file] if args.key?(:deobfuscation_file)
        end
      end
      
      # 
      class DeveloperComment
        include Google::Apis::Core::Hashable
      
        # The last time at which this comment was updated.
        # Corresponds to the JSON property `lastModified`
        # @return [Google::Apis::AndroidpublisherV2::Timestamp]
        attr_accessor :last_modified
      
        # The content of the comment, i.e. reply body.
        # Corresponds to the JSON property `text`
        # @return [String]
        attr_accessor :text
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @last_modified = args[:last_modified] if args.key?(:last_modified)
          @text = args[:text] if args.key?(:text)
        end
      end
      
      # 
      class DeviceMetadata
        include Google::Apis::Core::Hashable
      
        # Device CPU make e.g. "Qualcomm"
        # Corresponds to the JSON property `cpuMake`
        # @return [String]
        attr_accessor :cpu_make
      
        # Device CPU model e.g. "MSM8974"
        # Corresponds to the JSON property `cpuModel`
        # @return [String]
        attr_accessor :cpu_model
      
        # Device class (e.g. tablet)
        # Corresponds to the JSON property `deviceClass`
        # @return [String]
        attr_accessor :device_class
      
        # OpenGL version
        # Corresponds to the JSON property `glEsVersion`
        # @return [Fixnum]
        attr_accessor :gl_es_version
      
        # Device manufacturer (e.g. Motorola)
        # Corresponds to the JSON property `manufacturer`
        # @return [String]
        attr_accessor :manufacturer
      
        # Comma separated list of native platforms (e.g. "arm", "arm7")
        # Corresponds to the JSON property `nativePlatform`
        # @return [String]
        attr_accessor :native_platform
      
        # Device model name (e.g. Droid)
        # Corresponds to the JSON property `productName`
        # @return [String]
        attr_accessor :product_name
      
        # Device RAM in Megabytes e.g. "2048"
        # Corresponds to the JSON property `ramMb`
        # @return [Fixnum]
        attr_accessor :ram_mb
      
        # Screen density in DPI
        # Corresponds to the JSON property `screenDensityDpi`
        # @return [Fixnum]
        attr_accessor :screen_density_dpi
      
        # Screen height in pixels
        # Corresponds to the JSON property `screenHeightPx`
        # @return [Fixnum]
        attr_accessor :screen_height_px
      
        # Screen width in pixels
        # Corresponds to the JSON property `screenWidthPx`
        # @return [Fixnum]
        attr_accessor :screen_width_px
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cpu_make = args[:cpu_make] if args.key?(:cpu_make)
          @cpu_model = args[:cpu_model] if args.key?(:cpu_model)
          @device_class = args[:device_class] if args.key?(:device_class)
          @gl_es_version = args[:gl_es_version] if args.key?(:gl_es_version)
          @manufacturer = args[:manufacturer] if args.key?(:manufacturer)
          @native_platform = args[:native_platform] if args.key?(:native_platform)
          @product_name = args[:product_name] if args.key?(:product_name)
          @ram_mb = args[:ram_mb] if args.key?(:ram_mb)
          @screen_density_dpi = args[:screen_density_dpi] if args.key?(:screen_density_dpi)
          @screen_height_px = args[:screen_height_px] if args.key?(:screen_height_px)
          @screen_width_px = args[:screen_width_px] if args.key?(:screen_width_px)
        end
      end
      
      # An Entitlement resource indicates a user's current entitlement to an inapp
      # item or subscription.
      class Entitlement
        include Google::Apis::Core::Hashable
      
        # This kind represents an entitlement object in the androidpublisher service.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The SKU of the product.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # The type of the inapp product. Possible values are:
        # - In-app item: "inapp"
        # - Subscription: "subs"
        # Corresponds to the JSON property `productType`
        # @return [String]
        attr_accessor :product_type
      
        # The token which can be verified using the subscriptions or products API.
        # Corresponds to the JSON property `token`
        # @return [String]
        attr_accessor :token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @product_id = args[:product_id] if args.key?(:product_id)
          @product_type = args[:product_type] if args.key?(:product_type)
          @token = args[:token] if args.key?(:token)
        end
      end
      
      # 
      class ListEntitlementsResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `pageInfo`
        # @return [Google::Apis::AndroidpublisherV2::PageInfo]
        attr_accessor :page_info
      
        # 
        # Corresponds to the JSON property `resources`
        # @return [Array<Google::Apis::AndroidpublisherV2::Entitlement>]
        attr_accessor :resources
      
        # 
        # Corresponds to the JSON property `tokenPagination`
        # @return [Google::Apis::AndroidpublisherV2::TokenPagination]
        attr_accessor :token_pagination
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @page_info = args[:page_info] if args.key?(:page_info)
          @resources = args[:resources] if args.key?(:resources)
          @token_pagination = args[:token_pagination] if args.key?(:token_pagination)
        end
      end
      
      # 
      class ExpansionFile
        include Google::Apis::Core::Hashable
      
        # If set this field indicates that this APK has an Expansion File uploaded to it:
        # this APK does not reference another APK's Expansion File. The field's value
        # is the size of the uploaded Expansion File in bytes.
        # Corresponds to the JSON property `fileSize`
        # @return [Fixnum]
        attr_accessor :file_size
      
        # If set this APK's Expansion File references another APK's Expansion File. The
        # file_size field will not be set.
        # Corresponds to the JSON property `referencesVersion`
        # @return [Fixnum]
        attr_accessor :references_version
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @file_size = args[:file_size] if args.key?(:file_size)
          @references_version = args[:references_version] if args.key?(:references_version)
        end
      end
      
      # 
      class UploadExpansionFilesResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `expansionFile`
        # @return [Google::Apis::AndroidpublisherV2::ExpansionFile]
        attr_accessor :expansion_file
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @expansion_file = args[:expansion_file] if args.key?(:expansion_file)
        end
      end
      
      # Defines an APK available for this application that is hosted externally and
      # not uploaded to Google Play. This function is only available to enterprises
      # who are using Google Play for Work, and whos application is restricted to the
      # enterprise private channel
      class ExternallyHostedApk
        include Google::Apis::Core::Hashable
      
        # The application label.
        # Corresponds to the JSON property `applicationLabel`
        # @return [String]
        attr_accessor :application_label
      
        # A certificate (or array of certificates if a certificate-chain is used) used
        # to signed this APK, represented as a base64 encoded byte array.
        # Corresponds to the JSON property `certificateBase64s`
        # @return [Array<String>]
        attr_accessor :certificate_base64s
      
        # The URL at which the APK is hosted. This must be an https URL.
        # Corresponds to the JSON property `externallyHostedUrl`
        # @return [String]
        attr_accessor :externally_hosted_url
      
        # The SHA1 checksum of this APK, represented as a base64 encoded byte array.
        # Corresponds to the JSON property `fileSha1Base64`
        # @return [String]
        attr_accessor :file_sha1_base64
      
        # The SHA256 checksum of this APK, represented as a base64 encoded byte array.
        # Corresponds to the JSON property `fileSha256Base64`
        # @return [String]
        attr_accessor :file_sha256_base64
      
        # The file size in bytes of this APK.
        # Corresponds to the JSON property `fileSize`
        # @return [Fixnum]
        attr_accessor :file_size
      
        # The icon image from the APK, as a base64 encoded byte array.
        # Corresponds to the JSON property `iconBase64`
        # @return [String]
        attr_accessor :icon_base64
      
        # The maximum SDK supported by this APK (optional).
        # Corresponds to the JSON property `maximumSdk`
        # @return [Fixnum]
        attr_accessor :maximum_sdk
      
        # The minimum SDK targeted by this APK.
        # Corresponds to the JSON property `minimumSdk`
        # @return [Fixnum]
        attr_accessor :minimum_sdk
      
        # The native code environments supported by this APK (optional).
        # Corresponds to the JSON property `nativeCodes`
        # @return [Array<String>]
        attr_accessor :native_codes
      
        # The package name.
        # Corresponds to the JSON property `packageName`
        # @return [String]
        attr_accessor :package_name
      
        # The features required by this APK (optional).
        # Corresponds to the JSON property `usesFeatures`
        # @return [Array<String>]
        attr_accessor :uses_features
      
        # The permissions requested by this APK.
        # Corresponds to the JSON property `usesPermissions`
        # @return [Array<Google::Apis::AndroidpublisherV2::ExternallyHostedApkUsesPermission>]
        attr_accessor :uses_permissions
      
        # The version code of this APK.
        # Corresponds to the JSON property `versionCode`
        # @return [Fixnum]
        attr_accessor :version_code
      
        # The version name of this APK.
        # Corresponds to the JSON property `versionName`
        # @return [String]
        attr_accessor :version_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @application_label = args[:application_label] if args.key?(:application_label)
          @certificate_base64s = args[:certificate_base64s] if args.key?(:certificate_base64s)
          @externally_hosted_url = args[:externally_hosted_url] if args.key?(:externally_hosted_url)
          @file_sha1_base64 = args[:file_sha1_base64] if args.key?(:file_sha1_base64)
          @file_sha256_base64 = args[:file_sha256_base64] if args.key?(:file_sha256_base64)
          @file_size = args[:file_size] if args.key?(:file_size)
          @icon_base64 = args[:icon_base64] if args.key?(:icon_base64)
          @maximum_sdk = args[:maximum_sdk] if args.key?(:maximum_sdk)
          @minimum_sdk = args[:minimum_sdk] if args.key?(:minimum_sdk)
          @native_codes = args[:native_codes] if args.key?(:native_codes)
          @package_name = args[:package_name] if args.key?(:package_name)
          @uses_features = args[:uses_features] if args.key?(:uses_features)
          @uses_permissions = args[:uses_permissions] if args.key?(:uses_permissions)
          @version_code = args[:version_code] if args.key?(:version_code)
          @version_name = args[:version_name] if args.key?(:version_name)
        end
      end
      
      # A permission used by this APK.
      class ExternallyHostedApkUsesPermission
        include Google::Apis::Core::Hashable
      
        # Optionally, the maximum SDK version for which the permission is required.
        # Corresponds to the JSON property `maxSdkVersion`
        # @return [Fixnum]
        attr_accessor :max_sdk_version
      
        # The name of the permission requested.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @max_sdk_version = args[:max_sdk_version] if args.key?(:max_sdk_version)
          @name = args[:name] if args.key?(:name)
        end
      end
      
      # 
      class Image
        include Google::Apis::Core::Hashable
      
        # A unique id representing this image.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # A sha1 hash of the image that was uploaded.
        # Corresponds to the JSON property `sha1`
        # @return [String]
        attr_accessor :sha1
      
        # A URL that will serve a preview of the image.
        # Corresponds to the JSON property `url`
        # @return [String]
        attr_accessor :url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @id = args[:id] if args.key?(:id)
          @sha1 = args[:sha1] if args.key?(:sha1)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # 
      class DeleteAllImagesResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `deleted`
        # @return [Array<Google::Apis::AndroidpublisherV2::Image>]
        attr_accessor :deleted
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @deleted = args[:deleted] if args.key?(:deleted)
        end
      end
      
      # 
      class ListImagesResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `images`
        # @return [Array<Google::Apis::AndroidpublisherV2::Image>]
        attr_accessor :images
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @images = args[:images] if args.key?(:images)
        end
      end
      
      # 
      class UploadImagesResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `image`
        # @return [Google::Apis::AndroidpublisherV2::Image]
        attr_accessor :image
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @image = args[:image] if args.key?(:image)
        end
      end
      
      # 
      class InAppProduct
        include Google::Apis::Core::Hashable
      
        # The default language of the localized data, as defined by BCP 47. e.g. "en-US",
        # "en-GB".
        # Corresponds to the JSON property `defaultLanguage`
        # @return [String]
        attr_accessor :default_language
      
        # Default price cannot be zero. In-app products can never be free. Default price
        # is always in the developer's Checkout merchant currency.
        # Corresponds to the JSON property `defaultPrice`
        # @return [Google::Apis::AndroidpublisherV2::Price]
        attr_accessor :default_price
      
        # List of localized title and description data.
        # Corresponds to the JSON property `listings`
        # @return [Hash<String,Google::Apis::AndroidpublisherV2::InAppProductListing>]
        attr_accessor :listings
      
        # The package name of the parent app.
        # Corresponds to the JSON property `packageName`
        # @return [String]
        attr_accessor :package_name
      
        # Prices per buyer region. None of these prices should be zero. In-app products
        # can never be free.
        # Corresponds to the JSON property `prices`
        # @return [Hash<String,Google::Apis::AndroidpublisherV2::Price>]
        attr_accessor :prices
      
        # Purchase type enum value. Unmodifiable after creation.
        # Corresponds to the JSON property `purchaseType`
        # @return [String]
        attr_accessor :purchase_type
      
        # Definition of a season for a seasonal subscription. Can be defined only for
        # yearly subscriptions.
        # Corresponds to the JSON property `season`
        # @return [Google::Apis::AndroidpublisherV2::Season]
        attr_accessor :season
      
        # The stock-keeping-unit (SKU) of the product, unique within an app.
        # Corresponds to the JSON property `sku`
        # @return [String]
        attr_accessor :sku
      
        # 
        # Corresponds to the JSON property `status`
        # @return [String]
        attr_accessor :status
      
        # Subscription period, specified in ISO 8601 format. Acceptable values are "P1W"
        # (one week), "P1M" (one month), "P3M" (three months), "P6M" (six months), and "
        # P1Y" (one year).
        # Corresponds to the JSON property `subscriptionPeriod`
        # @return [String]
        attr_accessor :subscription_period
      
        # Trial period, specified in ISO 8601 format. Acceptable values are anything
        # between "P7D" (seven days) and "P999D" (999 days). Seasonal subscriptions
        # cannot have a trial period.
        # Corresponds to the JSON property `trialPeriod`
        # @return [String]
        attr_accessor :trial_period
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_language = args[:default_language] if args.key?(:default_language)
          @default_price = args[:default_price] if args.key?(:default_price)
          @listings = args[:listings] if args.key?(:listings)
          @package_name = args[:package_name] if args.key?(:package_name)
          @prices = args[:prices] if args.key?(:prices)
          @purchase_type = args[:purchase_type] if args.key?(:purchase_type)
          @season = args[:season] if args.key?(:season)
          @sku = args[:sku] if args.key?(:sku)
          @status = args[:status] if args.key?(:status)
          @subscription_period = args[:subscription_period] if args.key?(:subscription_period)
          @trial_period = args[:trial_period] if args.key?(:trial_period)
        end
      end
      
      # 
      class InAppProductListing
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # 
        # Corresponds to the JSON property `title`
        # @return [String]
        attr_accessor :title
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @description = args[:description] if args.key?(:description)
          @title = args[:title] if args.key?(:title)
        end
      end
      
      # 
      class InAppProductsBatchRequest
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `entrys`
        # @return [Array<Google::Apis::AndroidpublisherV2::InAppProductsBatchRequestEntry>]
        attr_accessor :entrys
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @entrys = args[:entrys] if args.key?(:entrys)
        end
      end
      
      # 
      class InAppProductsBatchRequestEntry
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `batchId`
        # @return [Fixnum]
        attr_accessor :batch_id
      
        # 
        # Corresponds to the JSON property `inappproductsinsertrequest`
        # @return [Google::Apis::AndroidpublisherV2::InsertInAppProductsRequest]
        attr_accessor :inappproductsinsertrequest
      
        # 
        # Corresponds to the JSON property `inappproductsupdaterequest`
        # @return [Google::Apis::AndroidpublisherV2::UpdateInAppProductsRequest]
        attr_accessor :inappproductsupdaterequest
      
        # 
        # Corresponds to the JSON property `methodName`
        # @return [String]
        attr_accessor :method_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @batch_id = args[:batch_id] if args.key?(:batch_id)
          @inappproductsinsertrequest = args[:inappproductsinsertrequest] if args.key?(:inappproductsinsertrequest)
          @inappproductsupdaterequest = args[:inappproductsupdaterequest] if args.key?(:inappproductsupdaterequest)
          @method_name = args[:method_name] if args.key?(:method_name)
        end
      end
      
      # 
      class InAppProductsBatchResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `entrys`
        # @return [Array<Google::Apis::AndroidpublisherV2::InAppProductsBatchResponseEntry>]
        attr_accessor :entrys
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidpublisher#inappproductsBatchResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @entrys = args[:entrys] if args.key?(:entrys)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # 
      class InAppProductsBatchResponseEntry
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `batchId`
        # @return [Fixnum]
        attr_accessor :batch_id
      
        # 
        # Corresponds to the JSON property `inappproductsinsertresponse`
        # @return [Google::Apis::AndroidpublisherV2::InsertInAppProductsResponse]
        attr_accessor :inappproductsinsertresponse
      
        # 
        # Corresponds to the JSON property `inappproductsupdateresponse`
        # @return [Google::Apis::AndroidpublisherV2::UpdateInAppProductsResponse]
        attr_accessor :inappproductsupdateresponse
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @batch_id = args[:batch_id] if args.key?(:batch_id)
          @inappproductsinsertresponse = args[:inappproductsinsertresponse] if args.key?(:inappproductsinsertresponse)
          @inappproductsupdateresponse = args[:inappproductsupdateresponse] if args.key?(:inappproductsupdateresponse)
        end
      end
      
      # 
      class InsertInAppProductsRequest
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `inappproduct`
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        attr_accessor :inappproduct
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @inappproduct = args[:inappproduct] if args.key?(:inappproduct)
        end
      end
      
      # 
      class InsertInAppProductsResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `inappproduct`
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        attr_accessor :inappproduct
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @inappproduct = args[:inappproduct] if args.key?(:inappproduct)
        end
      end
      
      # 
      class ListInAppProductsResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `inappproduct`
        # @return [Array<Google::Apis::AndroidpublisherV2::InAppProduct>]
        attr_accessor :inappproduct
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidpublisher#inappproductsListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # 
        # Corresponds to the JSON property `pageInfo`
        # @return [Google::Apis::AndroidpublisherV2::PageInfo]
        attr_accessor :page_info
      
        # 
        # Corresponds to the JSON property `tokenPagination`
        # @return [Google::Apis::AndroidpublisherV2::TokenPagination]
        attr_accessor :token_pagination
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @inappproduct = args[:inappproduct] if args.key?(:inappproduct)
          @kind = args[:kind] if args.key?(:kind)
          @page_info = args[:page_info] if args.key?(:page_info)
          @token_pagination = args[:token_pagination] if args.key?(:token_pagination)
        end
      end
      
      # 
      class UpdateInAppProductsRequest
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `inappproduct`
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        attr_accessor :inappproduct
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @inappproduct = args[:inappproduct] if args.key?(:inappproduct)
        end
      end
      
      # 
      class UpdateInAppProductsResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `inappproduct`
        # @return [Google::Apis::AndroidpublisherV2::InAppProduct]
        attr_accessor :inappproduct
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @inappproduct = args[:inappproduct] if args.key?(:inappproduct)
        end
      end
      
      # 
      class Listing
        include Google::Apis::Core::Hashable
      
        # Full description of the app; this may be up to 4000 characters in length.
        # Corresponds to the JSON property `fullDescription`
        # @return [String]
        attr_accessor :full_description
      
        # Language localization code (for example, "de-AT" for Austrian German).
        # Corresponds to the JSON property `language`
        # @return [String]
        attr_accessor :language
      
        # Short description of the app (previously known as promo text); this may be up
        # to 80 characters in length.
        # Corresponds to the JSON property `shortDescription`
        # @return [String]
        attr_accessor :short_description
      
        # App's localized title.
        # Corresponds to the JSON property `title`
        # @return [String]
        attr_accessor :title
      
        # URL of a promotional YouTube video for the app.
        # Corresponds to the JSON property `video`
        # @return [String]
        attr_accessor :video
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @full_description = args[:full_description] if args.key?(:full_description)
          @language = args[:language] if args.key?(:language)
          @short_description = args[:short_description] if args.key?(:short_description)
          @title = args[:title] if args.key?(:title)
          @video = args[:video] if args.key?(:video)
        end
      end
      
      # 
      class ListListingsResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidpublisher#listingsListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # 
        # Corresponds to the JSON property `listings`
        # @return [Array<Google::Apis::AndroidpublisherV2::Listing>]
        attr_accessor :listings
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @listings = args[:listings] if args.key?(:listings)
        end
      end
      
      # 
      class MonthDay
        include Google::Apis::Core::Hashable
      
        # Day of a month, value in [1, 31] range. Valid range depends on the specified
        # month.
        # Corresponds to the JSON property `day`
        # @return [Fixnum]
        attr_accessor :day
      
        # Month of a year. e.g. 1 = JAN, 2 = FEB etc.
        # Corresponds to the JSON property `month`
        # @return [Fixnum]
        attr_accessor :month
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @day = args[:day] if args.key?(:day)
          @month = args[:month] if args.key?(:month)
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
      
      # 
      class Price
        include Google::Apis::Core::Hashable
      
        # 3 letter Currency code, as defined by ISO 4217.
        # Corresponds to the JSON property `currency`
        # @return [String]
        attr_accessor :currency
      
        # The price in millionths of the currency base unit represented as a string.
        # Corresponds to the JSON property `priceMicros`
        # @return [String]
        attr_accessor :price_micros
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @currency = args[:currency] if args.key?(:currency)
          @price_micros = args[:price_micros] if args.key?(:price_micros)
        end
      end
      
      # A ProductPurchase resource indicates the status of a user's inapp product
      # purchase.
      class ProductPurchase
        include Google::Apis::Core::Hashable
      
        # The consumption state of the inapp product. Possible values are:
        # - Yet to be consumed
        # - Consumed
        # Corresponds to the JSON property `consumptionState`
        # @return [Fixnum]
        attr_accessor :consumption_state
      
        # A developer-specified string that contains supplemental information about an
        # order.
        # Corresponds to the JSON property `developerPayload`
        # @return [String]
        attr_accessor :developer_payload
      
        # This kind represents an inappPurchase object in the androidpublisher service.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The order id associated with the purchase of the inapp product.
        # Corresponds to the JSON property `orderId`
        # @return [String]
        attr_accessor :order_id
      
        # The purchase state of the order. Possible values are:
        # - Purchased
        # - Cancelled
        # Corresponds to the JSON property `purchaseState`
        # @return [Fixnum]
        attr_accessor :purchase_state
      
        # The time the product was purchased, in milliseconds since the epoch (Jan 1,
        # 1970).
        # Corresponds to the JSON property `purchaseTimeMillis`
        # @return [Fixnum]
        attr_accessor :purchase_time_millis
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @consumption_state = args[:consumption_state] if args.key?(:consumption_state)
          @developer_payload = args[:developer_payload] if args.key?(:developer_payload)
          @kind = args[:kind] if args.key?(:kind)
          @order_id = args[:order_id] if args.key?(:order_id)
          @purchase_state = args[:purchase_state] if args.key?(:purchase_state)
          @purchase_time_millis = args[:purchase_time_millis] if args.key?(:purchase_time_millis)
        end
      end
      
      # 
      class Prorate
        include Google::Apis::Core::Hashable
      
        # Default price cannot be zero and must be less than the full subscription price.
        # Default price is always in the developer's Checkout merchant currency.
        # Targeted countries have their prices set automatically based on the
        # default_price.
        # Corresponds to the JSON property `defaultPrice`
        # @return [Google::Apis::AndroidpublisherV2::Price]
        attr_accessor :default_price
      
        # Defines the first day on which the price takes effect.
        # Corresponds to the JSON property `start`
        # @return [Google::Apis::AndroidpublisherV2::MonthDay]
        attr_accessor :start
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_price = args[:default_price] if args.key?(:default_price)
          @start = args[:start] if args.key?(:start)
        end
      end
      
      # 
      class Review
        include Google::Apis::Core::Hashable
      
        # The name of the user who wrote the review.
        # Corresponds to the JSON property `authorName`
        # @return [String]
        attr_accessor :author_name
      
        # A repeated field containing comments for the review.
        # Corresponds to the JSON property `comments`
        # @return [Array<Google::Apis::AndroidpublisherV2::Comment>]
        attr_accessor :comments
      
        # Unique identifier for this review.
        # Corresponds to the JSON property `reviewId`
        # @return [String]
        attr_accessor :review_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @author_name = args[:author_name] if args.key?(:author_name)
          @comments = args[:comments] if args.key?(:comments)
          @review_id = args[:review_id] if args.key?(:review_id)
        end
      end
      
      # 
      class ReviewReplyResult
        include Google::Apis::Core::Hashable
      
        # The time at which the reply took effect.
        # Corresponds to the JSON property `lastEdited`
        # @return [Google::Apis::AndroidpublisherV2::Timestamp]
        attr_accessor :last_edited
      
        # The reply text that was applied.
        # Corresponds to the JSON property `replyText`
        # @return [String]
        attr_accessor :reply_text
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @last_edited = args[:last_edited] if args.key?(:last_edited)
          @reply_text = args[:reply_text] if args.key?(:reply_text)
        end
      end
      
      # 
      class ReviewsListResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `pageInfo`
        # @return [Google::Apis::AndroidpublisherV2::PageInfo]
        attr_accessor :page_info
      
        # 
        # Corresponds to the JSON property `reviews`
        # @return [Array<Google::Apis::AndroidpublisherV2::Review>]
        attr_accessor :reviews
      
        # 
        # Corresponds to the JSON property `tokenPagination`
        # @return [Google::Apis::AndroidpublisherV2::TokenPagination]
        attr_accessor :token_pagination
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @page_info = args[:page_info] if args.key?(:page_info)
          @reviews = args[:reviews] if args.key?(:reviews)
          @token_pagination = args[:token_pagination] if args.key?(:token_pagination)
        end
      end
      
      # 
      class ReviewsReplyRequest
        include Google::Apis::Core::Hashable
      
        # The text to set as the reply. Replies of more than approximately 350
        # characters will be rejected. HTML tags will be stripped.
        # Corresponds to the JSON property `replyText`
        # @return [String]
        attr_accessor :reply_text
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @reply_text = args[:reply_text] if args.key?(:reply_text)
        end
      end
      
      # 
      class ReviewsReplyResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `result`
        # @return [Google::Apis::AndroidpublisherV2::ReviewReplyResult]
        attr_accessor :result
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @result = args[:result] if args.key?(:result)
        end
      end
      
      # 
      class Season
        include Google::Apis::Core::Hashable
      
        # Inclusive end date of the recurrence period.
        # Corresponds to the JSON property `end`
        # @return [Google::Apis::AndroidpublisherV2::MonthDay]
        attr_accessor :end
      
        # Optionally present list of prorations for the season. Each proration is a one-
        # off discounted entry into a subscription. Each proration contains the first
        # date on which the discount is available and the new pricing information.
        # Corresponds to the JSON property `prorations`
        # @return [Array<Google::Apis::AndroidpublisherV2::Prorate>]
        attr_accessor :prorations
      
        # Inclusive start date of the recurrence period.
        # Corresponds to the JSON property `start`
        # @return [Google::Apis::AndroidpublisherV2::MonthDay]
        attr_accessor :start
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @end = args[:end] if args.key?(:end)
          @prorations = args[:prorations] if args.key?(:prorations)
          @start = args[:start] if args.key?(:start)
        end
      end
      
      # A SubscriptionDeferralInfo contains the data needed to defer a subscription
      # purchase to a future expiry time.
      class SubscriptionDeferralInfo
        include Google::Apis::Core::Hashable
      
        # The desired next expiry time to assign to the subscription, in milliseconds
        # since the Epoch. The given time must be later/greater than the current expiry
        # time for the subscription.
        # Corresponds to the JSON property `desiredExpiryTimeMillis`
        # @return [Fixnum]
        attr_accessor :desired_expiry_time_millis
      
        # The expected expiry time for the subscription. If the current expiry time for
        # the subscription is not the value specified here, the deferral will not occur.
        # Corresponds to the JSON property `expectedExpiryTimeMillis`
        # @return [Fixnum]
        attr_accessor :expected_expiry_time_millis
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @desired_expiry_time_millis = args[:desired_expiry_time_millis] if args.key?(:desired_expiry_time_millis)
          @expected_expiry_time_millis = args[:expected_expiry_time_millis] if args.key?(:expected_expiry_time_millis)
        end
      end
      
      # A SubscriptionPurchase resource indicates the status of a user's subscription
      # purchase.
      class SubscriptionPurchase
        include Google::Apis::Core::Hashable
      
        # Whether the subscription will automatically be renewed when it reaches its
        # current expiry time.
        # Corresponds to the JSON property `autoRenewing`
        # @return [Boolean]
        attr_accessor :auto_renewing
        alias_method :auto_renewing?, :auto_renewing
      
        # The reason why a subscription was cancelled or is not auto-renewing. Possible
        # values are:
        # - User cancelled the subscription
        # - Subscription was cancelled by the system, for example because of a billing
        # problem
        # Corresponds to the JSON property `cancelReason`
        # @return [Fixnum]
        attr_accessor :cancel_reason
      
        # ISO 3166-1 alpha-2 billing country/region code of the user at the time the
        # subscription was granted.
        # Corresponds to the JSON property `countryCode`
        # @return [String]
        attr_accessor :country_code
      
        # A developer-specified string that contains supplemental information about an
        # order.
        # Corresponds to the JSON property `developerPayload`
        # @return [String]
        attr_accessor :developer_payload
      
        # Time at which the subscription will expire, in milliseconds since the Epoch.
        # Corresponds to the JSON property `expiryTimeMillis`
        # @return [Fixnum]
        attr_accessor :expiry_time_millis
      
        # This kind represents a subscriptionPurchase object in the androidpublisher
        # service.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The order id of the latest recurring order associated with the purchase of the
        # subscription.
        # Corresponds to the JSON property `orderId`
        # @return [String]
        attr_accessor :order_id
      
        # The payment state of the subscription. Possible values are:
        # - Payment pending
        # - Payment received
        # - Free trial
        # Corresponds to the JSON property `paymentState`
        # @return [Fixnum]
        attr_accessor :payment_state
      
        # Price of the subscription, not including tax. Price is expressed in micro-
        # units, where 1,000,000 micro-units represents one unit of the currency. For
        # example, if the subscription price is €1.99, price_amount_micros is 1990000.
        # Corresponds to the JSON property `priceAmountMicros`
        # @return [Fixnum]
        attr_accessor :price_amount_micros
      
        # ISO 4217 currency code for the subscription price. For example, if the price
        # is specified in British pounds sterling, price_currency_code is "GBP".
        # Corresponds to the JSON property `priceCurrencyCode`
        # @return [String]
        attr_accessor :price_currency_code
      
        # Time at which the subscription was granted, in milliseconds since the Epoch.
        # Corresponds to the JSON property `startTimeMillis`
        # @return [Fixnum]
        attr_accessor :start_time_millis
      
        # The time at which the subscription was canceled by the user, in milliseconds
        # since the epoch. Only present if cancelReason is 0.
        # Corresponds to the JSON property `userCancellationTimeMillis`
        # @return [Fixnum]
        attr_accessor :user_cancellation_time_millis
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @auto_renewing = args[:auto_renewing] if args.key?(:auto_renewing)
          @cancel_reason = args[:cancel_reason] if args.key?(:cancel_reason)
          @country_code = args[:country_code] if args.key?(:country_code)
          @developer_payload = args[:developer_payload] if args.key?(:developer_payload)
          @expiry_time_millis = args[:expiry_time_millis] if args.key?(:expiry_time_millis)
          @kind = args[:kind] if args.key?(:kind)
          @order_id = args[:order_id] if args.key?(:order_id)
          @payment_state = args[:payment_state] if args.key?(:payment_state)
          @price_amount_micros = args[:price_amount_micros] if args.key?(:price_amount_micros)
          @price_currency_code = args[:price_currency_code] if args.key?(:price_currency_code)
          @start_time_millis = args[:start_time_millis] if args.key?(:start_time_millis)
          @user_cancellation_time_millis = args[:user_cancellation_time_millis] if args.key?(:user_cancellation_time_millis)
        end
      end
      
      # 
      class DeferSubscriptionPurchasesRequest
        include Google::Apis::Core::Hashable
      
        # A SubscriptionDeferralInfo contains the data needed to defer a subscription
        # purchase to a future expiry time.
        # Corresponds to the JSON property `deferralInfo`
        # @return [Google::Apis::AndroidpublisherV2::SubscriptionDeferralInfo]
        attr_accessor :deferral_info
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @deferral_info = args[:deferral_info] if args.key?(:deferral_info)
        end
      end
      
      # 
      class DeferSubscriptionPurchasesResponse
        include Google::Apis::Core::Hashable
      
        # The new expiry time for the subscription in milliseconds since the Epoch.
        # Corresponds to the JSON property `newExpiryTimeMillis`
        # @return [Fixnum]
        attr_accessor :new_expiry_time_millis
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @new_expiry_time_millis = args[:new_expiry_time_millis] if args.key?(:new_expiry_time_millis)
        end
      end
      
      # 
      class Testers
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `googleGroups`
        # @return [Array<String>]
        attr_accessor :google_groups
      
        # 
        # Corresponds to the JSON property `googlePlusCommunities`
        # @return [Array<String>]
        attr_accessor :google_plus_communities
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @google_groups = args[:google_groups] if args.key?(:google_groups)
          @google_plus_communities = args[:google_plus_communities] if args.key?(:google_plus_communities)
        end
      end
      
      # 
      class Timestamp
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `nanos`
        # @return [Fixnum]
        attr_accessor :nanos
      
        # 
        # Corresponds to the JSON property `seconds`
        # @return [Fixnum]
        attr_accessor :seconds
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @nanos = args[:nanos] if args.key?(:nanos)
          @seconds = args[:seconds] if args.key?(:seconds)
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
      
      # 
      class Track
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `track`
        # @return [String]
        attr_accessor :track
      
        # 
        # Corresponds to the JSON property `userFraction`
        # @return [Float]
        attr_accessor :user_fraction
      
        # 
        # Corresponds to the JSON property `versionCodes`
        # @return [Array<Fixnum>]
        attr_accessor :version_codes
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @track = args[:track] if args.key?(:track)
          @user_fraction = args[:user_fraction] if args.key?(:user_fraction)
          @version_codes = args[:version_codes] if args.key?(:version_codes)
        end
      end
      
      # 
      class ListTracksResponse
        include Google::Apis::Core::Hashable
      
        # Identifies what kind of resource this is. Value: the fixed string "
        # androidpublisher#tracksListResponse".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # 
        # Corresponds to the JSON property `tracks`
        # @return [Array<Google::Apis::AndroidpublisherV2::Track>]
        attr_accessor :tracks
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @tracks = args[:tracks] if args.key?(:tracks)
        end
      end
      
      # 
      class UserComment
        include Google::Apis::Core::Hashable
      
        # Integer Android SDK version of the user's device at the time the review was
        # written, e.g. 23 is Marshmallow. May be absent.
        # Corresponds to the JSON property `androidOsVersion`
        # @return [Fixnum]
        attr_accessor :android_os_version
      
        # Integer version code of the app as installed at the time the review was
        # written. May be absent.
        # Corresponds to the JSON property `appVersionCode`
        # @return [Fixnum]
        attr_accessor :app_version_code
      
        # String version name of the app as installed at the time the review was written.
        # May be absent.
        # Corresponds to the JSON property `appVersionName`
        # @return [String]
        attr_accessor :app_version_name
      
        # Codename for the reviewer's device, e.g. klte, flounder. May be absent.
        # Corresponds to the JSON property `device`
        # @return [String]
        attr_accessor :device
      
        # Some information about the characteristics of the user's device
        # Corresponds to the JSON property `deviceMetadata`
        # @return [Google::Apis::AndroidpublisherV2::DeviceMetadata]
        attr_accessor :device_metadata
      
        # The last time at which this comment was updated.
        # Corresponds to the JSON property `lastModified`
        # @return [Google::Apis::AndroidpublisherV2::Timestamp]
        attr_accessor :last_modified
      
        # Untranslated text of the review, in the case where the review has been
        # translated. If the review has not been translated this is left blank.
        # Corresponds to the JSON property `originalText`
        # @return [String]
        attr_accessor :original_text
      
        # Language code for the reviewer. This is taken from the device settings so is
        # not guaranteed to match the language the review is written in. May be absent.
        # Corresponds to the JSON property `reviewerLanguage`
        # @return [String]
        attr_accessor :reviewer_language
      
        # The star rating associated with the review, from 1 to 5.
        # Corresponds to the JSON property `starRating`
        # @return [Fixnum]
        attr_accessor :star_rating
      
        # The content of the comment, i.e. review body. In some cases users have been
        # able to write a review with separate title and body; in those cases the title
        # and body are concatenated and separated by a tab character.
        # Corresponds to the JSON property `text`
        # @return [String]
        attr_accessor :text
      
        # Number of users who have given this review a thumbs down
        # Corresponds to the JSON property `thumbsDownCount`
        # @return [Fixnum]
        attr_accessor :thumbs_down_count
      
        # Number of users who have given this review a thumbs up
        # Corresponds to the JSON property `thumbsUpCount`
        # @return [Fixnum]
        attr_accessor :thumbs_up_count
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @android_os_version = args[:android_os_version] if args.key?(:android_os_version)
          @app_version_code = args[:app_version_code] if args.key?(:app_version_code)
          @app_version_name = args[:app_version_name] if args.key?(:app_version_name)
          @device = args[:device] if args.key?(:device)
          @device_metadata = args[:device_metadata] if args.key?(:device_metadata)
          @last_modified = args[:last_modified] if args.key?(:last_modified)
          @original_text = args[:original_text] if args.key?(:original_text)
          @reviewer_language = args[:reviewer_language] if args.key?(:reviewer_language)
          @star_rating = args[:star_rating] if args.key?(:star_rating)
          @text = args[:text] if args.key?(:text)
          @thumbs_down_count = args[:thumbs_down_count] if args.key?(:thumbs_down_count)
          @thumbs_up_count = args[:thumbs_up_count] if args.key?(:thumbs_up_count)
        end
      end
      
      # A VoidedPurchase resource indicates a purchase that was either cancelled/
      # refunded/charged-back.
      class VoidedPurchase
        include Google::Apis::Core::Hashable
      
        # This kind represents a voided purchase object in the androidpublisher service.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The time at which the purchase was made, in milliseconds since the epoch (Jan
        # 1, 1970).
        # Corresponds to the JSON property `purchaseTimeMillis`
        # @return [Fixnum]
        attr_accessor :purchase_time_millis
      
        # The token that was generated when a purchase was made. This uniquely
        # identifies a purchase.
        # Corresponds to the JSON property `purchaseToken`
        # @return [String]
        attr_accessor :purchase_token
      
        # The time at which the purchase was cancelled/refunded/charged-back, in
        # milliseconds since the epoch (Jan 1, 1970).
        # Corresponds to the JSON property `voidedTimeMillis`
        # @return [Fixnum]
        attr_accessor :voided_time_millis
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @purchase_time_millis = args[:purchase_time_millis] if args.key?(:purchase_time_millis)
          @purchase_token = args[:purchase_token] if args.key?(:purchase_token)
          @voided_time_millis = args[:voided_time_millis] if args.key?(:voided_time_millis)
        end
      end
      
      # 
      class VoidedPurchasesListResponse
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `pageInfo`
        # @return [Google::Apis::AndroidpublisherV2::PageInfo]
        attr_accessor :page_info
      
        # 
        # Corresponds to the JSON property `tokenPagination`
        # @return [Google::Apis::AndroidpublisherV2::TokenPagination]
        attr_accessor :token_pagination
      
        # 
        # Corresponds to the JSON property `voidedPurchases`
        # @return [Array<Google::Apis::AndroidpublisherV2::VoidedPurchase>]
        attr_accessor :voided_purchases
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @page_info = args[:page_info] if args.key?(:page_info)
          @token_pagination = args[:token_pagination] if args.key?(:token_pagination)
          @voided_purchases = args[:voided_purchases] if args.key?(:voided_purchases)
        end
      end
    end
  end
end
