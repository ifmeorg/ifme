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
    module GroupssettingsV1
      
      class Groups
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Groups
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :allow_external_members, as: 'allowExternalMembers'
          property :allow_google_communication, as: 'allowGoogleCommunication'
          property :allow_web_posting, as: 'allowWebPosting'
          property :archive_only, as: 'archiveOnly'
          property :custom_footer_text, as: 'customFooterText'
          property :custom_reply_to, as: 'customReplyTo'
          property :default_message_deny_notification_text, as: 'defaultMessageDenyNotificationText'
          property :description, as: 'description'
          property :email, as: 'email'
          property :include_custom_footer, as: 'includeCustomFooter'
          property :include_in_global_address_list, as: 'includeInGlobalAddressList'
          property :is_archived, as: 'isArchived'
          property :kind, as: 'kind'
          property :max_message_bytes, as: 'maxMessageBytes'
          property :members_can_post_as_the_group, as: 'membersCanPostAsTheGroup'
          property :message_display_font, as: 'messageDisplayFont'
          property :message_moderation_level, as: 'messageModerationLevel'
          property :name, as: 'name'
          property :primary_language, as: 'primaryLanguage'
          property :reply_to, as: 'replyTo'
          property :send_message_deny_notification, as: 'sendMessageDenyNotification'
          property :show_in_group_directory, as: 'showInGroupDirectory'
          property :spam_moderation_level, as: 'spamModerationLevel'
          property :who_can_add, as: 'whoCanAdd'
          property :who_can_contact_owner, as: 'whoCanContactOwner'
          property :who_can_invite, as: 'whoCanInvite'
          property :who_can_join, as: 'whoCanJoin'
          property :who_can_leave_group, as: 'whoCanLeaveGroup'
          property :who_can_post_message, as: 'whoCanPostMessage'
          property :who_can_view_group, as: 'whoCanViewGroup'
          property :who_can_view_membership, as: 'whoCanViewMembership'
        end
      end
    end
  end
end
