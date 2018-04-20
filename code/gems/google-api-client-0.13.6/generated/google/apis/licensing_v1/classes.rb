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
    module LicensingV1
      
      # Template for LiscenseAssignment Resource
      class LicenseAssignment
        include Google::Apis::Core::Hashable
      
        # ETag of the resource.
        # Corresponds to the JSON property `etags`
        # @return [String]
        attr_accessor :etags
      
        # Identifies the resource as a LicenseAssignment.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Id of the product.
        # Corresponds to the JSON property `productId`
        # @return [String]
        attr_accessor :product_id
      
        # Display Name of the product.
        # Corresponds to the JSON property `productName`
        # @return [String]
        attr_accessor :product_name
      
        # Link to this page.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # Id of the sku of the product.
        # Corresponds to the JSON property `skuId`
        # @return [String]
        attr_accessor :sku_id
      
        # Display Name of the sku of the product.
        # Corresponds to the JSON property `skuName`
        # @return [String]
        attr_accessor :sku_name
      
        # Email id of the user.
        # Corresponds to the JSON property `userId`
        # @return [String]
        attr_accessor :user_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etags = args[:etags] if args.key?(:etags)
          @kind = args[:kind] if args.key?(:kind)
          @product_id = args[:product_id] if args.key?(:product_id)
          @product_name = args[:product_name] if args.key?(:product_name)
          @self_link = args[:self_link] if args.key?(:self_link)
          @sku_id = args[:sku_id] if args.key?(:sku_id)
          @sku_name = args[:sku_name] if args.key?(:sku_name)
          @user_id = args[:user_id] if args.key?(:user_id)
        end
      end
      
      # Template for LicenseAssignment Insert request
      class LicenseAssignmentInsert
        include Google::Apis::Core::Hashable
      
        # Email id of the user
        # Corresponds to the JSON property `userId`
        # @return [String]
        attr_accessor :user_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @user_id = args[:user_id] if args.key?(:user_id)
        end
      end
      
      # LicesnseAssignment List for a given product/sku for a customer.
      class LicenseAssignmentList
        include Google::Apis::Core::Hashable
      
        # ETag of the resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The LicenseAssignments in this page of results.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::LicensingV1::LicenseAssignment>]
        attr_accessor :items
      
        # Identifies the resource as a collection of LicenseAssignments.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The continuation token, used to page through large result sets. Provide this
        # value in a subsequent request to return the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etag = args[:etag] if args.key?(:etag)
          @items = args[:items] if args.key?(:items)
          @kind = args[:kind] if args.key?(:kind)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
        end
      end
    end
  end
end
