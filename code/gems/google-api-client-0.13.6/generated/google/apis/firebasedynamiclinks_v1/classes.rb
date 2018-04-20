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
    module FirebasedynamiclinksV1
      
      # Tracking parameters supported by Dynamic Link.
      class AnalyticsInfo
        include Google::Apis::Core::Hashable
      
        # Parameters for Google Play Campaign Measurements.
        # [Learn more](https://developers.google.com/analytics/devguides/collection/
        # android/v4/campaigns#campaign-params)
        # Corresponds to the JSON property `googlePlayAnalytics`
        # @return [Google::Apis::FirebasedynamiclinksV1::GooglePlayAnalytics]
        attr_accessor :google_play_analytics
      
        # Parameters for iTunes Connect App Analytics.
        # Corresponds to the JSON property `itunesConnectAnalytics`
        # @return [Google::Apis::FirebasedynamiclinksV1::ITunesConnectAnalytics]
        attr_accessor :itunes_connect_analytics
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @google_play_analytics = args[:google_play_analytics] if args.key?(:google_play_analytics)
          @itunes_connect_analytics = args[:itunes_connect_analytics] if args.key?(:itunes_connect_analytics)
        end
      end
      
      # Android related attributes to the Dynamic Link.
      class AndroidInfo
        include Google::Apis::Core::Hashable
      
        # Link to open on Android if the app is not installed.
        # Corresponds to the JSON property `androidFallbackLink`
        # @return [String]
        attr_accessor :android_fallback_link
      
        # If specified, this overrides the ‘link’ parameter on Android.
        # Corresponds to the JSON property `androidLink`
        # @return [String]
        attr_accessor :android_link
      
        # Minimum version code for the Android app. If the installed app’s version
        # code is lower, then the user is taken to the Play Store.
        # Corresponds to the JSON property `androidMinPackageVersionCode`
        # @return [String]
        attr_accessor :android_min_package_version_code
      
        # Android package name of the app.
        # Corresponds to the JSON property `androidPackageName`
        # @return [String]
        attr_accessor :android_package_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @android_fallback_link = args[:android_fallback_link] if args.key?(:android_fallback_link)
          @android_link = args[:android_link] if args.key?(:android_link)
          @android_min_package_version_code = args[:android_min_package_version_code] if args.key?(:android_min_package_version_code)
          @android_package_name = args[:android_package_name] if args.key?(:android_package_name)
        end
      end
      
      # Request to create a short Dynamic Link.
      class CreateShortDynamicLinkRequest
        include Google::Apis::Core::Hashable
      
        # Information about a Dynamic Link.
        # Corresponds to the JSON property `dynamicLinkInfo`
        # @return [Google::Apis::FirebasedynamiclinksV1::DynamicLinkInfo]
        attr_accessor :dynamic_link_info
      
        # Full long Dynamic Link URL with desired query parameters specified.
        # For example,
        # "https://sample.app.goo.gl/?link=http://www.google.com&apn=com.sample",
        # [Learn more](https://firebase.google.com/docs/dynamic-links/android#create-a-
        # dynamic-link-programmatically).
        # Corresponds to the JSON property `longDynamicLink`
        # @return [String]
        attr_accessor :long_dynamic_link
      
        # Short Dynamic Link suffix.
        # Corresponds to the JSON property `suffix`
        # @return [Google::Apis::FirebasedynamiclinksV1::Suffix]
        attr_accessor :suffix
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @dynamic_link_info = args[:dynamic_link_info] if args.key?(:dynamic_link_info)
          @long_dynamic_link = args[:long_dynamic_link] if args.key?(:long_dynamic_link)
          @suffix = args[:suffix] if args.key?(:suffix)
        end
      end
      
      # Response to create a short Dynamic Link.
      class CreateShortDynamicLinkResponse
        include Google::Apis::Core::Hashable
      
        # Preivew link to show the link flow chart.
        # Corresponds to the JSON property `previewLink`
        # @return [String]
        attr_accessor :preview_link
      
        # Short Dynamic Link value. e.g. https://abcd.app.goo.gl/wxyz
        # Corresponds to the JSON property `shortLink`
        # @return [String]
        attr_accessor :short_link
      
        # Information about potential warnings on link creation.
        # Corresponds to the JSON property `warning`
        # @return [Array<Google::Apis::FirebasedynamiclinksV1::DynamicLinkWarning>]
        attr_accessor :warning
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @preview_link = args[:preview_link] if args.key?(:preview_link)
          @short_link = args[:short_link] if args.key?(:short_link)
          @warning = args[:warning] if args.key?(:warning)
        end
      end
      
      # Signals associated with the device making the request.
      class DeviceInfo
        include Google::Apis::Core::Hashable
      
        # Device model name.
        # Corresponds to the JSON property `deviceModelName`
        # @return [String]
        attr_accessor :device_model_name
      
        # Device language code setting.
        # Corresponds to the JSON property `languageCode`
        # @return [String]
        attr_accessor :language_code
      
        # Device display resolution height.
        # Corresponds to the JSON property `screenResolutionHeight`
        # @return [Fixnum]
        attr_accessor :screen_resolution_height
      
        # Device display resolution width.
        # Corresponds to the JSON property `screenResolutionWidth`
        # @return [Fixnum]
        attr_accessor :screen_resolution_width
      
        # Device timezone setting.
        # Corresponds to the JSON property `timezone`
        # @return [String]
        attr_accessor :timezone
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @device_model_name = args[:device_model_name] if args.key?(:device_model_name)
          @language_code = args[:language_code] if args.key?(:language_code)
          @screen_resolution_height = args[:screen_resolution_height] if args.key?(:screen_resolution_height)
          @screen_resolution_width = args[:screen_resolution_width] if args.key?(:screen_resolution_width)
          @timezone = args[:timezone] if args.key?(:timezone)
        end
      end
      
      # Dynamic Link event stat.
      class DynamicLinkEventStat
        include Google::Apis::Core::Hashable
      
        # The number of times this event occurred.
        # Corresponds to the JSON property `count`
        # @return [Fixnum]
        attr_accessor :count
      
        # Link event.
        # Corresponds to the JSON property `event`
        # @return [String]
        attr_accessor :event
      
        # Requested platform.
        # Corresponds to the JSON property `platform`
        # @return [String]
        attr_accessor :platform
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @count = args[:count] if args.key?(:count)
          @event = args[:event] if args.key?(:event)
          @platform = args[:platform] if args.key?(:platform)
        end
      end
      
      # Information about a Dynamic Link.
      class DynamicLinkInfo
        include Google::Apis::Core::Hashable
      
        # Tracking parameters supported by Dynamic Link.
        # Corresponds to the JSON property `analyticsInfo`
        # @return [Google::Apis::FirebasedynamiclinksV1::AnalyticsInfo]
        attr_accessor :analytics_info
      
        # Android related attributes to the Dynamic Link.
        # Corresponds to the JSON property `androidInfo`
        # @return [Google::Apis::FirebasedynamiclinksV1::AndroidInfo]
        attr_accessor :android_info
      
        # Dynamic Links domain that the project owns, e.g. abcd.app.goo.gl
        # [Learn more](https://firebase.google.com/docs/dynamic-links/android/receive)
        # on how to set up Dynamic Link domain associated with your Firebase project.
        # Required.
        # Corresponds to the JSON property `dynamicLinkDomain`
        # @return [String]
        attr_accessor :dynamic_link_domain
      
        # iOS related attributes to the Dynamic Link..
        # Corresponds to the JSON property `iosInfo`
        # @return [Google::Apis::FirebasedynamiclinksV1::IosInfo]
        attr_accessor :ios_info
      
        # The link your app will open, You can specify any URL your app can handle.
        # This link must be a well-formatted URL, be properly URL-encoded, and use
        # the HTTP or HTTPS scheme. See 'link' parameters in the
        # [documentation](https://firebase.google.com/docs/dynamic-links/create-manually)
        # .
        # Required.
        # Corresponds to the JSON property `link`
        # @return [String]
        attr_accessor :link
      
        # Information of navigation behavior.
        # Corresponds to the JSON property `navigationInfo`
        # @return [Google::Apis::FirebasedynamiclinksV1::NavigationInfo]
        attr_accessor :navigation_info
      
        # Parameters for social meta tag params.
        # Used to set meta tag data for link previews on social sites.
        # Corresponds to the JSON property `socialMetaTagInfo`
        # @return [Google::Apis::FirebasedynamiclinksV1::SocialMetaTagInfo]
        attr_accessor :social_meta_tag_info
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @analytics_info = args[:analytics_info] if args.key?(:analytics_info)
          @android_info = args[:android_info] if args.key?(:android_info)
          @dynamic_link_domain = args[:dynamic_link_domain] if args.key?(:dynamic_link_domain)
          @ios_info = args[:ios_info] if args.key?(:ios_info)
          @link = args[:link] if args.key?(:link)
          @navigation_info = args[:navigation_info] if args.key?(:navigation_info)
          @social_meta_tag_info = args[:social_meta_tag_info] if args.key?(:social_meta_tag_info)
        end
      end
      
      # Analytics stats of a Dynamic Link for a given timeframe.
      class DynamicLinkStats
        include Google::Apis::Core::Hashable
      
        # Dynamic Link event stats.
        # Corresponds to the JSON property `linkEventStats`
        # @return [Array<Google::Apis::FirebasedynamiclinksV1::DynamicLinkEventStat>]
        attr_accessor :link_event_stats
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @link_event_stats = args[:link_event_stats] if args.key?(:link_event_stats)
        end
      end
      
      # Dynamic Links warning messages.
      class DynamicLinkWarning
        include Google::Apis::Core::Hashable
      
        # The warning code.
        # Corresponds to the JSON property `warningCode`
        # @return [String]
        attr_accessor :warning_code
      
        # The document describing the warning, and helps resolve.
        # Corresponds to the JSON property `warningDocumentLink`
        # @return [String]
        attr_accessor :warning_document_link
      
        # The warning message to help developers improve their requests.
        # Corresponds to the JSON property `warningMessage`
        # @return [String]
        attr_accessor :warning_message
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @warning_code = args[:warning_code] if args.key?(:warning_code)
          @warning_document_link = args[:warning_document_link] if args.key?(:warning_document_link)
          @warning_message = args[:warning_message] if args.key?(:warning_message)
        end
      end
      
      # Request for iSDK to execute strong match flow for post-install attribution.
      # This is meant for iOS requests only. Requests from other platforms will
      # not be honored.
      class GetIosPostInstallAttributionRequest
        include Google::Apis::Core::Hashable
      
        # App installation epoch time (https://en.wikipedia.org/wiki/Unix_time).
        # This is a client signal for a more accurate weak match.
        # Corresponds to the JSON property `appInstallationTime`
        # @return [Fixnum]
        attr_accessor :app_installation_time
      
        # APP bundle ID.
        # Corresponds to the JSON property `bundleId`
        # @return [String]
        attr_accessor :bundle_id
      
        # Signals associated with the device making the request.
        # Corresponds to the JSON property `device`
        # @return [Google::Apis::FirebasedynamiclinksV1::DeviceInfo]
        attr_accessor :device
      
        # iOS version, ie: 9.3.5.
        # Consider adding "build".
        # Corresponds to the JSON property `iosVersion`
        # @return [String]
        attr_accessor :ios_version
      
        # App post install attribution retrieval information. Disambiguates
        # mechanism (iSDK or developer invoked) to retrieve payload from
        # clicked link.
        # Corresponds to the JSON property `retrievalMethod`
        # @return [String]
        attr_accessor :retrieval_method
      
        # Google SDK version.
        # Corresponds to the JSON property `sdkVersion`
        # @return [String]
        attr_accessor :sdk_version
      
        # Possible unique matched link that server need to check before performing
        # fingerprint match. If passed link is short server need to expand the link.
        # If link is long server need to vslidate the link.
        # Corresponds to the JSON property `uniqueMatchLinkToCheck`
        # @return [String]
        attr_accessor :unique_match_link_to_check
      
        # Strong match page information. Disambiguates between default UI and
        # custom page to present when strong match succeeds/fails to find cookie.
        # Corresponds to the JSON property `visualStyle`
        # @return [String]
        attr_accessor :visual_style
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @app_installation_time = args[:app_installation_time] if args.key?(:app_installation_time)
          @bundle_id = args[:bundle_id] if args.key?(:bundle_id)
          @device = args[:device] if args.key?(:device)
          @ios_version = args[:ios_version] if args.key?(:ios_version)
          @retrieval_method = args[:retrieval_method] if args.key?(:retrieval_method)
          @sdk_version = args[:sdk_version] if args.key?(:sdk_version)
          @unique_match_link_to_check = args[:unique_match_link_to_check] if args.key?(:unique_match_link_to_check)
          @visual_style = args[:visual_style] if args.key?(:visual_style)
        end
      end
      
      # Response for iSDK to execute strong match flow for post-install attribution.
      class GetIosPostInstallAttributionResponse
        include Google::Apis::Core::Hashable
      
        # The minimum version for app, specified by dev through ?imv= parameter.
        # Return to iSDK to allow app to evaluate if current version meets this.
        # Corresponds to the JSON property `appMinimumVersion`
        # @return [String]
        attr_accessor :app_minimum_version
      
        # The confidence of the returned attribution.
        # Corresponds to the JSON property `attributionConfidence`
        # @return [String]
        attr_accessor :attribution_confidence
      
        # The deep-link attributed post-install via one of several techniques
        # (fingerprint, copy unique).
        # Corresponds to the JSON property `deepLink`
        # @return [String]
        attr_accessor :deep_link
      
        # User-agent specific custom-scheme URIs for iSDK to open. This will be set
        # according to the user-agent tha the click was originally made in. There is
        # no Safari-equivalent custom-scheme open URLs.
        # ie: googlechrome://www.example.com
        # ie: firefox://open-url?url=http://www.example.com
        # ie: opera-http://example.com
        # Corresponds to the JSON property `externalBrowserDestinationLink`
        # @return [String]
        attr_accessor :external_browser_destination_link
      
        # The link to navigate to update the app if min version is not met.
        # This is either (in order): 1) fallback link (from ?ifl= parameter, if
        # specified by developer) or 2) AppStore URL (from ?isi= parameter, if
        # specified), or 3) the payload link (from required link= parameter).
        # Corresponds to the JSON property `fallbackLink`
        # @return [String]
        attr_accessor :fallback_link
      
        # Invitation ID attributed post-install via one of several techniques
        # (fingerprint, copy unique).
        # Corresponds to the JSON property `invitationId`
        # @return [String]
        attr_accessor :invitation_id
      
        # Instruction for iSDK to attemmpt to perform strong match. For instance,
        # if browser does not support/allow cookie or outside of support browsers,
        # this will be false.
        # Corresponds to the JSON property `isStrongMatchExecutable`
        # @return [Boolean]
        attr_accessor :is_strong_match_executable
        alias_method :is_strong_match_executable?, :is_strong_match_executable
      
        # Describes why match failed, ie: "discarded due to low confidence".
        # This message will be publicly visible.
        # Corresponds to the JSON property `matchMessage`
        # @return [String]
        attr_accessor :match_message
      
        # Entire FDL (short or long) attributed post-install via one of several
        # techniques (fingerprint, copy unique).
        # Corresponds to the JSON property `requestedLink`
        # @return [String]
        attr_accessor :requested_link
      
        # The entire FDL, expanded from a short link. It is the same as the
        # requested_link, if it is long. Parameters from this should not be
        # used directly (ie: server can default utm_[campaign|medium|source]
        # to a value when requested_link lack them, server determine the best
        # fallback_link when requested_link specifies >1 fallback links).
        # Corresponds to the JSON property `resolvedLink`
        # @return [String]
        attr_accessor :resolved_link
      
        # Scion campaign value to be propagated by iSDK to Scion at post-install.
        # Corresponds to the JSON property `utmCampaign`
        # @return [String]
        attr_accessor :utm_campaign
      
        # Scion medium value to be propagated by iSDK to Scion at post-install.
        # Corresponds to the JSON property `utmMedium`
        # @return [String]
        attr_accessor :utm_medium
      
        # Scion source value to be propagated by iSDK to Scion at post-install.
        # Corresponds to the JSON property `utmSource`
        # @return [String]
        attr_accessor :utm_source
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @app_minimum_version = args[:app_minimum_version] if args.key?(:app_minimum_version)
          @attribution_confidence = args[:attribution_confidence] if args.key?(:attribution_confidence)
          @deep_link = args[:deep_link] if args.key?(:deep_link)
          @external_browser_destination_link = args[:external_browser_destination_link] if args.key?(:external_browser_destination_link)
          @fallback_link = args[:fallback_link] if args.key?(:fallback_link)
          @invitation_id = args[:invitation_id] if args.key?(:invitation_id)
          @is_strong_match_executable = args[:is_strong_match_executable] if args.key?(:is_strong_match_executable)
          @match_message = args[:match_message] if args.key?(:match_message)
          @requested_link = args[:requested_link] if args.key?(:requested_link)
          @resolved_link = args[:resolved_link] if args.key?(:resolved_link)
          @utm_campaign = args[:utm_campaign] if args.key?(:utm_campaign)
          @utm_medium = args[:utm_medium] if args.key?(:utm_medium)
          @utm_source = args[:utm_source] if args.key?(:utm_source)
        end
      end
      
      # Parameters for Google Play Campaign Measurements.
      # [Learn more](https://developers.google.com/analytics/devguides/collection/
      # android/v4/campaigns#campaign-params)
      class GooglePlayAnalytics
        include Google::Apis::Core::Hashable
      
        # [AdWords autotagging parameter](https://support.google.com/analytics/answer/
        # 1033981?hl=en);
        # used to measure Google AdWords ads. This value is generated dynamically
        # and should never be modified.
        # Corresponds to the JSON property `gclid`
        # @return [String]
        attr_accessor :gclid
      
        # Campaign name; used for keyword analysis to identify a specific product
        # promotion or strategic campaign.
        # Corresponds to the JSON property `utmCampaign`
        # @return [String]
        attr_accessor :utm_campaign
      
        # Campaign content; used for A/B testing and content-targeted ads to
        # differentiate ads or links that point to the same URL.
        # Corresponds to the JSON property `utmContent`
        # @return [String]
        attr_accessor :utm_content
      
        # Campaign medium; used to identify a medium such as email or cost-per-click.
        # Corresponds to the JSON property `utmMedium`
        # @return [String]
        attr_accessor :utm_medium
      
        # Campaign source; used to identify a search engine, newsletter, or other
        # source.
        # Corresponds to the JSON property `utmSource`
        # @return [String]
        attr_accessor :utm_source
      
        # Campaign term; used with paid search to supply the keywords for ads.
        # Corresponds to the JSON property `utmTerm`
        # @return [String]
        attr_accessor :utm_term
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @gclid = args[:gclid] if args.key?(:gclid)
          @utm_campaign = args[:utm_campaign] if args.key?(:utm_campaign)
          @utm_content = args[:utm_content] if args.key?(:utm_content)
          @utm_medium = args[:utm_medium] if args.key?(:utm_medium)
          @utm_source = args[:utm_source] if args.key?(:utm_source)
          @utm_term = args[:utm_term] if args.key?(:utm_term)
        end
      end
      
      # Parameters for iTunes Connect App Analytics.
      class ITunesConnectAnalytics
        include Google::Apis::Core::Hashable
      
        # Affiliate token used to create affiliate-coded links.
        # Corresponds to the JSON property `at`
        # @return [String]
        attr_accessor :at
      
        # Campaign text that developers can optionally add to any link in order to
        # track sales from a specific marketing campaign.
        # Corresponds to the JSON property `ct`
        # @return [String]
        attr_accessor :ct
      
        # iTune media types, including music, podcasts, audiobooks and so on.
        # Corresponds to the JSON property `mt`
        # @return [String]
        attr_accessor :mt
      
        # Provider token that enables analytics for Dynamic Links from within iTunes
        # Connect.
        # Corresponds to the JSON property `pt`
        # @return [String]
        attr_accessor :pt
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @at = args[:at] if args.key?(:at)
          @ct = args[:ct] if args.key?(:ct)
          @mt = args[:mt] if args.key?(:mt)
          @pt = args[:pt] if args.key?(:pt)
        end
      end
      
      # iOS related attributes to the Dynamic Link..
      class IosInfo
        include Google::Apis::Core::Hashable
      
        # iOS App Store ID.
        # Corresponds to the JSON property `iosAppStoreId`
        # @return [String]
        attr_accessor :ios_app_store_id
      
        # iOS bundle ID of the app.
        # Corresponds to the JSON property `iosBundleId`
        # @return [String]
        attr_accessor :ios_bundle_id
      
        # Custom (destination) scheme to use for iOS. By default, we’ll use the
        # bundle ID as the custom scheme. Developer can override this behavior using
        # this param.
        # Corresponds to the JSON property `iosCustomScheme`
        # @return [String]
        attr_accessor :ios_custom_scheme
      
        # Link to open on iOS if the app is not installed.
        # Corresponds to the JSON property `iosFallbackLink`
        # @return [String]
        attr_accessor :ios_fallback_link
      
        # iPad bundle ID of the app.
        # Corresponds to the JSON property `iosIpadBundleId`
        # @return [String]
        attr_accessor :ios_ipad_bundle_id
      
        # If specified, this overrides the ios_fallback_link value on iPads.
        # Corresponds to the JSON property `iosIpadFallbackLink`
        # @return [String]
        attr_accessor :ios_ipad_fallback_link
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @ios_app_store_id = args[:ios_app_store_id] if args.key?(:ios_app_store_id)
          @ios_bundle_id = args[:ios_bundle_id] if args.key?(:ios_bundle_id)
          @ios_custom_scheme = args[:ios_custom_scheme] if args.key?(:ios_custom_scheme)
          @ios_fallback_link = args[:ios_fallback_link] if args.key?(:ios_fallback_link)
          @ios_ipad_bundle_id = args[:ios_ipad_bundle_id] if args.key?(:ios_ipad_bundle_id)
          @ios_ipad_fallback_link = args[:ios_ipad_fallback_link] if args.key?(:ios_ipad_fallback_link)
        end
      end
      
      # Information of navigation behavior.
      class NavigationInfo
        include Google::Apis::Core::Hashable
      
        # If this option is on, FDL click will be forced to redirect rather than
        # show an interstitial page.
        # Corresponds to the JSON property `enableForcedRedirect`
        # @return [Boolean]
        attr_accessor :enable_forced_redirect
        alias_method :enable_forced_redirect?, :enable_forced_redirect
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @enable_forced_redirect = args[:enable_forced_redirect] if args.key?(:enable_forced_redirect)
        end
      end
      
      # Parameters for social meta tag params.
      # Used to set meta tag data for link previews on social sites.
      class SocialMetaTagInfo
        include Google::Apis::Core::Hashable
      
        # A short description of the link. Optional.
        # Corresponds to the JSON property `socialDescription`
        # @return [String]
        attr_accessor :social_description
      
        # An image url string. Optional.
        # Corresponds to the JSON property `socialImageLink`
        # @return [String]
        attr_accessor :social_image_link
      
        # Title to be displayed. Optional.
        # Corresponds to the JSON property `socialTitle`
        # @return [String]
        attr_accessor :social_title
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @social_description = args[:social_description] if args.key?(:social_description)
          @social_image_link = args[:social_image_link] if args.key?(:social_image_link)
          @social_title = args[:social_title] if args.key?(:social_title)
        end
      end
      
      # Short Dynamic Link suffix.
      class Suffix
        include Google::Apis::Core::Hashable
      
        # Suffix option.
        # Corresponds to the JSON property `option`
        # @return [String]
        attr_accessor :option
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @option = args[:option] if args.key?(:option)
        end
      end
    end
  end
end
