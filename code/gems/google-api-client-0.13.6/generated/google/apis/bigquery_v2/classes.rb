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
    module BigqueryV2
      
      # 
      class BigtableColumn
        include Google::Apis::Core::Hashable
      
        # [Optional] The encoding of the values when the type is not STRING. Acceptable
        # encoding values are: TEXT - indicates values are alphanumeric text strings.
        # BINARY - indicates values are encoded using HBase Bytes.toBytes family of
        # functions. 'encoding' can also be set at the column family level. However, the
        # setting at this level takes precedence if 'encoding' is set at both levels.
        # Corresponds to the JSON property `encoding`
        # @return [String]
        attr_accessor :encoding
      
        # [Optional] If the qualifier is not a valid BigQuery field identifier i.e. does
        # not match [a-zA-Z][a-zA-Z0-9_]*, a valid identifier must be provided as the
        # column field name and is used as field name in queries.
        # Corresponds to the JSON property `fieldName`
        # @return [String]
        attr_accessor :field_name
      
        # [Optional] If this is set, only the latest version of value in this column are
        # exposed. 'onlyReadLatest' can also be set at the column family level. However,
        # the setting at this level takes precedence if 'onlyReadLatest' is set at both
        # levels.
        # Corresponds to the JSON property `onlyReadLatest`
        # @return [Boolean]
        attr_accessor :only_read_latest
        alias_method :only_read_latest?, :only_read_latest
      
        # [Required] Qualifier of the column. Columns in the parent column family that
        # has this exact qualifier are exposed as . field. If the qualifier is valid UTF-
        # 8 string, it can be specified in the qualifier_string field. Otherwise, a base-
        # 64 encoded value must be set to qualifier_encoded. The column field name is
        # the same as the column qualifier. However, if the qualifier is not a valid
        # BigQuery field identifier i.e. does not match [a-zA-Z][a-zA-Z0-9_]*, a valid
        # identifier must be provided as field_name.
        # Corresponds to the JSON property `qualifierEncoded`
        # NOTE: Values are automatically base64 encoded/decoded in the client library.
        # @return [String]
        attr_accessor :qualifier_encoded
      
        # 
        # Corresponds to the JSON property `qualifierString`
        # @return [String]
        attr_accessor :qualifier_string
      
        # [Optional] The type to convert the value in cells of this column. The values
        # are expected to be encoded using HBase Bytes.toBytes function when using the
        # BINARY encoding value. Following BigQuery types are allowed (case-sensitive) -
        # BYTES STRING INTEGER FLOAT BOOLEAN Default type is BYTES. 'type' can also be
        # set at the column family level. However, the setting at this level takes
        # precedence if 'type' is set at both levels.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @encoding = args[:encoding] if args.key?(:encoding)
          @field_name = args[:field_name] if args.key?(:field_name)
          @only_read_latest = args[:only_read_latest] if args.key?(:only_read_latest)
          @qualifier_encoded = args[:qualifier_encoded] if args.key?(:qualifier_encoded)
          @qualifier_string = args[:qualifier_string] if args.key?(:qualifier_string)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # 
      class BigtableColumnFamily
        include Google::Apis::Core::Hashable
      
        # [Optional] Lists of columns that should be exposed as individual fields as
        # opposed to a list of (column name, value) pairs. All columns whose qualifier
        # matches a qualifier in this list can be accessed as .. Other columns can be
        # accessed as a list through .Column field.
        # Corresponds to the JSON property `columns`
        # @return [Array<Google::Apis::BigqueryV2::BigtableColumn>]
        attr_accessor :columns
      
        # [Optional] The encoding of the values when the type is not STRING. Acceptable
        # encoding values are: TEXT - indicates values are alphanumeric text strings.
        # BINARY - indicates values are encoded using HBase Bytes.toBytes family of
        # functions. This can be overridden for a specific column by listing that column
        # in 'columns' and specifying an encoding for it.
        # Corresponds to the JSON property `encoding`
        # @return [String]
        attr_accessor :encoding
      
        # Identifier of the column family.
        # Corresponds to the JSON property `familyId`
        # @return [String]
        attr_accessor :family_id
      
        # [Optional] If this is set only the latest version of value are exposed for all
        # columns in this column family. This can be overridden for a specific column by
        # listing that column in 'columns' and specifying a different setting for that
        # column.
        # Corresponds to the JSON property `onlyReadLatest`
        # @return [Boolean]
        attr_accessor :only_read_latest
        alias_method :only_read_latest?, :only_read_latest
      
        # [Optional] The type to convert the value in cells of this column family. The
        # values are expected to be encoded using HBase Bytes.toBytes function when
        # using the BINARY encoding value. Following BigQuery types are allowed (case-
        # sensitive) - BYTES STRING INTEGER FLOAT BOOLEAN Default type is BYTES. This
        # can be overridden for a specific column by listing that column in 'columns'
        # and specifying a type for it.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @columns = args[:columns] if args.key?(:columns)
          @encoding = args[:encoding] if args.key?(:encoding)
          @family_id = args[:family_id] if args.key?(:family_id)
          @only_read_latest = args[:only_read_latest] if args.key?(:only_read_latest)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # 
      class BigtableOptions
        include Google::Apis::Core::Hashable
      
        # [Optional] List of column families to expose in the table schema along with
        # their types. This list restricts the column families that can be referenced in
        # queries and specifies their value types. You can use this list to do type
        # conversions - see the 'type' field for more details. If you leave this list
        # empty, all column families are present in the table schema and their values
        # are read as BYTES. During a query only the column families referenced in that
        # query are read from Bigtable.
        # Corresponds to the JSON property `columnFamilies`
        # @return [Array<Google::Apis::BigqueryV2::BigtableColumnFamily>]
        attr_accessor :column_families
      
        # [Optional] If field is true, then the column families that are not specified
        # in columnFamilies list are not exposed in the table schema. Otherwise, they
        # are read with BYTES type values. The default value is false.
        # Corresponds to the JSON property `ignoreUnspecifiedColumnFamilies`
        # @return [Boolean]
        attr_accessor :ignore_unspecified_column_families
        alias_method :ignore_unspecified_column_families?, :ignore_unspecified_column_families
      
        # [Optional] If field is true, then the rowkey column families will be read and
        # converted to string. Otherwise they are read with BYTES type values and users
        # need to manually cast them with CAST if necessary. The default value is false.
        # Corresponds to the JSON property `readRowkeyAsString`
        # @return [Boolean]
        attr_accessor :read_rowkey_as_string
        alias_method :read_rowkey_as_string?, :read_rowkey_as_string
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @column_families = args[:column_families] if args.key?(:column_families)
          @ignore_unspecified_column_families = args[:ignore_unspecified_column_families] if args.key?(:ignore_unspecified_column_families)
          @read_rowkey_as_string = args[:read_rowkey_as_string] if args.key?(:read_rowkey_as_string)
        end
      end
      
      # 
      class CsvOptions
        include Google::Apis::Core::Hashable
      
        # [Optional] Indicates if BigQuery should accept rows that are missing trailing
        # optional columns. If true, BigQuery treats missing trailing columns as null
        # values. If false, records with missing trailing columns are treated as bad
        # records, and if there are too many bad records, an invalid error is returned
        # in the job result. The default value is false.
        # Corresponds to the JSON property `allowJaggedRows`
        # @return [Boolean]
        attr_accessor :allow_jagged_rows
        alias_method :allow_jagged_rows?, :allow_jagged_rows
      
        # [Optional] Indicates if BigQuery should allow quoted data sections that
        # contain newline characters in a CSV file. The default value is false.
        # Corresponds to the JSON property `allowQuotedNewlines`
        # @return [Boolean]
        attr_accessor :allow_quoted_newlines
        alias_method :allow_quoted_newlines?, :allow_quoted_newlines
      
        # [Optional] The character encoding of the data. The supported values are UTF-8
        # or ISO-8859-1. The default value is UTF-8. BigQuery decodes the data after the
        # raw, binary data has been split using the values of the quote and
        # fieldDelimiter properties.
        # Corresponds to the JSON property `encoding`
        # @return [String]
        attr_accessor :encoding
      
        # [Optional] The separator for fields in a CSV file. BigQuery converts the
        # string to ISO-8859-1 encoding, and then uses the first byte of the encoded
        # string to split the data in its raw, binary state. BigQuery also supports the
        # escape sequence "\t" to specify a tab separator. The default value is a comma (
        # ',').
        # Corresponds to the JSON property `fieldDelimiter`
        # @return [String]
        attr_accessor :field_delimiter
      
        # [Optional] The value that is used to quote data sections in a CSV file.
        # BigQuery converts the string to ISO-8859-1 encoding, and then uses the first
        # byte of the encoded string to split the data in its raw, binary state. The
        # default value is a double-quote ('"'). If your data does not contain quoted
        # sections, set the property value to an empty string. If your data contains
        # quoted newline characters, you must also set the allowQuotedNewlines property
        # to true.
        # Corresponds to the JSON property `quote`
        # @return [String]
        attr_accessor :quote
      
        # [Optional] The number of rows at the top of a CSV file that BigQuery will skip
        # when reading the data. The default value is 0. This property is useful if you
        # have header rows in the file that should be skipped.
        # Corresponds to the JSON property `skipLeadingRows`
        # @return [Fixnum]
        attr_accessor :skip_leading_rows
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @allow_jagged_rows = args[:allow_jagged_rows] if args.key?(:allow_jagged_rows)
          @allow_quoted_newlines = args[:allow_quoted_newlines] if args.key?(:allow_quoted_newlines)
          @encoding = args[:encoding] if args.key?(:encoding)
          @field_delimiter = args[:field_delimiter] if args.key?(:field_delimiter)
          @quote = args[:quote] if args.key?(:quote)
          @skip_leading_rows = args[:skip_leading_rows] if args.key?(:skip_leading_rows)
        end
      end
      
      # 
      class Dataset
        include Google::Apis::Core::Hashable
      
        # [Optional] An array of objects that define dataset access for one or more
        # entities. You can set this property when inserting or updating a dataset in
        # order to control who is allowed to access the data. If unspecified at dataset
        # creation time, BigQuery adds default dataset access for the following entities:
        # access.specialGroup: projectReaders; access.role: READER; access.specialGroup:
        # projectWriters; access.role: WRITER; access.specialGroup: projectOwners;
        # access.role: OWNER; access.userByEmail: [dataset creator email]; access.role:
        # OWNER;
        # Corresponds to the JSON property `access`
        # @return [Array<Google::Apis::BigqueryV2::Dataset::Access>]
        attr_accessor :access
      
        # [Output-only] The time when this dataset was created, in milliseconds since
        # the epoch.
        # Corresponds to the JSON property `creationTime`
        # @return [Fixnum]
        attr_accessor :creation_time
      
        # [Required] A reference that identifies the dataset.
        # Corresponds to the JSON property `datasetReference`
        # @return [Google::Apis::BigqueryV2::DatasetReference]
        attr_accessor :dataset_reference
      
        # [Optional] The default lifetime of all tables in the dataset, in milliseconds.
        # The minimum value is 3600000 milliseconds (one hour). Once this property is
        # set, all newly-created tables in the dataset will have an expirationTime
        # property set to the creation time plus the value in this property, and
        # changing the value will only affect new tables, not existing ones. When the
        # expirationTime for a given table is reached, that table will be deleted
        # automatically. If a table's expirationTime is modified or removed before the
        # table expires, or if you provide an explicit expirationTime when creating a
        # table, that value takes precedence over the default expiration time indicated
        # by this property.
        # Corresponds to the JSON property `defaultTableExpirationMs`
        # @return [Fixnum]
        attr_accessor :default_table_expiration_ms
      
        # [Optional] A user-friendly description of the dataset.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # [Output-only] A hash of the resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # [Optional] A descriptive name for the dataset.
        # Corresponds to the JSON property `friendlyName`
        # @return [String]
        attr_accessor :friendly_name
      
        # [Output-only] The fully-qualified unique name of the dataset in the format
        # projectId:datasetId. The dataset name without the project name is given in the
        # datasetId field. When creating a new dataset, leave this field blank, and
        # instead specify the datasetId field.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # [Output-only] The resource type.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The labels associated with this dataset. You can use these to organize and
        # group your datasets. You can set this property when inserting or updating a
        # dataset. See Labeling Datasets for more information.
        # Corresponds to the JSON property `labels`
        # @return [Hash<String,String>]
        attr_accessor :labels
      
        # [Output-only] The date when this dataset or any of its tables was last
        # modified, in milliseconds since the epoch.
        # Corresponds to the JSON property `lastModifiedTime`
        # @return [Fixnum]
        attr_accessor :last_modified_time
      
        # The geographic location where the dataset should reside. Possible values
        # include EU and US. The default value is US.
        # Corresponds to the JSON property `location`
        # @return [String]
        attr_accessor :location
      
        # [Output-only] A URL that can be used to access the resource again. You can use
        # this URL in Get or Update requests to the resource.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @access = args[:access] if args.key?(:access)
          @creation_time = args[:creation_time] if args.key?(:creation_time)
          @dataset_reference = args[:dataset_reference] if args.key?(:dataset_reference)
          @default_table_expiration_ms = args[:default_table_expiration_ms] if args.key?(:default_table_expiration_ms)
          @description = args[:description] if args.key?(:description)
          @etag = args[:etag] if args.key?(:etag)
          @friendly_name = args[:friendly_name] if args.key?(:friendly_name)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @labels = args[:labels] if args.key?(:labels)
          @last_modified_time = args[:last_modified_time] if args.key?(:last_modified_time)
          @location = args[:location] if args.key?(:location)
          @self_link = args[:self_link] if args.key?(:self_link)
        end
        
        # 
        class Access
          include Google::Apis::Core::Hashable
        
          # [Pick one] A domain to grant access to. Any users signed in with the domain
          # specified will be granted the specified access. Example: "example.com".
          # Corresponds to the JSON property `domain`
          # @return [String]
          attr_accessor :domain
        
          # [Pick one] An email address of a Google Group to grant access to.
          # Corresponds to the JSON property `groupByEmail`
          # @return [String]
          attr_accessor :group_by_email
        
          # [Required] Describes the rights granted to the user specified by the other
          # member of the access object. The following string values are supported: READER,
          # WRITER, OWNER.
          # Corresponds to the JSON property `role`
          # @return [String]
          attr_accessor :role
        
          # [Pick one] A special group to grant access to. Possible values include:
          # projectOwners: Owners of the enclosing project. projectReaders: Readers of the
          # enclosing project. projectWriters: Writers of the enclosing project.
          # allAuthenticatedUsers: All authenticated BigQuery users.
          # Corresponds to the JSON property `specialGroup`
          # @return [String]
          attr_accessor :special_group
        
          # [Pick one] An email address of a user to grant access to. For example: fred@
          # example.com.
          # Corresponds to the JSON property `userByEmail`
          # @return [String]
          attr_accessor :user_by_email
        
          # [Pick one] A view from a different dataset to grant access to. Queries
          # executed against that view will have read access to tables in this dataset.
          # The role field is not required when this field is set. If that view is updated
          # by any user, access to the view needs to be granted again via an update
          # operation.
          # Corresponds to the JSON property `view`
          # @return [Google::Apis::BigqueryV2::TableReference]
          attr_accessor :view
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @domain = args[:domain] if args.key?(:domain)
            @group_by_email = args[:group_by_email] if args.key?(:group_by_email)
            @role = args[:role] if args.key?(:role)
            @special_group = args[:special_group] if args.key?(:special_group)
            @user_by_email = args[:user_by_email] if args.key?(:user_by_email)
            @view = args[:view] if args.key?(:view)
          end
        end
      end
      
      # 
      class DatasetList
        include Google::Apis::Core::Hashable
      
        # An array of the dataset resources in the project. Each resource contains basic
        # information. For full information about a particular dataset resource, use the
        # Datasets: get method. This property is omitted when there are no datasets in
        # the project.
        # Corresponds to the JSON property `datasets`
        # @return [Array<Google::Apis::BigqueryV2::DatasetList::Dataset>]
        attr_accessor :datasets
      
        # A hash value of the results page. You can use this property to determine if
        # the page has changed since the last request.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The list type. This property always returns the value "bigquery#datasetList".
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A token that can be used to request the next results page. This property is
        # omitted on the final results page.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @datasets = args[:datasets] if args.key?(:datasets)
          @etag = args[:etag] if args.key?(:etag)
          @kind = args[:kind] if args.key?(:kind)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
        end
        
        # 
        class Dataset
          include Google::Apis::Core::Hashable
        
          # The dataset reference. Use this property to access specific parts of the
          # dataset's ID, such as project ID or dataset ID.
          # Corresponds to the JSON property `datasetReference`
          # @return [Google::Apis::BigqueryV2::DatasetReference]
          attr_accessor :dataset_reference
        
          # A descriptive name for the dataset, if one exists.
          # Corresponds to the JSON property `friendlyName`
          # @return [String]
          attr_accessor :friendly_name
        
          # The fully-qualified, unique, opaque ID of the dataset.
          # Corresponds to the JSON property `id`
          # @return [String]
          attr_accessor :id
        
          # The resource type. This property always returns the value "bigquery#dataset".
          # Corresponds to the JSON property `kind`
          # @return [String]
          attr_accessor :kind
        
          # The labels associated with this dataset. You can use these to organize and
          # group your datasets.
          # Corresponds to the JSON property `labels`
          # @return [Hash<String,String>]
          attr_accessor :labels
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @dataset_reference = args[:dataset_reference] if args.key?(:dataset_reference)
            @friendly_name = args[:friendly_name] if args.key?(:friendly_name)
            @id = args[:id] if args.key?(:id)
            @kind = args[:kind] if args.key?(:kind)
            @labels = args[:labels] if args.key?(:labels)
          end
        end
      end
      
      # 
      class DatasetReference
        include Google::Apis::Core::Hashable
      
        # [Required] A unique ID for this dataset, without the project name. The ID must
        # contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The
        # maximum length is 1,024 characters.
        # Corresponds to the JSON property `datasetId`
        # @return [String]
        attr_accessor :dataset_id
      
        # [Optional] The ID of the project containing this dataset.
        # Corresponds to the JSON property `projectId`
        # @return [String]
        attr_accessor :project_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @dataset_id = args[:dataset_id] if args.key?(:dataset_id)
          @project_id = args[:project_id] if args.key?(:project_id)
        end
      end
      
      # 
      class EncryptionConfiguration
        include Google::Apis::Core::Hashable
      
        # [Optional] Describes the Cloud KMS encryption key that will be used to protect
        # destination BigQuery table. The BigQuery Service Account associated with your
        # project requires access to this encryption key.
        # Corresponds to the JSON property `kmsKeyName`
        # @return [String]
        attr_accessor :kms_key_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kms_key_name = args[:kms_key_name] if args.key?(:kms_key_name)
        end
      end
      
      # 
      class ErrorProto
        include Google::Apis::Core::Hashable
      
        # Debugging information. This property is internal to Google and should not be
        # used.
        # Corresponds to the JSON property `debugInfo`
        # @return [String]
        attr_accessor :debug_info
      
        # Specifies where the error occurred, if present.
        # Corresponds to the JSON property `location`
        # @return [String]
        attr_accessor :location
      
        # A human-readable description of the error.
        # Corresponds to the JSON property `message`
        # @return [String]
        attr_accessor :message
      
        # A short error code that summarizes the error.
        # Corresponds to the JSON property `reason`
        # @return [String]
        attr_accessor :reason
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @debug_info = args[:debug_info] if args.key?(:debug_info)
          @location = args[:location] if args.key?(:location)
          @message = args[:message] if args.key?(:message)
          @reason = args[:reason] if args.key?(:reason)
        end
      end
      
      # 
      class ExplainQueryStage
        include Google::Apis::Core::Hashable
      
        # Milliseconds the average shard spent on CPU-bound tasks.
        # Corresponds to the JSON property `computeMsAvg`
        # @return [Fixnum]
        attr_accessor :compute_ms_avg
      
        # Milliseconds the slowest shard spent on CPU-bound tasks.
        # Corresponds to the JSON property `computeMsMax`
        # @return [Fixnum]
        attr_accessor :compute_ms_max
      
        # Relative amount of time the average shard spent on CPU-bound tasks.
        # Corresponds to the JSON property `computeRatioAvg`
        # @return [Float]
        attr_accessor :compute_ratio_avg
      
        # Relative amount of time the slowest shard spent on CPU-bound tasks.
        # Corresponds to the JSON property `computeRatioMax`
        # @return [Float]
        attr_accessor :compute_ratio_max
      
        # Unique ID for stage within plan.
        # Corresponds to the JSON property `id`
        # @return [Fixnum]
        attr_accessor :id
      
        # Human-readable name for stage.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Milliseconds the average shard spent reading input.
        # Corresponds to the JSON property `readMsAvg`
        # @return [Fixnum]
        attr_accessor :read_ms_avg
      
        # Milliseconds the slowest shard spent reading input.
        # Corresponds to the JSON property `readMsMax`
        # @return [Fixnum]
        attr_accessor :read_ms_max
      
        # Relative amount of time the average shard spent reading input.
        # Corresponds to the JSON property `readRatioAvg`
        # @return [Float]
        attr_accessor :read_ratio_avg
      
        # Relative amount of time the slowest shard spent reading input.
        # Corresponds to the JSON property `readRatioMax`
        # @return [Float]
        attr_accessor :read_ratio_max
      
        # Number of records read into the stage.
        # Corresponds to the JSON property `recordsRead`
        # @return [Fixnum]
        attr_accessor :records_read
      
        # Number of records written by the stage.
        # Corresponds to the JSON property `recordsWritten`
        # @return [Fixnum]
        attr_accessor :records_written
      
        # Total number of bytes written to shuffle.
        # Corresponds to the JSON property `shuffleOutputBytes`
        # @return [Fixnum]
        attr_accessor :shuffle_output_bytes
      
        # Total number of bytes written to shuffle and spilled to disk.
        # Corresponds to the JSON property `shuffleOutputBytesSpilled`
        # @return [Fixnum]
        attr_accessor :shuffle_output_bytes_spilled
      
        # Current status for the stage.
        # Corresponds to the JSON property `status`
        # @return [String]
        attr_accessor :status
      
        # List of operations within the stage in dependency order (approximately
        # chronological).
        # Corresponds to the JSON property `steps`
        # @return [Array<Google::Apis::BigqueryV2::ExplainQueryStep>]
        attr_accessor :steps
      
        # Milliseconds the average shard spent waiting to be scheduled.
        # Corresponds to the JSON property `waitMsAvg`
        # @return [Fixnum]
        attr_accessor :wait_ms_avg
      
        # Milliseconds the slowest shard spent waiting to be scheduled.
        # Corresponds to the JSON property `waitMsMax`
        # @return [Fixnum]
        attr_accessor :wait_ms_max
      
        # Relative amount of time the average shard spent waiting to be scheduled.
        # Corresponds to the JSON property `waitRatioAvg`
        # @return [Float]
        attr_accessor :wait_ratio_avg
      
        # Relative amount of time the slowest shard spent waiting to be scheduled.
        # Corresponds to the JSON property `waitRatioMax`
        # @return [Float]
        attr_accessor :wait_ratio_max
      
        # Milliseconds the average shard spent on writing output.
        # Corresponds to the JSON property `writeMsAvg`
        # @return [Fixnum]
        attr_accessor :write_ms_avg
      
        # Milliseconds the slowest shard spent on writing output.
        # Corresponds to the JSON property `writeMsMax`
        # @return [Fixnum]
        attr_accessor :write_ms_max
      
        # Relative amount of time the average shard spent on writing output.
        # Corresponds to the JSON property `writeRatioAvg`
        # @return [Float]
        attr_accessor :write_ratio_avg
      
        # Relative amount of time the slowest shard spent on writing output.
        # Corresponds to the JSON property `writeRatioMax`
        # @return [Float]
        attr_accessor :write_ratio_max
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @compute_ms_avg = args[:compute_ms_avg] if args.key?(:compute_ms_avg)
          @compute_ms_max = args[:compute_ms_max] if args.key?(:compute_ms_max)
          @compute_ratio_avg = args[:compute_ratio_avg] if args.key?(:compute_ratio_avg)
          @compute_ratio_max = args[:compute_ratio_max] if args.key?(:compute_ratio_max)
          @id = args[:id] if args.key?(:id)
          @name = args[:name] if args.key?(:name)
          @read_ms_avg = args[:read_ms_avg] if args.key?(:read_ms_avg)
          @read_ms_max = args[:read_ms_max] if args.key?(:read_ms_max)
          @read_ratio_avg = args[:read_ratio_avg] if args.key?(:read_ratio_avg)
          @read_ratio_max = args[:read_ratio_max] if args.key?(:read_ratio_max)
          @records_read = args[:records_read] if args.key?(:records_read)
          @records_written = args[:records_written] if args.key?(:records_written)
          @shuffle_output_bytes = args[:shuffle_output_bytes] if args.key?(:shuffle_output_bytes)
          @shuffle_output_bytes_spilled = args[:shuffle_output_bytes_spilled] if args.key?(:shuffle_output_bytes_spilled)
          @status = args[:status] if args.key?(:status)
          @steps = args[:steps] if args.key?(:steps)
          @wait_ms_avg = args[:wait_ms_avg] if args.key?(:wait_ms_avg)
          @wait_ms_max = args[:wait_ms_max] if args.key?(:wait_ms_max)
          @wait_ratio_avg = args[:wait_ratio_avg] if args.key?(:wait_ratio_avg)
          @wait_ratio_max = args[:wait_ratio_max] if args.key?(:wait_ratio_max)
          @write_ms_avg = args[:write_ms_avg] if args.key?(:write_ms_avg)
          @write_ms_max = args[:write_ms_max] if args.key?(:write_ms_max)
          @write_ratio_avg = args[:write_ratio_avg] if args.key?(:write_ratio_avg)
          @write_ratio_max = args[:write_ratio_max] if args.key?(:write_ratio_max)
        end
      end
      
      # 
      class ExplainQueryStep
        include Google::Apis::Core::Hashable
      
        # Machine-readable operation type.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Human-readable stage descriptions.
        # Corresponds to the JSON property `substeps`
        # @return [Array<String>]
        attr_accessor :substeps
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] if args.key?(:kind)
          @substeps = args[:substeps] if args.key?(:substeps)
        end
      end
      
      # 
      class ExternalDataConfiguration
        include Google::Apis::Core::Hashable
      
        # Try to detect schema and format options automatically. Any option specified
        # explicitly will be honored.
        # Corresponds to the JSON property `autodetect`
        # @return [Boolean]
        attr_accessor :autodetect
        alias_method :autodetect?, :autodetect
      
        # [Optional] Additional options if sourceFormat is set to BIGTABLE.
        # Corresponds to the JSON property `bigtableOptions`
        # @return [Google::Apis::BigqueryV2::BigtableOptions]
        attr_accessor :bigtable_options
      
        # [Optional] The compression type of the data source. Possible values include
        # GZIP and NONE. The default value is NONE. This setting is ignored for Google
        # Cloud Bigtable, Google Cloud Datastore backups and Avro formats.
        # Corresponds to the JSON property `compression`
        # @return [String]
        attr_accessor :compression
      
        # Additional properties to set if sourceFormat is set to CSV.
        # Corresponds to the JSON property `csvOptions`
        # @return [Google::Apis::BigqueryV2::CsvOptions]
        attr_accessor :csv_options
      
        # [Optional] Additional options if sourceFormat is set to GOOGLE_SHEETS.
        # Corresponds to the JSON property `googleSheetsOptions`
        # @return [Google::Apis::BigqueryV2::GoogleSheetsOptions]
        attr_accessor :google_sheets_options
      
        # [Optional] Indicates if BigQuery should allow extra values that are not
        # represented in the table schema. If true, the extra values are ignored. If
        # false, records with extra columns are treated as bad records, and if there are
        # too many bad records, an invalid error is returned in the job result. The
        # default value is false. The sourceFormat property determines what BigQuery
        # treats as an extra value: CSV: Trailing columns JSON: Named values that don't
        # match any column names Google Cloud Bigtable: This setting is ignored. Google
        # Cloud Datastore backups: This setting is ignored. Avro: This setting is
        # ignored.
        # Corresponds to the JSON property `ignoreUnknownValues`
        # @return [Boolean]
        attr_accessor :ignore_unknown_values
        alias_method :ignore_unknown_values?, :ignore_unknown_values
      
        # [Optional] The maximum number of bad records that BigQuery can ignore when
        # reading data. If the number of bad records exceeds this value, an invalid
        # error is returned in the job result. The default value is 0, which requires
        # that all records are valid. This setting is ignored for Google Cloud Bigtable,
        # Google Cloud Datastore backups and Avro formats.
        # Corresponds to the JSON property `maxBadRecords`
        # @return [Fixnum]
        attr_accessor :max_bad_records
      
        # [Optional] The schema for the data. Schema is required for CSV and JSON
        # formats. Schema is disallowed for Google Cloud Bigtable, Cloud Datastore
        # backups, and Avro formats.
        # Corresponds to the JSON property `schema`
        # @return [Google::Apis::BigqueryV2::TableSchema]
        attr_accessor :schema
      
        # [Required] The data format. For CSV files, specify "CSV". For Google sheets,
        # specify "GOOGLE_SHEETS". For newline-delimited JSON, specify "
        # NEWLINE_DELIMITED_JSON". For Avro files, specify "AVRO". For Google Cloud
        # Datastore backups, specify "DATASTORE_BACKUP". [Beta] For Google Cloud
        # Bigtable, specify "BIGTABLE".
        # Corresponds to the JSON property `sourceFormat`
        # @return [String]
        attr_accessor :source_format
      
        # [Required] The fully-qualified URIs that point to your data in Google Cloud.
        # For Google Cloud Storage URIs: Each URI can contain one '*' wildcard character
        # and it must come after the 'bucket' name. Size limits related to load jobs
        # apply to external data sources. For Google Cloud Bigtable URIs: Exactly one
        # URI can be specified and it has be a fully specified and valid HTTPS URL for a
        # Google Cloud Bigtable table. For Google Cloud Datastore backups, exactly one
        # URI can be specified. Also, the '*' wildcard character is not allowed.
        # Corresponds to the JSON property `sourceUris`
        # @return [Array<String>]
        attr_accessor :source_uris
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @autodetect = args[:autodetect] if args.key?(:autodetect)
          @bigtable_options = args[:bigtable_options] if args.key?(:bigtable_options)
          @compression = args[:compression] if args.key?(:compression)
          @csv_options = args[:csv_options] if args.key?(:csv_options)
          @google_sheets_options = args[:google_sheets_options] if args.key?(:google_sheets_options)
          @ignore_unknown_values = args[:ignore_unknown_values] if args.key?(:ignore_unknown_values)
          @max_bad_records = args[:max_bad_records] if args.key?(:max_bad_records)
          @schema = args[:schema] if args.key?(:schema)
          @source_format = args[:source_format] if args.key?(:source_format)
          @source_uris = args[:source_uris] if args.key?(:source_uris)
        end
      end
      
      # 
      class GetQueryResultsResponse
        include Google::Apis::Core::Hashable
      
        # Whether the query result was fetched from the query cache.
        # Corresponds to the JSON property `cacheHit`
        # @return [Boolean]
        attr_accessor :cache_hit
        alias_method :cache_hit?, :cache_hit
      
        # [Output-only] The first errors or warnings encountered during the running of
        # the job. The final message includes the number of errors that caused the
        # process to stop. Errors here do not necessarily mean that the job has
        # completed or was unsuccessful.
        # Corresponds to the JSON property `errors`
        # @return [Array<Google::Apis::BigqueryV2::ErrorProto>]
        attr_accessor :errors
      
        # A hash of this response.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # Whether the query has completed or not. If rows or totalRows are present, this
        # will always be true. If this is false, totalRows will not be available.
        # Corresponds to the JSON property `jobComplete`
        # @return [Boolean]
        attr_accessor :job_complete
        alias_method :job_complete?, :job_complete
      
        # Reference to the BigQuery Job that was created to run the query. This field
        # will be present even if the original request timed out, in which case
        # GetQueryResults can be used to read the results once the query has completed.
        # Since this API only returns the first page of results, subsequent pages can be
        # fetched via the same mechanism (GetQueryResults).
        # Corresponds to the JSON property `jobReference`
        # @return [Google::Apis::BigqueryV2::JobReference]
        attr_accessor :job_reference
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # [Output-only] The number of rows affected by a DML statement. Present only for
        # DML statements INSERT, UPDATE or DELETE.
        # Corresponds to the JSON property `numDmlAffectedRows`
        # @return [Fixnum]
        attr_accessor :num_dml_affected_rows
      
        # A token used for paging results.
        # Corresponds to the JSON property `pageToken`
        # @return [String]
        attr_accessor :page_token
      
        # An object with as many results as can be contained within the maximum
        # permitted reply size. To get any additional rows, you can call GetQueryResults
        # and specify the jobReference returned above. Present only when the query
        # completes successfully.
        # Corresponds to the JSON property `rows`
        # @return [Array<Google::Apis::BigqueryV2::TableRow>]
        attr_accessor :rows
      
        # The schema of the results. Present only when the query completes successfully.
        # Corresponds to the JSON property `schema`
        # @return [Google::Apis::BigqueryV2::TableSchema]
        attr_accessor :schema
      
        # The total number of bytes processed for this query.
        # Corresponds to the JSON property `totalBytesProcessed`
        # @return [Fixnum]
        attr_accessor :total_bytes_processed
      
        # The total number of rows in the complete query result set, which can be more
        # than the number of rows in this single page of results. Present only when the
        # query completes successfully.
        # Corresponds to the JSON property `totalRows`
        # @return [Fixnum]
        attr_accessor :total_rows
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cache_hit = args[:cache_hit] if args.key?(:cache_hit)
          @errors = args[:errors] if args.key?(:errors)
          @etag = args[:etag] if args.key?(:etag)
          @job_complete = args[:job_complete] if args.key?(:job_complete)
          @job_reference = args[:job_reference] if args.key?(:job_reference)
          @kind = args[:kind] if args.key?(:kind)
          @num_dml_affected_rows = args[:num_dml_affected_rows] if args.key?(:num_dml_affected_rows)
          @page_token = args[:page_token] if args.key?(:page_token)
          @rows = args[:rows] if args.key?(:rows)
          @schema = args[:schema] if args.key?(:schema)
          @total_bytes_processed = args[:total_bytes_processed] if args.key?(:total_bytes_processed)
          @total_rows = args[:total_rows] if args.key?(:total_rows)
        end
      end
      
      # 
      class GetServiceAccountResponse
        include Google::Apis::Core::Hashable
      
        # The service account email address.
        # Corresponds to the JSON property `email`
        # @return [String]
        attr_accessor :email
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @email = args[:email] if args.key?(:email)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # 
      class GoogleSheetsOptions
        include Google::Apis::Core::Hashable
      
        # [Optional] The number of rows at the top of a sheet that BigQuery will skip
        # when reading the data. The default value is 0. This property is useful if you
        # have header rows that should be skipped. When autodetect is on, behavior is
        # the following: * skipLeadingRows unspecified - Autodetect tries to detect
        # headers in the first row. If they are not detected, the row is read as data.
        # Otherwise data is read starting from the second row. * skipLeadingRows is 0 -
        # Instructs autodetect that there are no headers and data should be read
        # starting from the first row. * skipLeadingRows = N > 0 - Autodetect skips N-1
        # rows and tries to detect headers in row N. If headers are not detected, row N
        # is just skipped. Otherwise row N is used to extract column names for the
        # detected schema.
        # Corresponds to the JSON property `skipLeadingRows`
        # @return [Fixnum]
        attr_accessor :skip_leading_rows
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @skip_leading_rows = args[:skip_leading_rows] if args.key?(:skip_leading_rows)
        end
      end
      
      # 
      class Job
        include Google::Apis::Core::Hashable
      
        # [Required] Describes the job configuration.
        # Corresponds to the JSON property `configuration`
        # @return [Google::Apis::BigqueryV2::JobConfiguration]
        attr_accessor :configuration
      
        # [Output-only] A hash of this resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # [Output-only] Opaque ID field of the job
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # [Optional] Reference describing the unique-per-user name of the job.
        # Corresponds to the JSON property `jobReference`
        # @return [Google::Apis::BigqueryV2::JobReference]
        attr_accessor :job_reference
      
        # [Output-only] The type of the resource.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # [Output-only] A URL that can be used to access this resource again.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # [Output-only] Information about the job, including starting time and ending
        # time of the job.
        # Corresponds to the JSON property `statistics`
        # @return [Google::Apis::BigqueryV2::JobStatistics]
        attr_accessor :statistics
      
        # [Output-only] The status of this job. Examine this value when polling an
        # asynchronous job to see if the job is complete.
        # Corresponds to the JSON property `status`
        # @return [Google::Apis::BigqueryV2::JobStatus]
        attr_accessor :status
      
        # [Output-only] Email address of the user who ran the job.
        # Corresponds to the JSON property `user_email`
        # @return [String]
        attr_accessor :user_email
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @configuration = args[:configuration] if args.key?(:configuration)
          @etag = args[:etag] if args.key?(:etag)
          @id = args[:id] if args.key?(:id)
          @job_reference = args[:job_reference] if args.key?(:job_reference)
          @kind = args[:kind] if args.key?(:kind)
          @self_link = args[:self_link] if args.key?(:self_link)
          @statistics = args[:statistics] if args.key?(:statistics)
          @status = args[:status] if args.key?(:status)
          @user_email = args[:user_email] if args.key?(:user_email)
        end
      end
      
      # 
      class CancelJobResponse
        include Google::Apis::Core::Hashable
      
        # The final state of the job.
        # Corresponds to the JSON property `job`
        # @return [Google::Apis::BigqueryV2::Job]
        attr_accessor :job
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @job = args[:job] if args.key?(:job)
          @kind = args[:kind] if args.key?(:kind)
        end
      end
      
      # 
      class JobConfiguration
        include Google::Apis::Core::Hashable
      
        # [Pick one] Copies a table.
        # Corresponds to the JSON property `copy`
        # @return [Google::Apis::BigqueryV2::JobConfigurationTableCopy]
        attr_accessor :copy
      
        # [Optional] If set, don't actually run this job. A valid query will return a
        # mostly empty response with some processing statistics, while an invalid query
        # will return the same error it would if it wasn't a dry run. Behavior of non-
        # query jobs is undefined.
        # Corresponds to the JSON property `dryRun`
        # @return [Boolean]
        attr_accessor :dry_run
        alias_method :dry_run?, :dry_run
      
        # [Pick one] Configures an extract job.
        # Corresponds to the JSON property `extract`
        # @return [Google::Apis::BigqueryV2::JobConfigurationExtract]
        attr_accessor :extract
      
        # [Experimental] The labels associated with this job. You can use these to
        # organize and group your jobs. Label keys and values can be no longer than 63
        # characters, can only contain lowercase letters, numeric characters,
        # underscores and dashes. International characters are allowed. Label values are
        # optional. Label keys must start with a letter and each label in the list must
        # have a different key.
        # Corresponds to the JSON property `labels`
        # @return [Hash<String,String>]
        attr_accessor :labels
      
        # [Pick one] Configures a load job.
        # Corresponds to the JSON property `load`
        # @return [Google::Apis::BigqueryV2::JobConfigurationLoad]
        attr_accessor :load
      
        # [Pick one] Configures a query job.
        # Corresponds to the JSON property `query`
        # @return [Google::Apis::BigqueryV2::JobConfigurationQuery]
        attr_accessor :query
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @copy = args[:copy] if args.key?(:copy)
          @dry_run = args[:dry_run] if args.key?(:dry_run)
          @extract = args[:extract] if args.key?(:extract)
          @labels = args[:labels] if args.key?(:labels)
          @load = args[:load] if args.key?(:load)
          @query = args[:query] if args.key?(:query)
        end
      end
      
      # 
      class JobConfigurationExtract
        include Google::Apis::Core::Hashable
      
        # [Optional] The compression type to use for exported files. Possible values
        # include GZIP and NONE. The default value is NONE.
        # Corresponds to the JSON property `compression`
        # @return [String]
        attr_accessor :compression
      
        # [Optional] The exported file format. Possible values include CSV,
        # NEWLINE_DELIMITED_JSON and AVRO. The default value is CSV. Tables with nested
        # or repeated fields cannot be exported as CSV.
        # Corresponds to the JSON property `destinationFormat`
        # @return [String]
        attr_accessor :destination_format
      
        # [Pick one] DEPRECATED: Use destinationUris instead, passing only one URI as
        # necessary. The fully-qualified Google Cloud Storage URI where the extracted
        # table should be written.
        # Corresponds to the JSON property `destinationUri`
        # @return [String]
        attr_accessor :destination_uri
      
        # [Pick one] A list of fully-qualified Google Cloud Storage URIs where the
        # extracted table should be written.
        # Corresponds to the JSON property `destinationUris`
        # @return [Array<String>]
        attr_accessor :destination_uris
      
        # [Optional] Delimiter to use between fields in the exported data. Default is ','
        # Corresponds to the JSON property `fieldDelimiter`
        # @return [String]
        attr_accessor :field_delimiter
      
        # [Optional] Whether to print out a header row in the results. Default is true.
        # Corresponds to the JSON property `printHeader`
        # @return [Boolean]
        attr_accessor :print_header
        alias_method :print_header?, :print_header
      
        # [Required] A reference to the table being exported.
        # Corresponds to the JSON property `sourceTable`
        # @return [Google::Apis::BigqueryV2::TableReference]
        attr_accessor :source_table
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @compression = args[:compression] if args.key?(:compression)
          @destination_format = args[:destination_format] if args.key?(:destination_format)
          @destination_uri = args[:destination_uri] if args.key?(:destination_uri)
          @destination_uris = args[:destination_uris] if args.key?(:destination_uris)
          @field_delimiter = args[:field_delimiter] if args.key?(:field_delimiter)
          @print_header = args[:print_header] if args.key?(:print_header)
          @source_table = args[:source_table] if args.key?(:source_table)
        end
      end
      
      # 
      class JobConfigurationLoad
        include Google::Apis::Core::Hashable
      
        # [Optional] Accept rows that are missing trailing optional columns. The missing
        # values are treated as nulls. If false, records with missing trailing columns
        # are treated as bad records, and if there are too many bad records, an invalid
        # error is returned in the job result. The default value is false. Only
        # applicable to CSV, ignored for other formats.
        # Corresponds to the JSON property `allowJaggedRows`
        # @return [Boolean]
        attr_accessor :allow_jagged_rows
        alias_method :allow_jagged_rows?, :allow_jagged_rows
      
        # Indicates if BigQuery should allow quoted data sections that contain newline
        # characters in a CSV file. The default value is false.
        # Corresponds to the JSON property `allowQuotedNewlines`
        # @return [Boolean]
        attr_accessor :allow_quoted_newlines
        alias_method :allow_quoted_newlines?, :allow_quoted_newlines
      
        # Indicates if we should automatically infer the options and schema for CSV and
        # JSON sources.
        # Corresponds to the JSON property `autodetect`
        # @return [Boolean]
        attr_accessor :autodetect
        alias_method :autodetect?, :autodetect
      
        # [Optional] Specifies whether the job is allowed to create new tables. The
        # following values are supported: CREATE_IF_NEEDED: If the table does not exist,
        # BigQuery creates the table. CREATE_NEVER: The table must already exist. If it
        # does not, a 'notFound' error is returned in the job result. The default value
        # is CREATE_IF_NEEDED. Creation, truncation and append actions occur as one
        # atomic update upon job completion.
        # Corresponds to the JSON property `createDisposition`
        # @return [String]
        attr_accessor :create_disposition
      
        # [Experimental] Custom encryption configuration (e.g., Cloud KMS keys).
        # Corresponds to the JSON property `destinationEncryptionConfiguration`
        # @return [Google::Apis::BigqueryV2::EncryptionConfiguration]
        attr_accessor :destination_encryption_configuration
      
        # [Required] The destination table to load the data into.
        # Corresponds to the JSON property `destinationTable`
        # @return [Google::Apis::BigqueryV2::TableReference]
        attr_accessor :destination_table
      
        # [Optional] The character encoding of the data. The supported values are UTF-8
        # or ISO-8859-1. The default value is UTF-8. BigQuery decodes the data after the
        # raw, binary data has been split using the values of the quote and
        # fieldDelimiter properties.
        # Corresponds to the JSON property `encoding`
        # @return [String]
        attr_accessor :encoding
      
        # [Optional] The separator for fields in a CSV file. The separator can be any
        # ISO-8859-1 single-byte character. To use a character in the range 128-255, you
        # must encode the character as UTF8. BigQuery converts the string to ISO-8859-1
        # encoding, and then uses the first byte of the encoded string to split the data
        # in its raw, binary state. BigQuery also supports the escape sequence "\t" to
        # specify a tab separator. The default value is a comma (',').
        # Corresponds to the JSON property `fieldDelimiter`
        # @return [String]
        attr_accessor :field_delimiter
      
        # [Optional] Indicates if BigQuery should allow extra values that are not
        # represented in the table schema. If true, the extra values are ignored. If
        # false, records with extra columns are treated as bad records, and if there are
        # too many bad records, an invalid error is returned in the job result. The
        # default value is false. The sourceFormat property determines what BigQuery
        # treats as an extra value: CSV: Trailing columns JSON: Named values that don't
        # match any column names
        # Corresponds to the JSON property `ignoreUnknownValues`
        # @return [Boolean]
        attr_accessor :ignore_unknown_values
        alias_method :ignore_unknown_values?, :ignore_unknown_values
      
        # [Optional] The maximum number of bad records that BigQuery can ignore when
        # running the job. If the number of bad records exceeds this value, an invalid
        # error is returned in the job result. The default value is 0, which requires
        # that all records are valid.
        # Corresponds to the JSON property `maxBadRecords`
        # @return [Fixnum]
        attr_accessor :max_bad_records
      
        # [Optional] Specifies a string that represents a null value in a CSV file. For
        # example, if you specify "\N", BigQuery interprets "\N" as a null value when
        # loading a CSV file. The default value is the empty string. If you set this
        # property to a custom value, BigQuery throws an error if an empty string is
        # present for all data types except for STRING and BYTE. For STRING and BYTE
        # columns, BigQuery interprets the empty string as an empty value.
        # Corresponds to the JSON property `nullMarker`
        # @return [String]
        attr_accessor :null_marker
      
        # If sourceFormat is set to "DATASTORE_BACKUP", indicates which entity
        # properties to load into BigQuery from a Cloud Datastore backup. Property names
        # are case sensitive and must be top-level properties. If no properties are
        # specified, BigQuery loads all properties. If any named property isn't found in
        # the Cloud Datastore backup, an invalid error is returned in the job result.
        # Corresponds to the JSON property `projectionFields`
        # @return [Array<String>]
        attr_accessor :projection_fields
      
        # [Optional] The value that is used to quote data sections in a CSV file.
        # BigQuery converts the string to ISO-8859-1 encoding, and then uses the first
        # byte of the encoded string to split the data in its raw, binary state. The
        # default value is a double-quote ('"'). If your data does not contain quoted
        # sections, set the property value to an empty string. If your data contains
        # quoted newline characters, you must also set the allowQuotedNewlines property
        # to true.
        # Corresponds to the JSON property `quote`
        # @return [String]
        attr_accessor :quote
      
        # [Optional] The schema for the destination table. The schema can be omitted if
        # the destination table already exists, or if you're loading data from Google
        # Cloud Datastore.
        # Corresponds to the JSON property `schema`
        # @return [Google::Apis::BigqueryV2::TableSchema]
        attr_accessor :schema
      
        # [Deprecated] The inline schema. For CSV schemas, specify as "Field1:Type1[,
        # Field2:Type2]*". For example, "foo:STRING, bar:INTEGER, baz:FLOAT".
        # Corresponds to the JSON property `schemaInline`
        # @return [String]
        attr_accessor :schema_inline
      
        # [Deprecated] The format of the schemaInline property.
        # Corresponds to the JSON property `schemaInlineFormat`
        # @return [String]
        attr_accessor :schema_inline_format
      
        # [Experimental] Allows the schema of the desitination table to be updated as a
        # side effect of the load job if a schema is autodetected or supplied in the job
        # configuration. Schema update options are supported in two cases: when
        # writeDisposition is WRITE_APPEND; when writeDisposition is WRITE_TRUNCATE and
        # the destination table is a partition of a table, specified by partition
        # decorators. For normal tables, WRITE_TRUNCATE will always overwrite the schema.
        # One or more of the following values are specified: ALLOW_FIELD_ADDITION:
        # allow adding a nullable field to the schema. ALLOW_FIELD_RELAXATION: allow
        # relaxing a required field in the original schema to nullable.
        # Corresponds to the JSON property `schemaUpdateOptions`
        # @return [Array<String>]
        attr_accessor :schema_update_options
      
        # [Optional] The number of rows at the top of a CSV file that BigQuery will skip
        # when loading the data. The default value is 0. This property is useful if you
        # have header rows in the file that should be skipped.
        # Corresponds to the JSON property `skipLeadingRows`
        # @return [Fixnum]
        attr_accessor :skip_leading_rows
      
        # [Optional] The format of the data files. For CSV files, specify "CSV". For
        # datastore backups, specify "DATASTORE_BACKUP". For newline-delimited JSON,
        # specify "NEWLINE_DELIMITED_JSON". For Avro, specify "AVRO". The default value
        # is CSV.
        # Corresponds to the JSON property `sourceFormat`
        # @return [String]
        attr_accessor :source_format
      
        # [Required] The fully-qualified URIs that point to your data in Google Cloud.
        # For Google Cloud Storage URIs: Each URI can contain one '*' wildcard character
        # and it must come after the 'bucket' name. Size limits related to load jobs
        # apply to external data sources. For Google Cloud Bigtable URIs: Exactly one
        # URI can be specified and it has be a fully specified and valid HTTPS URL for a
        # Google Cloud Bigtable table. For Google Cloud Datastore backups: Exactly one
        # URI can be specified. Also, the '*' wildcard character is not allowed.
        # Corresponds to the JSON property `sourceUris`
        # @return [Array<String>]
        attr_accessor :source_uris
      
        # [Experimental] If specified, configures time-based partitioning for the
        # destination table.
        # Corresponds to the JSON property `timePartitioning`
        # @return [Google::Apis::BigqueryV2::TimePartitioning]
        attr_accessor :time_partitioning
      
        # [Optional] Specifies the action that occurs if the destination table already
        # exists. The following values are supported: WRITE_TRUNCATE: If the table
        # already exists, BigQuery overwrites the table data. WRITE_APPEND: If the table
        # already exists, BigQuery appends the data to the table. WRITE_EMPTY: If the
        # table already exists and contains data, a 'duplicate' error is returned in the
        # job result. The default value is WRITE_APPEND. Each action is atomic and only
        # occurs if BigQuery is able to complete the job successfully. Creation,
        # truncation and append actions occur as one atomic update upon job completion.
        # Corresponds to the JSON property `writeDisposition`
        # @return [String]
        attr_accessor :write_disposition
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @allow_jagged_rows = args[:allow_jagged_rows] if args.key?(:allow_jagged_rows)
          @allow_quoted_newlines = args[:allow_quoted_newlines] if args.key?(:allow_quoted_newlines)
          @autodetect = args[:autodetect] if args.key?(:autodetect)
          @create_disposition = args[:create_disposition] if args.key?(:create_disposition)
          @destination_encryption_configuration = args[:destination_encryption_configuration] if args.key?(:destination_encryption_configuration)
          @destination_table = args[:destination_table] if args.key?(:destination_table)
          @encoding = args[:encoding] if args.key?(:encoding)
          @field_delimiter = args[:field_delimiter] if args.key?(:field_delimiter)
          @ignore_unknown_values = args[:ignore_unknown_values] if args.key?(:ignore_unknown_values)
          @max_bad_records = args[:max_bad_records] if args.key?(:max_bad_records)
          @null_marker = args[:null_marker] if args.key?(:null_marker)
          @projection_fields = args[:projection_fields] if args.key?(:projection_fields)
          @quote = args[:quote] if args.key?(:quote)
          @schema = args[:schema] if args.key?(:schema)
          @schema_inline = args[:schema_inline] if args.key?(:schema_inline)
          @schema_inline_format = args[:schema_inline_format] if args.key?(:schema_inline_format)
          @schema_update_options = args[:schema_update_options] if args.key?(:schema_update_options)
          @skip_leading_rows = args[:skip_leading_rows] if args.key?(:skip_leading_rows)
          @source_format = args[:source_format] if args.key?(:source_format)
          @source_uris = args[:source_uris] if args.key?(:source_uris)
          @time_partitioning = args[:time_partitioning] if args.key?(:time_partitioning)
          @write_disposition = args[:write_disposition] if args.key?(:write_disposition)
        end
      end
      
      # 
      class JobConfigurationQuery
        include Google::Apis::Core::Hashable
      
        # [Optional] If true and query uses legacy SQL dialect, allows the query to
        # produce arbitrarily large result tables at a slight cost in performance.
        # Requires destinationTable to be set. For standard SQL queries, this flag is
        # ignored and large results are always allowed. However, you must still set
        # destinationTable when result size exceeds the allowed maximum response size.
        # Corresponds to the JSON property `allowLargeResults`
        # @return [Boolean]
        attr_accessor :allow_large_results
        alias_method :allow_large_results?, :allow_large_results
      
        # [Optional] Specifies whether the job is allowed to create new tables. The
        # following values are supported: CREATE_IF_NEEDED: If the table does not exist,
        # BigQuery creates the table. CREATE_NEVER: The table must already exist. If it
        # does not, a 'notFound' error is returned in the job result. The default value
        # is CREATE_IF_NEEDED. Creation, truncation and append actions occur as one
        # atomic update upon job completion.
        # Corresponds to the JSON property `createDisposition`
        # @return [String]
        attr_accessor :create_disposition
      
        # [Optional] Specifies the default dataset to use for unqualified table names in
        # the query.
        # Corresponds to the JSON property `defaultDataset`
        # @return [Google::Apis::BigqueryV2::DatasetReference]
        attr_accessor :default_dataset
      
        # [Experimental] Custom encryption configuration (e.g., Cloud KMS keys).
        # Corresponds to the JSON property `destinationEncryptionConfiguration`
        # @return [Google::Apis::BigqueryV2::EncryptionConfiguration]
        attr_accessor :destination_encryption_configuration
      
        # [Optional] Describes the table where the query results should be stored. If
        # not present, a new table will be created to store the results. This property
        # must be set for large results that exceed the maximum response size.
        # Corresponds to the JSON property `destinationTable`
        # @return [Google::Apis::BigqueryV2::TableReference]
        attr_accessor :destination_table
      
        # [Optional] If true and query uses legacy SQL dialect, flattens all nested and
        # repeated fields in the query results. allowLargeResults must be true if this
        # is set to false. For standard SQL queries, this flag is ignored and results
        # are never flattened.
        # Corresponds to the JSON property `flattenResults`
        # @return [Boolean]
        attr_accessor :flatten_results
        alias_method :flatten_results?, :flatten_results
      
        # [Optional] Limits the billing tier for this job. Queries that have resource
        # usage beyond this tier will fail (without incurring a charge). If unspecified,
        # this will be set to your project default.
        # Corresponds to the JSON property `maximumBillingTier`
        # @return [Fixnum]
        attr_accessor :maximum_billing_tier
      
        # [Optional] Limits the bytes billed for this job. Queries that will have bytes
        # billed beyond this limit will fail (without incurring a charge). If
        # unspecified, this will be set to your project default.
        # Corresponds to the JSON property `maximumBytesBilled`
        # @return [Fixnum]
        attr_accessor :maximum_bytes_billed
      
        # Standard SQL only. Set to POSITIONAL to use positional (?) query parameters or
        # to NAMED to use named (@myparam) query parameters in this query.
        # Corresponds to the JSON property `parameterMode`
        # @return [String]
        attr_accessor :parameter_mode
      
        # [Deprecated] This property is deprecated.
        # Corresponds to the JSON property `preserveNulls`
        # @return [Boolean]
        attr_accessor :preserve_nulls
        alias_method :preserve_nulls?, :preserve_nulls
      
        # [Optional] Specifies a priority for the query. Possible values include
        # INTERACTIVE and BATCH. The default value is INTERACTIVE.
        # Corresponds to the JSON property `priority`
        # @return [String]
        attr_accessor :priority
      
        # [Required] SQL query text to execute. The useLegacySql field can be used to
        # indicate whether the query uses legacy SQL or standard SQL.
        # Corresponds to the JSON property `query`
        # @return [String]
        attr_accessor :query
      
        # Query parameters for standard SQL queries.
        # Corresponds to the JSON property `queryParameters`
        # @return [Array<Google::Apis::BigqueryV2::QueryParameter>]
        attr_accessor :query_parameters
      
        # [Experimental] Allows the schema of the destination table to be updated as a
        # side effect of the query job. Schema update options are supported in two cases:
        # when writeDisposition is WRITE_APPEND; when writeDisposition is
        # WRITE_TRUNCATE and the destination table is a partition of a table, specified
        # by partition decorators. For normal tables, WRITE_TRUNCATE will always
        # overwrite the schema. One or more of the following values are specified:
        # ALLOW_FIELD_ADDITION: allow adding a nullable field to the schema.
        # ALLOW_FIELD_RELAXATION: allow relaxing a required field in the original schema
        # to nullable.
        # Corresponds to the JSON property `schemaUpdateOptions`
        # @return [Array<String>]
        attr_accessor :schema_update_options
      
        # [Optional] If querying an external data source outside of BigQuery, describes
        # the data format, location and other properties of the data source. By defining
        # these properties, the data source can then be queried as if it were a standard
        # BigQuery table.
        # Corresponds to the JSON property `tableDefinitions`
        # @return [Hash<String,Google::Apis::BigqueryV2::ExternalDataConfiguration>]
        attr_accessor :table_definitions
      
        # [Experimental] If specified, configures time-based partitioning for the
        # destination table.
        # Corresponds to the JSON property `timePartitioning`
        # @return [Google::Apis::BigqueryV2::TimePartitioning]
        attr_accessor :time_partitioning
      
        # Specifies whether to use BigQuery's legacy SQL dialect for this query. The
        # default value is true. If set to false, the query will use BigQuery's standard
        # SQL: https://cloud.google.com/bigquery/sql-reference/ When useLegacySql is set
        # to false, the value of flattenResults is ignored; query will be run as if
        # flattenResults is false.
        # Corresponds to the JSON property `useLegacySql`
        # @return [Boolean]
        attr_accessor :use_legacy_sql
        alias_method :use_legacy_sql?, :use_legacy_sql
      
        # [Optional] Whether to look for the result in the query cache. The query cache
        # is a best-effort cache that will be flushed whenever tables in the query are
        # modified. Moreover, the query cache is only available when a query does not
        # have a destination table specified. The default value is true.
        # Corresponds to the JSON property `useQueryCache`
        # @return [Boolean]
        attr_accessor :use_query_cache
        alias_method :use_query_cache?, :use_query_cache
      
        # Describes user-defined function resources used in the query.
        # Corresponds to the JSON property `userDefinedFunctionResources`
        # @return [Array<Google::Apis::BigqueryV2::UserDefinedFunctionResource>]
        attr_accessor :user_defined_function_resources
      
        # [Optional] Specifies the action that occurs if the destination table already
        # exists. The following values are supported: WRITE_TRUNCATE: If the table
        # already exists, BigQuery overwrites the table data and uses the schema from
        # the query result. WRITE_APPEND: If the table already exists, BigQuery appends
        # the data to the table. WRITE_EMPTY: If the table already exists and contains
        # data, a 'duplicate' error is returned in the job result. The default value is
        # WRITE_EMPTY. Each action is atomic and only occurs if BigQuery is able to
        # complete the job successfully. Creation, truncation and append actions occur
        # as one atomic update upon job completion.
        # Corresponds to the JSON property `writeDisposition`
        # @return [String]
        attr_accessor :write_disposition
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @allow_large_results = args[:allow_large_results] if args.key?(:allow_large_results)
          @create_disposition = args[:create_disposition] if args.key?(:create_disposition)
          @default_dataset = args[:default_dataset] if args.key?(:default_dataset)
          @destination_encryption_configuration = args[:destination_encryption_configuration] if args.key?(:destination_encryption_configuration)
          @destination_table = args[:destination_table] if args.key?(:destination_table)
          @flatten_results = args[:flatten_results] if args.key?(:flatten_results)
          @maximum_billing_tier = args[:maximum_billing_tier] if args.key?(:maximum_billing_tier)
          @maximum_bytes_billed = args[:maximum_bytes_billed] if args.key?(:maximum_bytes_billed)
          @parameter_mode = args[:parameter_mode] if args.key?(:parameter_mode)
          @preserve_nulls = args[:preserve_nulls] if args.key?(:preserve_nulls)
          @priority = args[:priority] if args.key?(:priority)
          @query = args[:query] if args.key?(:query)
          @query_parameters = args[:query_parameters] if args.key?(:query_parameters)
          @schema_update_options = args[:schema_update_options] if args.key?(:schema_update_options)
          @table_definitions = args[:table_definitions] if args.key?(:table_definitions)
          @time_partitioning = args[:time_partitioning] if args.key?(:time_partitioning)
          @use_legacy_sql = args[:use_legacy_sql] if args.key?(:use_legacy_sql)
          @use_query_cache = args[:use_query_cache] if args.key?(:use_query_cache)
          @user_defined_function_resources = args[:user_defined_function_resources] if args.key?(:user_defined_function_resources)
          @write_disposition = args[:write_disposition] if args.key?(:write_disposition)
        end
      end
      
      # 
      class JobConfigurationTableCopy
        include Google::Apis::Core::Hashable
      
        # [Optional] Specifies whether the job is allowed to create new tables. The
        # following values are supported: CREATE_IF_NEEDED: If the table does not exist,
        # BigQuery creates the table. CREATE_NEVER: The table must already exist. If it
        # does not, a 'notFound' error is returned in the job result. The default value
        # is CREATE_IF_NEEDED. Creation, truncation and append actions occur as one
        # atomic update upon job completion.
        # Corresponds to the JSON property `createDisposition`
        # @return [String]
        attr_accessor :create_disposition
      
        # [Experimental] Custom encryption configuration (e.g., Cloud KMS keys).
        # Corresponds to the JSON property `destinationEncryptionConfiguration`
        # @return [Google::Apis::BigqueryV2::EncryptionConfiguration]
        attr_accessor :destination_encryption_configuration
      
        # [Required] The destination table
        # Corresponds to the JSON property `destinationTable`
        # @return [Google::Apis::BigqueryV2::TableReference]
        attr_accessor :destination_table
      
        # [Pick one] Source table to copy.
        # Corresponds to the JSON property `sourceTable`
        # @return [Google::Apis::BigqueryV2::TableReference]
        attr_accessor :source_table
      
        # [Pick one] Source tables to copy.
        # Corresponds to the JSON property `sourceTables`
        # @return [Array<Google::Apis::BigqueryV2::TableReference>]
        attr_accessor :source_tables
      
        # [Optional] Specifies the action that occurs if the destination table already
        # exists. The following values are supported: WRITE_TRUNCATE: If the table
        # already exists, BigQuery overwrites the table data. WRITE_APPEND: If the table
        # already exists, BigQuery appends the data to the table. WRITE_EMPTY: If the
        # table already exists and contains data, a 'duplicate' error is returned in the
        # job result. The default value is WRITE_EMPTY. Each action is atomic and only
        # occurs if BigQuery is able to complete the job successfully. Creation,
        # truncation and append actions occur as one atomic update upon job completion.
        # Corresponds to the JSON property `writeDisposition`
        # @return [String]
        attr_accessor :write_disposition
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @create_disposition = args[:create_disposition] if args.key?(:create_disposition)
          @destination_encryption_configuration = args[:destination_encryption_configuration] if args.key?(:destination_encryption_configuration)
          @destination_table = args[:destination_table] if args.key?(:destination_table)
          @source_table = args[:source_table] if args.key?(:source_table)
          @source_tables = args[:source_tables] if args.key?(:source_tables)
          @write_disposition = args[:write_disposition] if args.key?(:write_disposition)
        end
      end
      
      # 
      class JobList
        include Google::Apis::Core::Hashable
      
        # A hash of this page of results.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # List of jobs that were requested.
        # Corresponds to the JSON property `jobs`
        # @return [Array<Google::Apis::BigqueryV2::JobList::Job>]
        attr_accessor :jobs
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A token to request the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etag = args[:etag] if args.key?(:etag)
          @jobs = args[:jobs] if args.key?(:jobs)
          @kind = args[:kind] if args.key?(:kind)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
        end
        
        # 
        class Job
          include Google::Apis::Core::Hashable
        
          # [Full-projection-only] Specifies the job configuration.
          # Corresponds to the JSON property `configuration`
          # @return [Google::Apis::BigqueryV2::JobConfiguration]
          attr_accessor :configuration
        
          # A result object that will be present only if the job has failed.
          # Corresponds to the JSON property `errorResult`
          # @return [Google::Apis::BigqueryV2::ErrorProto]
          attr_accessor :error_result
        
          # Unique opaque ID of the job.
          # Corresponds to the JSON property `id`
          # @return [String]
          attr_accessor :id
        
          # Job reference uniquely identifying the job.
          # Corresponds to the JSON property `jobReference`
          # @return [Google::Apis::BigqueryV2::JobReference]
          attr_accessor :job_reference
        
          # The resource type.
          # Corresponds to the JSON property `kind`
          # @return [String]
          attr_accessor :kind
        
          # Running state of the job. When the state is DONE, errorResult can be checked
          # to determine whether the job succeeded or failed.
          # Corresponds to the JSON property `state`
          # @return [String]
          attr_accessor :state
        
          # [Output-only] Information about the job, including starting time and ending
          # time of the job.
          # Corresponds to the JSON property `statistics`
          # @return [Google::Apis::BigqueryV2::JobStatistics]
          attr_accessor :statistics
        
          # [Full-projection-only] Describes the state of the job.
          # Corresponds to the JSON property `status`
          # @return [Google::Apis::BigqueryV2::JobStatus]
          attr_accessor :status
        
          # [Full-projection-only] Email address of the user who ran the job.
          # Corresponds to the JSON property `user_email`
          # @return [String]
          attr_accessor :user_email
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @configuration = args[:configuration] if args.key?(:configuration)
            @error_result = args[:error_result] if args.key?(:error_result)
            @id = args[:id] if args.key?(:id)
            @job_reference = args[:job_reference] if args.key?(:job_reference)
            @kind = args[:kind] if args.key?(:kind)
            @state = args[:state] if args.key?(:state)
            @statistics = args[:statistics] if args.key?(:statistics)
            @status = args[:status] if args.key?(:status)
            @user_email = args[:user_email] if args.key?(:user_email)
          end
        end
      end
      
      # 
      class JobReference
        include Google::Apis::Core::Hashable
      
        # [Required] The ID of the job. The ID must contain only letters (a-z, A-Z),
        # numbers (0-9), underscores (_), or dashes (-). The maximum length is 1,024
        # characters.
        # Corresponds to the JSON property `jobId`
        # @return [String]
        attr_accessor :job_id
      
        # [Required] The ID of the project containing this job.
        # Corresponds to the JSON property `projectId`
        # @return [String]
        attr_accessor :project_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @job_id = args[:job_id] if args.key?(:job_id)
          @project_id = args[:project_id] if args.key?(:project_id)
        end
      end
      
      # 
      class JobStatistics
        include Google::Apis::Core::Hashable
      
        # [Output-only] Creation time of this job, in milliseconds since the epoch. This
        # field will be present on all jobs.
        # Corresponds to the JSON property `creationTime`
        # @return [Fixnum]
        attr_accessor :creation_time
      
        # [Output-only] End time of this job, in milliseconds since the epoch. This
        # field will be present whenever a job is in the DONE state.
        # Corresponds to the JSON property `endTime`
        # @return [Fixnum]
        attr_accessor :end_time
      
        # [Output-only] Statistics for an extract job.
        # Corresponds to the JSON property `extract`
        # @return [Google::Apis::BigqueryV2::JobStatistics4]
        attr_accessor :extract
      
        # [Output-only] Statistics for a load job.
        # Corresponds to the JSON property `load`
        # @return [Google::Apis::BigqueryV2::JobStatistics3]
        attr_accessor :load
      
        # [Output-only] Statistics for a query job.
        # Corresponds to the JSON property `query`
        # @return [Google::Apis::BigqueryV2::JobStatistics2]
        attr_accessor :query
      
        # [Output-only] Start time of this job, in milliseconds since the epoch. This
        # field will be present when the job transitions from the PENDING state to
        # either RUNNING or DONE.
        # Corresponds to the JSON property `startTime`
        # @return [Fixnum]
        attr_accessor :start_time
      
        # [Output-only] [Deprecated] Use the bytes processed in the query statistics
        # instead.
        # Corresponds to the JSON property `totalBytesProcessed`
        # @return [Fixnum]
        attr_accessor :total_bytes_processed
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @creation_time = args[:creation_time] if args.key?(:creation_time)
          @end_time = args[:end_time] if args.key?(:end_time)
          @extract = args[:extract] if args.key?(:extract)
          @load = args[:load] if args.key?(:load)
          @query = args[:query] if args.key?(:query)
          @start_time = args[:start_time] if args.key?(:start_time)
          @total_bytes_processed = args[:total_bytes_processed] if args.key?(:total_bytes_processed)
        end
      end
      
      # 
      class JobStatistics2
        include Google::Apis::Core::Hashable
      
        # [Output-only] Billing tier for the job.
        # Corresponds to the JSON property `billingTier`
        # @return [Fixnum]
        attr_accessor :billing_tier
      
        # [Output-only] Whether the query result was fetched from the query cache.
        # Corresponds to the JSON property `cacheHit`
        # @return [Boolean]
        attr_accessor :cache_hit
        alias_method :cache_hit?, :cache_hit
      
        # [Output-only] The number of rows affected by a DML statement. Present only for
        # DML statements INSERT, UPDATE or DELETE.
        # Corresponds to the JSON property `numDmlAffectedRows`
        # @return [Fixnum]
        attr_accessor :num_dml_affected_rows
      
        # [Output-only] Describes execution plan for the query.
        # Corresponds to the JSON property `queryPlan`
        # @return [Array<Google::Apis::BigqueryV2::ExplainQueryStage>]
        attr_accessor :query_plan
      
        # [Output-only, Experimental] Referenced tables for the job. Queries that
        # reference more than 50 tables will not have a complete list.
        # Corresponds to the JSON property `referencedTables`
        # @return [Array<Google::Apis::BigqueryV2::TableReference>]
        attr_accessor :referenced_tables
      
        # [Output-only, Experimental] The schema of the results. Present only for
        # successful dry run of non-legacy SQL queries.
        # Corresponds to the JSON property `schema`
        # @return [Google::Apis::BigqueryV2::TableSchema]
        attr_accessor :schema
      
        # [Output-only, Experimental] The type of query statement, if valid.
        # Corresponds to the JSON property `statementType`
        # @return [String]
        attr_accessor :statement_type
      
        # [Output-only] Total bytes billed for the job.
        # Corresponds to the JSON property `totalBytesBilled`
        # @return [Fixnum]
        attr_accessor :total_bytes_billed
      
        # [Output-only] Total bytes processed for the job.
        # Corresponds to the JSON property `totalBytesProcessed`
        # @return [Fixnum]
        attr_accessor :total_bytes_processed
      
        # [Output-only, Experimental] Standard SQL only: list of undeclared query
        # parameters detected during a dry run validation.
        # Corresponds to the JSON property `undeclaredQueryParameters`
        # @return [Array<Google::Apis::BigqueryV2::QueryParameter>]
        attr_accessor :undeclared_query_parameters
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @billing_tier = args[:billing_tier] if args.key?(:billing_tier)
          @cache_hit = args[:cache_hit] if args.key?(:cache_hit)
          @num_dml_affected_rows = args[:num_dml_affected_rows] if args.key?(:num_dml_affected_rows)
          @query_plan = args[:query_plan] if args.key?(:query_plan)
          @referenced_tables = args[:referenced_tables] if args.key?(:referenced_tables)
          @schema = args[:schema] if args.key?(:schema)
          @statement_type = args[:statement_type] if args.key?(:statement_type)
          @total_bytes_billed = args[:total_bytes_billed] if args.key?(:total_bytes_billed)
          @total_bytes_processed = args[:total_bytes_processed] if args.key?(:total_bytes_processed)
          @undeclared_query_parameters = args[:undeclared_query_parameters] if args.key?(:undeclared_query_parameters)
        end
      end
      
      # 
      class JobStatistics3
        include Google::Apis::Core::Hashable
      
        # [Output-only] The number of bad records encountered. Note that if the job has
        # failed because of more bad records encountered than the maximum allowed in the
        # load job configuration, then this number can be less than the total number of
        # bad records present in the input data.
        # Corresponds to the JSON property `badRecords`
        # @return [Fixnum]
        attr_accessor :bad_records
      
        # [Output-only] Number of bytes of source data in a load job.
        # Corresponds to the JSON property `inputFileBytes`
        # @return [Fixnum]
        attr_accessor :input_file_bytes
      
        # [Output-only] Number of source files in a load job.
        # Corresponds to the JSON property `inputFiles`
        # @return [Fixnum]
        attr_accessor :input_files
      
        # [Output-only] Size of the loaded data in bytes. Note that while a load job is
        # in the running state, this value may change.
        # Corresponds to the JSON property `outputBytes`
        # @return [Fixnum]
        attr_accessor :output_bytes
      
        # [Output-only] Number of rows imported in a load job. Note that while an import
        # job is in the running state, this value may change.
        # Corresponds to the JSON property `outputRows`
        # @return [Fixnum]
        attr_accessor :output_rows
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bad_records = args[:bad_records] if args.key?(:bad_records)
          @input_file_bytes = args[:input_file_bytes] if args.key?(:input_file_bytes)
          @input_files = args[:input_files] if args.key?(:input_files)
          @output_bytes = args[:output_bytes] if args.key?(:output_bytes)
          @output_rows = args[:output_rows] if args.key?(:output_rows)
        end
      end
      
      # 
      class JobStatistics4
        include Google::Apis::Core::Hashable
      
        # [Output-only] Number of files per destination URI or URI pattern specified in
        # the extract configuration. These values will be in the same order as the URIs
        # specified in the 'destinationUris' field.
        # Corresponds to the JSON property `destinationUriFileCounts`
        # @return [Array<Fixnum>]
        attr_accessor :destination_uri_file_counts
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @destination_uri_file_counts = args[:destination_uri_file_counts] if args.key?(:destination_uri_file_counts)
        end
      end
      
      # 
      class JobStatus
        include Google::Apis::Core::Hashable
      
        # [Output-only] Final error result of the job. If present, indicates that the
        # job has completed and was unsuccessful.
        # Corresponds to the JSON property `errorResult`
        # @return [Google::Apis::BigqueryV2::ErrorProto]
        attr_accessor :error_result
      
        # [Output-only] The first errors encountered during the running of the job. The
        # final message includes the number of errors that caused the process to stop.
        # Errors here do not necessarily mean that the job has completed or was
        # unsuccessful.
        # Corresponds to the JSON property `errors`
        # @return [Array<Google::Apis::BigqueryV2::ErrorProto>]
        attr_accessor :errors
      
        # [Output-only] Running state of the job.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @error_result = args[:error_result] if args.key?(:error_result)
          @errors = args[:errors] if args.key?(:errors)
          @state = args[:state] if args.key?(:state)
        end
      end
      
      # 
      class ProjectList
        include Google::Apis::Core::Hashable
      
        # A hash of the page of results
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The type of list.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A token to request the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # Projects to which you have at least READ access.
        # Corresponds to the JSON property `projects`
        # @return [Array<Google::Apis::BigqueryV2::ProjectList::Project>]
        attr_accessor :projects
      
        # The total number of projects in the list.
        # Corresponds to the JSON property `totalItems`
        # @return [Fixnum]
        attr_accessor :total_items
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etag = args[:etag] if args.key?(:etag)
          @kind = args[:kind] if args.key?(:kind)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @projects = args[:projects] if args.key?(:projects)
          @total_items = args[:total_items] if args.key?(:total_items)
        end
        
        # 
        class Project
          include Google::Apis::Core::Hashable
        
          # A descriptive name for this project.
          # Corresponds to the JSON property `friendlyName`
          # @return [String]
          attr_accessor :friendly_name
        
          # An opaque ID of this project.
          # Corresponds to the JSON property `id`
          # @return [String]
          attr_accessor :id
        
          # The resource type.
          # Corresponds to the JSON property `kind`
          # @return [String]
          attr_accessor :kind
        
          # The numeric ID of this project.
          # Corresponds to the JSON property `numericId`
          # @return [Fixnum]
          attr_accessor :numeric_id
        
          # A unique reference to this project.
          # Corresponds to the JSON property `projectReference`
          # @return [Google::Apis::BigqueryV2::ProjectReference]
          attr_accessor :project_reference
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @friendly_name = args[:friendly_name] if args.key?(:friendly_name)
            @id = args[:id] if args.key?(:id)
            @kind = args[:kind] if args.key?(:kind)
            @numeric_id = args[:numeric_id] if args.key?(:numeric_id)
            @project_reference = args[:project_reference] if args.key?(:project_reference)
          end
        end
      end
      
      # 
      class ProjectReference
        include Google::Apis::Core::Hashable
      
        # [Required] ID of the project. Can be either the numeric ID or the assigned ID
        # of the project.
        # Corresponds to the JSON property `projectId`
        # @return [String]
        attr_accessor :project_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @project_id = args[:project_id] if args.key?(:project_id)
        end
      end
      
      # 
      class QueryParameter
        include Google::Apis::Core::Hashable
      
        # [Optional] If unset, this is a positional parameter. Otherwise, should be
        # unique within a query.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # [Required] The type of this parameter.
        # Corresponds to the JSON property `parameterType`
        # @return [Google::Apis::BigqueryV2::QueryParameterType]
        attr_accessor :parameter_type
      
        # [Required] The value of this parameter.
        # Corresponds to the JSON property `parameterValue`
        # @return [Google::Apis::BigqueryV2::QueryParameterValue]
        attr_accessor :parameter_value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @name = args[:name] if args.key?(:name)
          @parameter_type = args[:parameter_type] if args.key?(:parameter_type)
          @parameter_value = args[:parameter_value] if args.key?(:parameter_value)
        end
      end
      
      # 
      class QueryParameterType
        include Google::Apis::Core::Hashable
      
        # [Optional] The type of the array's elements, if this is an array.
        # Corresponds to the JSON property `arrayType`
        # @return [Google::Apis::BigqueryV2::QueryParameterType]
        attr_accessor :array_type
      
        # [Optional] The types of the fields of this struct, in order, if this is a
        # struct.
        # Corresponds to the JSON property `structTypes`
        # @return [Array<Google::Apis::BigqueryV2::QueryParameterType::StructType>]
        attr_accessor :struct_types
      
        # [Required] The top level type of this field.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @array_type = args[:array_type] if args.key?(:array_type)
          @struct_types = args[:struct_types] if args.key?(:struct_types)
          @type = args[:type] if args.key?(:type)
        end
        
        # 
        class StructType
          include Google::Apis::Core::Hashable
        
          # [Optional] Human-oriented description of the field.
          # Corresponds to the JSON property `description`
          # @return [String]
          attr_accessor :description
        
          # [Optional] The name of this field.
          # Corresponds to the JSON property `name`
          # @return [String]
          attr_accessor :name
        
          # [Required] The type of this field.
          # Corresponds to the JSON property `type`
          # @return [Google::Apis::BigqueryV2::QueryParameterType]
          attr_accessor :type
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @description = args[:description] if args.key?(:description)
            @name = args[:name] if args.key?(:name)
            @type = args[:type] if args.key?(:type)
          end
        end
      end
      
      # 
      class QueryParameterValue
        include Google::Apis::Core::Hashable
      
        # [Optional] The array values, if this is an array type.
        # Corresponds to the JSON property `arrayValues`
        # @return [Array<Google::Apis::BigqueryV2::QueryParameterValue>]
        attr_accessor :array_values
      
        # [Optional] The struct field values, in order of the struct type's declaration.
        # Corresponds to the JSON property `structValues`
        # @return [Hash<String,Google::Apis::BigqueryV2::QueryParameterValue>]
        attr_accessor :struct_values
      
        # [Optional] The value of this value, if a simple scalar type.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @array_values = args[:array_values] if args.key?(:array_values)
          @struct_values = args[:struct_values] if args.key?(:struct_values)
          @value = args[:value] if args.key?(:value)
        end
      end
      
      # 
      class QueryRequest
        include Google::Apis::Core::Hashable
      
        # [Optional] Specifies the default datasetId and projectId to assume for any
        # unqualified table names in the query. If not set, all table names in the query
        # string must be qualified in the format 'datasetId.tableId'.
        # Corresponds to the JSON property `defaultDataset`
        # @return [Google::Apis::BigqueryV2::DatasetReference]
        attr_accessor :default_dataset
      
        # [Optional] If set to true, BigQuery doesn't run the job. Instead, if the query
        # is valid, BigQuery returns statistics about the job such as how many bytes
        # would be processed. If the query is invalid, an error returns. The default
        # value is false.
        # Corresponds to the JSON property `dryRun`
        # @return [Boolean]
        attr_accessor :dry_run
        alias_method :dry_run?, :dry_run
      
        # The resource type of the request.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # [Optional] The maximum number of rows of data to return per page of results.
        # Setting this flag to a small value such as 1000 and then paging through
        # results might improve reliability when the query result set is large. In
        # addition to this limit, responses are also limited to 10 MB. By default, there
        # is no maximum row count, and only the byte limit applies.
        # Corresponds to the JSON property `maxResults`
        # @return [Fixnum]
        attr_accessor :max_results
      
        # Standard SQL only. Set to POSITIONAL to use positional (?) query parameters or
        # to NAMED to use named (@myparam) query parameters in this query.
        # Corresponds to the JSON property `parameterMode`
        # @return [String]
        attr_accessor :parameter_mode
      
        # [Deprecated] This property is deprecated.
        # Corresponds to the JSON property `preserveNulls`
        # @return [Boolean]
        attr_accessor :preserve_nulls
        alias_method :preserve_nulls?, :preserve_nulls
      
        # [Required] A query string, following the BigQuery query syntax, of the query
        # to execute. Example: "SELECT count(f1) FROM [myProjectId:myDatasetId.myTableId]
        # ".
        # Corresponds to the JSON property `query`
        # @return [String]
        attr_accessor :query
      
        # Query parameters for Standard SQL queries.
        # Corresponds to the JSON property `queryParameters`
        # @return [Array<Google::Apis::BigqueryV2::QueryParameter>]
        attr_accessor :query_parameters
      
        # [Optional] How long to wait for the query to complete, in milliseconds, before
        # the request times out and returns. Note that this is only a timeout for the
        # request, not the query. If the query takes longer to run than the timeout
        # value, the call returns without any results and with the 'jobComplete' flag
        # set to false. You can call GetQueryResults() to wait for the query to complete
        # and read the results. The default value is 10000 milliseconds (10 seconds).
        # Corresponds to the JSON property `timeoutMs`
        # @return [Fixnum]
        attr_accessor :timeout_ms
      
        # Specifies whether to use BigQuery's legacy SQL dialect for this query. The
        # default value is true. If set to false, the query will use BigQuery's standard
        # SQL: https://cloud.google.com/bigquery/sql-reference/ When useLegacySql is set
        # to false, the value of flattenResults is ignored; query will be run as if
        # flattenResults is false.
        # Corresponds to the JSON property `useLegacySql`
        # @return [Boolean]
        attr_accessor :use_legacy_sql
        alias_method :use_legacy_sql?, :use_legacy_sql
      
        # [Optional] Whether to look for the result in the query cache. The query cache
        # is a best-effort cache that will be flushed whenever tables in the query are
        # modified. The default value is true.
        # Corresponds to the JSON property `useQueryCache`
        # @return [Boolean]
        attr_accessor :use_query_cache
        alias_method :use_query_cache?, :use_query_cache
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @default_dataset = args[:default_dataset] if args.key?(:default_dataset)
          @dry_run = args[:dry_run] if args.key?(:dry_run)
          @kind = args[:kind] if args.key?(:kind)
          @max_results = args[:max_results] if args.key?(:max_results)
          @parameter_mode = args[:parameter_mode] if args.key?(:parameter_mode)
          @preserve_nulls = args[:preserve_nulls] if args.key?(:preserve_nulls)
          @query = args[:query] if args.key?(:query)
          @query_parameters = args[:query_parameters] if args.key?(:query_parameters)
          @timeout_ms = args[:timeout_ms] if args.key?(:timeout_ms)
          @use_legacy_sql = args[:use_legacy_sql] if args.key?(:use_legacy_sql)
          @use_query_cache = args[:use_query_cache] if args.key?(:use_query_cache)
        end
      end
      
      # 
      class QueryResponse
        include Google::Apis::Core::Hashable
      
        # Whether the query result was fetched from the query cache.
        # Corresponds to the JSON property `cacheHit`
        # @return [Boolean]
        attr_accessor :cache_hit
        alias_method :cache_hit?, :cache_hit
      
        # [Output-only] The first errors or warnings encountered during the running of
        # the job. The final message includes the number of errors that caused the
        # process to stop. Errors here do not necessarily mean that the job has
        # completed or was unsuccessful.
        # Corresponds to the JSON property `errors`
        # @return [Array<Google::Apis::BigqueryV2::ErrorProto>]
        attr_accessor :errors
      
        # Whether the query has completed or not. If rows or totalRows are present, this
        # will always be true. If this is false, totalRows will not be available.
        # Corresponds to the JSON property `jobComplete`
        # @return [Boolean]
        attr_accessor :job_complete
        alias_method :job_complete?, :job_complete
      
        # Reference to the Job that was created to run the query. This field will be
        # present even if the original request timed out, in which case GetQueryResults
        # can be used to read the results once the query has completed. Since this API
        # only returns the first page of results, subsequent pages can be fetched via
        # the same mechanism (GetQueryResults).
        # Corresponds to the JSON property `jobReference`
        # @return [Google::Apis::BigqueryV2::JobReference]
        attr_accessor :job_reference
      
        # The resource type.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # [Output-only] The number of rows affected by a DML statement. Present only for
        # DML statements INSERT, UPDATE or DELETE.
        # Corresponds to the JSON property `numDmlAffectedRows`
        # @return [Fixnum]
        attr_accessor :num_dml_affected_rows
      
        # A token used for paging results.
        # Corresponds to the JSON property `pageToken`
        # @return [String]
        attr_accessor :page_token
      
        # An object with as many results as can be contained within the maximum
        # permitted reply size. To get any additional rows, you can call GetQueryResults
        # and specify the jobReference returned above.
        # Corresponds to the JSON property `rows`
        # @return [Array<Google::Apis::BigqueryV2::TableRow>]
        attr_accessor :rows
      
        # The schema of the results. Present only when the query completes successfully.
        # Corresponds to the JSON property `schema`
        # @return [Google::Apis::BigqueryV2::TableSchema]
        attr_accessor :schema
      
        # The total number of bytes processed for this query. If this query was a dry
        # run, this is the number of bytes that would be processed if the query were run.
        # Corresponds to the JSON property `totalBytesProcessed`
        # @return [Fixnum]
        attr_accessor :total_bytes_processed
      
        # The total number of rows in the complete query result set, which can be more
        # than the number of rows in this single page of results.
        # Corresponds to the JSON property `totalRows`
        # @return [Fixnum]
        attr_accessor :total_rows
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cache_hit = args[:cache_hit] if args.key?(:cache_hit)
          @errors = args[:errors] if args.key?(:errors)
          @job_complete = args[:job_complete] if args.key?(:job_complete)
          @job_reference = args[:job_reference] if args.key?(:job_reference)
          @kind = args[:kind] if args.key?(:kind)
          @num_dml_affected_rows = args[:num_dml_affected_rows] if args.key?(:num_dml_affected_rows)
          @page_token = args[:page_token] if args.key?(:page_token)
          @rows = args[:rows] if args.key?(:rows)
          @schema = args[:schema] if args.key?(:schema)
          @total_bytes_processed = args[:total_bytes_processed] if args.key?(:total_bytes_processed)
          @total_rows = args[:total_rows] if args.key?(:total_rows)
        end
      end
      
      # 
      class Streamingbuffer
        include Google::Apis::Core::Hashable
      
        # [Output-only] A lower-bound estimate of the number of bytes currently in the
        # streaming buffer.
        # Corresponds to the JSON property `estimatedBytes`
        # @return [Fixnum]
        attr_accessor :estimated_bytes
      
        # [Output-only] A lower-bound estimate of the number of rows currently in the
        # streaming buffer.
        # Corresponds to the JSON property `estimatedRows`
        # @return [Fixnum]
        attr_accessor :estimated_rows
      
        # [Output-only] Contains the timestamp of the oldest entry in the streaming
        # buffer, in milliseconds since the epoch, if the streaming buffer is available.
        # Corresponds to the JSON property `oldestEntryTime`
        # @return [Fixnum]
        attr_accessor :oldest_entry_time
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @estimated_bytes = args[:estimated_bytes] if args.key?(:estimated_bytes)
          @estimated_rows = args[:estimated_rows] if args.key?(:estimated_rows)
          @oldest_entry_time = args[:oldest_entry_time] if args.key?(:oldest_entry_time)
        end
      end
      
      # 
      class Table
        include Google::Apis::Core::Hashable
      
        # [Output-only] The time when this table was created, in milliseconds since the
        # epoch.
        # Corresponds to the JSON property `creationTime`
        # @return [Fixnum]
        attr_accessor :creation_time
      
        # [Optional] A user-friendly description of this table.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # [Experimental] Custom encryption configuration (e.g., Cloud KMS keys).
        # Corresponds to the JSON property `encryptionConfiguration`
        # @return [Google::Apis::BigqueryV2::EncryptionConfiguration]
        attr_accessor :encryption_configuration
      
        # [Output-only] A hash of this resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # [Optional] The time when this table expires, in milliseconds since the epoch.
        # If not present, the table will persist indefinitely. Expired tables will be
        # deleted and their storage reclaimed.
        # Corresponds to the JSON property `expirationTime`
        # @return [Fixnum]
        attr_accessor :expiration_time
      
        # [Optional] Describes the data format, location, and other properties of a
        # table stored outside of BigQuery. By defining these properties, the data
        # source can then be queried as if it were a standard BigQuery table.
        # Corresponds to the JSON property `externalDataConfiguration`
        # @return [Google::Apis::BigqueryV2::ExternalDataConfiguration]
        attr_accessor :external_data_configuration
      
        # [Optional] A descriptive name for this table.
        # Corresponds to the JSON property `friendlyName`
        # @return [String]
        attr_accessor :friendly_name
      
        # [Output-only] An opaque ID uniquely identifying the table.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # [Output-only] The type of the resource.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # [Experimental] The labels associated with this table. You can use these to
        # organize and group your tables. Label keys and values can be no longer than 63
        # characters, can only contain lowercase letters, numeric characters,
        # underscores and dashes. International characters are allowed. Label values are
        # optional. Label keys must start with a letter and each label in the list must
        # have a different key.
        # Corresponds to the JSON property `labels`
        # @return [Hash<String,String>]
        attr_accessor :labels
      
        # [Output-only] The time when this table was last modified, in milliseconds
        # since the epoch.
        # Corresponds to the JSON property `lastModifiedTime`
        # @return [Fixnum]
        attr_accessor :last_modified_time
      
        # [Output-only] The geographic location where the table resides. This value is
        # inherited from the dataset.
        # Corresponds to the JSON property `location`
        # @return [String]
        attr_accessor :location
      
        # [Output-only] The size of this table in bytes, excluding any data in the
        # streaming buffer.
        # Corresponds to the JSON property `numBytes`
        # @return [Fixnum]
        attr_accessor :num_bytes
      
        # [Output-only] The number of bytes in the table that are considered "long-term
        # storage".
        # Corresponds to the JSON property `numLongTermBytes`
        # @return [Fixnum]
        attr_accessor :num_long_term_bytes
      
        # [Output-only] The number of rows of data in this table, excluding any data in
        # the streaming buffer.
        # Corresponds to the JSON property `numRows`
        # @return [Fixnum]
        attr_accessor :num_rows
      
        # [Optional] Describes the schema of this table.
        # Corresponds to the JSON property `schema`
        # @return [Google::Apis::BigqueryV2::TableSchema]
        attr_accessor :schema
      
        # [Output-only] A URL that can be used to access this resource again.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # [Output-only] Contains information regarding this table's streaming buffer, if
        # one is present. This field will be absent if the table is not being streamed
        # to or if there is no data in the streaming buffer.
        # Corresponds to the JSON property `streamingBuffer`
        # @return [Google::Apis::BigqueryV2::Streamingbuffer]
        attr_accessor :streaming_buffer
      
        # [Required] Reference describing the ID of this table.
        # Corresponds to the JSON property `tableReference`
        # @return [Google::Apis::BigqueryV2::TableReference]
        attr_accessor :table_reference
      
        # [Experimental] If specified, configures time-based partitioning for this table.
        # Corresponds to the JSON property `timePartitioning`
        # @return [Google::Apis::BigqueryV2::TimePartitioning]
        attr_accessor :time_partitioning
      
        # [Output-only] Describes the table type. The following values are supported:
        # TABLE: A normal BigQuery table. VIEW: A virtual table defined by a SQL query.
        # EXTERNAL: A table that references data stored in an external storage system,
        # such as Google Cloud Storage. The default value is TABLE.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        # [Optional] The view definition.
        # Corresponds to the JSON property `view`
        # @return [Google::Apis::BigqueryV2::ViewDefinition]
        attr_accessor :view
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @creation_time = args[:creation_time] if args.key?(:creation_time)
          @description = args[:description] if args.key?(:description)
          @encryption_configuration = args[:encryption_configuration] if args.key?(:encryption_configuration)
          @etag = args[:etag] if args.key?(:etag)
          @expiration_time = args[:expiration_time] if args.key?(:expiration_time)
          @external_data_configuration = args[:external_data_configuration] if args.key?(:external_data_configuration)
          @friendly_name = args[:friendly_name] if args.key?(:friendly_name)
          @id = args[:id] if args.key?(:id)
          @kind = args[:kind] if args.key?(:kind)
          @labels = args[:labels] if args.key?(:labels)
          @last_modified_time = args[:last_modified_time] if args.key?(:last_modified_time)
          @location = args[:location] if args.key?(:location)
          @num_bytes = args[:num_bytes] if args.key?(:num_bytes)
          @num_long_term_bytes = args[:num_long_term_bytes] if args.key?(:num_long_term_bytes)
          @num_rows = args[:num_rows] if args.key?(:num_rows)
          @schema = args[:schema] if args.key?(:schema)
          @self_link = args[:self_link] if args.key?(:self_link)
          @streaming_buffer = args[:streaming_buffer] if args.key?(:streaming_buffer)
          @table_reference = args[:table_reference] if args.key?(:table_reference)
          @time_partitioning = args[:time_partitioning] if args.key?(:time_partitioning)
          @type = args[:type] if args.key?(:type)
          @view = args[:view] if args.key?(:view)
        end
      end
      
      # 
      class TableCell
        include Google::Apis::Core::Hashable
      
        # 
        # Corresponds to the JSON property `v`
        # @return [Object]
        attr_accessor :v
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @v = args[:v] if args.key?(:v)
        end
      end
      
      # 
      class InsertAllTableDataRequest
        include Google::Apis::Core::Hashable
      
        # [Optional] Accept rows that contain values that do not match the schema. The
        # unknown values are ignored. Default is false, which treats unknown values as
        # errors.
        # Corresponds to the JSON property `ignoreUnknownValues`
        # @return [Boolean]
        attr_accessor :ignore_unknown_values
        alias_method :ignore_unknown_values?, :ignore_unknown_values
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The rows to insert.
        # Corresponds to the JSON property `rows`
        # @return [Array<Google::Apis::BigqueryV2::InsertAllTableDataRequest::Row>]
        attr_accessor :rows
      
        # [Optional] Insert all valid rows of a request, even if invalid rows exist. The
        # default value is false, which causes the entire request to fail if any invalid
        # rows exist.
        # Corresponds to the JSON property `skipInvalidRows`
        # @return [Boolean]
        attr_accessor :skip_invalid_rows
        alias_method :skip_invalid_rows?, :skip_invalid_rows
      
        # [Experimental] If specified, treats the destination table as a base template,
        # and inserts the rows into an instance table named "`destination``
        # templateSuffix`". BigQuery will manage creation of the instance table, using
        # the schema of the base template table. See https://cloud.google.com/bigquery/
        # streaming-data-into-bigquery#template-tables for considerations when working
        # with templates tables.
        # Corresponds to the JSON property `templateSuffix`
        # @return [String]
        attr_accessor :template_suffix
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @ignore_unknown_values = args[:ignore_unknown_values] if args.key?(:ignore_unknown_values)
          @kind = args[:kind] if args.key?(:kind)
          @rows = args[:rows] if args.key?(:rows)
          @skip_invalid_rows = args[:skip_invalid_rows] if args.key?(:skip_invalid_rows)
          @template_suffix = args[:template_suffix] if args.key?(:template_suffix)
        end
        
        # 
        class Row
          include Google::Apis::Core::Hashable
        
          # [Optional] A unique ID for each row. BigQuery uses this property to detect
          # duplicate insertion requests on a best-effort basis.
          # Corresponds to the JSON property `insertId`
          # @return [String]
          attr_accessor :insert_id
        
          # Represents a single JSON object.
          # Corresponds to the JSON property `json`
          # @return [Hash<String,Object>]
          attr_accessor :json
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @insert_id = args[:insert_id] if args.key?(:insert_id)
            @json = args[:json] if args.key?(:json)
          end
        end
      end
      
      # 
      class InsertAllTableDataResponse
        include Google::Apis::Core::Hashable
      
        # An array of errors for rows that were not inserted.
        # Corresponds to the JSON property `insertErrors`
        # @return [Array<Google::Apis::BigqueryV2::InsertAllTableDataResponse::InsertError>]
        attr_accessor :insert_errors
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @insert_errors = args[:insert_errors] if args.key?(:insert_errors)
          @kind = args[:kind] if args.key?(:kind)
        end
        
        # 
        class InsertError
          include Google::Apis::Core::Hashable
        
          # Error information for the row indicated by the index property.
          # Corresponds to the JSON property `errors`
          # @return [Array<Google::Apis::BigqueryV2::ErrorProto>]
          attr_accessor :errors
        
          # The index of the row that error applies to.
          # Corresponds to the JSON property `index`
          # @return [Fixnum]
          attr_accessor :index
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @errors = args[:errors] if args.key?(:errors)
            @index = args[:index] if args.key?(:index)
          end
        end
      end
      
      # 
      class TableDataList
        include Google::Apis::Core::Hashable
      
        # A hash of this page of results.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The resource type of the response.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A token used for paging results. Providing this token instead of the
        # startIndex parameter can help you retrieve stable results when an underlying
        # table is changing.
        # Corresponds to the JSON property `pageToken`
        # @return [String]
        attr_accessor :page_token
      
        # Rows of results.
        # Corresponds to the JSON property `rows`
        # @return [Array<Google::Apis::BigqueryV2::TableRow>]
        attr_accessor :rows
      
        # The total number of rows in the complete table.
        # Corresponds to the JSON property `totalRows`
        # @return [Fixnum]
        attr_accessor :total_rows
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etag = args[:etag] if args.key?(:etag)
          @kind = args[:kind] if args.key?(:kind)
          @page_token = args[:page_token] if args.key?(:page_token)
          @rows = args[:rows] if args.key?(:rows)
          @total_rows = args[:total_rows] if args.key?(:total_rows)
        end
      end
      
      # 
      class TableFieldSchema
        include Google::Apis::Core::Hashable
      
        # [Optional] The field description. The maximum length is 1,024 characters.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # [Optional] Describes the nested schema fields if the type property is set to
        # RECORD.
        # Corresponds to the JSON property `fields`
        # @return [Array<Google::Apis::BigqueryV2::TableFieldSchema>]
        attr_accessor :fields
      
        # [Optional] The field mode. Possible values include NULLABLE, REQUIRED and
        # REPEATED. The default value is NULLABLE.
        # Corresponds to the JSON property `mode`
        # @return [String]
        attr_accessor :mode
      
        # [Required] The field name. The name must contain only letters (a-z, A-Z),
        # numbers (0-9), or underscores (_), and must start with a letter or underscore.
        # The maximum length is 128 characters.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # [Required] The field data type. Possible values include STRING, BYTES, INTEGER,
        # INT64 (same as INTEGER), FLOAT, FLOAT64 (same as FLOAT), BOOLEAN, BOOL (same
        # as BOOLEAN), TIMESTAMP, DATE, TIME, DATETIME, RECORD (where RECORD indicates
        # that the field contains a nested schema) or STRUCT (same as RECORD).
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @description = args[:description] if args.key?(:description)
          @fields = args[:fields] if args.key?(:fields)
          @mode = args[:mode] if args.key?(:mode)
          @name = args[:name] if args.key?(:name)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # 
      class TableList
        include Google::Apis::Core::Hashable
      
        # A hash of this page of results.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The type of list.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A token to request the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        # Tables in the requested dataset.
        # Corresponds to the JSON property `tables`
        # @return [Array<Google::Apis::BigqueryV2::TableList::Table>]
        attr_accessor :tables
      
        # The total number of tables in the dataset.
        # Corresponds to the JSON property `totalItems`
        # @return [Fixnum]
        attr_accessor :total_items
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etag = args[:etag] if args.key?(:etag)
          @kind = args[:kind] if args.key?(:kind)
          @next_page_token = args[:next_page_token] if args.key?(:next_page_token)
          @tables = args[:tables] if args.key?(:tables)
          @total_items = args[:total_items] if args.key?(:total_items)
        end
        
        # 
        class Table
          include Google::Apis::Core::Hashable
        
          # The user-friendly name for this table.
          # Corresponds to the JSON property `friendlyName`
          # @return [String]
          attr_accessor :friendly_name
        
          # An opaque ID of the table
          # Corresponds to the JSON property `id`
          # @return [String]
          attr_accessor :id
        
          # The resource type.
          # Corresponds to the JSON property `kind`
          # @return [String]
          attr_accessor :kind
        
          # [Experimental] The labels associated with this table. You can use these to
          # organize and group your tables.
          # Corresponds to the JSON property `labels`
          # @return [Hash<String,String>]
          attr_accessor :labels
        
          # A reference uniquely identifying the table.
          # Corresponds to the JSON property `tableReference`
          # @return [Google::Apis::BigqueryV2::TableReference]
          attr_accessor :table_reference
        
          # [Experimental] The time-based partitioning for this table.
          # Corresponds to the JSON property `timePartitioning`
          # @return [Google::Apis::BigqueryV2::TimePartitioning]
          attr_accessor :time_partitioning
        
          # The type of table. Possible values are: TABLE, VIEW.
          # Corresponds to the JSON property `type`
          # @return [String]
          attr_accessor :type
        
          # Additional details for a view.
          # Corresponds to the JSON property `view`
          # @return [Google::Apis::BigqueryV2::TableList::Table::View]
          attr_accessor :view
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @friendly_name = args[:friendly_name] if args.key?(:friendly_name)
            @id = args[:id] if args.key?(:id)
            @kind = args[:kind] if args.key?(:kind)
            @labels = args[:labels] if args.key?(:labels)
            @table_reference = args[:table_reference] if args.key?(:table_reference)
            @time_partitioning = args[:time_partitioning] if args.key?(:time_partitioning)
            @type = args[:type] if args.key?(:type)
            @view = args[:view] if args.key?(:view)
          end
          
          # Additional details for a view.
          class View
            include Google::Apis::Core::Hashable
          
            # True if view is defined in legacy SQL dialect, false if in standard SQL.
            # Corresponds to the JSON property `useLegacySql`
            # @return [Boolean]
            attr_accessor :use_legacy_sql
            alias_method :use_legacy_sql?, :use_legacy_sql
          
            def initialize(**args)
               update!(**args)
            end
          
            # Update properties of this object
            def update!(**args)
              @use_legacy_sql = args[:use_legacy_sql] if args.key?(:use_legacy_sql)
            end
          end
        end
      end
      
      # 
      class TableReference
        include Google::Apis::Core::Hashable
      
        # [Required] The ID of the dataset containing this table.
        # Corresponds to the JSON property `datasetId`
        # @return [String]
        attr_accessor :dataset_id
      
        # [Required] The ID of the project containing this table.
        # Corresponds to the JSON property `projectId`
        # @return [String]
        attr_accessor :project_id
      
        # [Required] The ID of the table. The ID must contain only letters (a-z, A-Z),
        # numbers (0-9), or underscores (_). The maximum length is 1,024 characters.
        # Corresponds to the JSON property `tableId`
        # @return [String]
        attr_accessor :table_id
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @dataset_id = args[:dataset_id] if args.key?(:dataset_id)
          @project_id = args[:project_id] if args.key?(:project_id)
          @table_id = args[:table_id] if args.key?(:table_id)
        end
      end
      
      # 
      class TableRow
        include Google::Apis::Core::Hashable
      
        # Represents a single row in the result set, consisting of one or more fields.
        # Corresponds to the JSON property `f`
        # @return [Array<Google::Apis::BigqueryV2::TableCell>]
        attr_accessor :f
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @f = args[:f] if args.key?(:f)
        end
      end
      
      # 
      class TableSchema
        include Google::Apis::Core::Hashable
      
        # Describes the fields in a table.
        # Corresponds to the JSON property `fields`
        # @return [Array<Google::Apis::BigqueryV2::TableFieldSchema>]
        attr_accessor :fields
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @fields = args[:fields] if args.key?(:fields)
        end
      end
      
      # 
      class TimePartitioning
        include Google::Apis::Core::Hashable
      
        # [Optional] Number of milliseconds for which to keep the storage for a
        # partition.
        # Corresponds to the JSON property `expirationMs`
        # @return [Fixnum]
        attr_accessor :expiration_ms
      
        # [Experimental] [Optional] If not set, the table is partitioned by pseudo
        # column '_PARTITIONTIME'; if set, the table is partitioned by this field. The
        # field must be a top-level TIMESTAMP or DATE field. Its mode must be NULLABLE
        # or REQUIRED.
        # Corresponds to the JSON property `field`
        # @return [String]
        attr_accessor :field
      
        # [Required] The only type supported is DAY, which will generate one partition
        # per day.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @expiration_ms = args[:expiration_ms] if args.key?(:expiration_ms)
          @field = args[:field] if args.key?(:field)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # 
      class UserDefinedFunctionResource
        include Google::Apis::Core::Hashable
      
        # [Pick one] An inline resource that contains code for a user-defined function (
        # UDF). Providing a inline code resource is equivalent to providing a URI for a
        # file containing the same code.
        # Corresponds to the JSON property `inlineCode`
        # @return [String]
        attr_accessor :inline_code
      
        # [Pick one] A code resource to load from a Google Cloud Storage URI (gs://
        # bucket/path).
        # Corresponds to the JSON property `resourceUri`
        # @return [String]
        attr_accessor :resource_uri
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @inline_code = args[:inline_code] if args.key?(:inline_code)
          @resource_uri = args[:resource_uri] if args.key?(:resource_uri)
        end
      end
      
      # 
      class ViewDefinition
        include Google::Apis::Core::Hashable
      
        # [Required] A query that BigQuery executes when the view is referenced.
        # Corresponds to the JSON property `query`
        # @return [String]
        attr_accessor :query
      
        # Specifies whether to use BigQuery's legacy SQL for this view. The default
        # value is true. If set to false, the view will use BigQuery's standard SQL:
        # https://cloud.google.com/bigquery/sql-reference/ Queries and views that
        # reference this view must use the same flag value.
        # Corresponds to the JSON property `useLegacySql`
        # @return [Boolean]
        attr_accessor :use_legacy_sql
        alias_method :use_legacy_sql?, :use_legacy_sql
      
        # Describes user-defined function resources used in the query.
        # Corresponds to the JSON property `userDefinedFunctionResources`
        # @return [Array<Google::Apis::BigqueryV2::UserDefinedFunctionResource>]
        attr_accessor :user_defined_function_resources
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @query = args[:query] if args.key?(:query)
          @use_legacy_sql = args[:use_legacy_sql] if args.key?(:use_legacy_sql)
          @user_defined_function_resources = args[:user_defined_function_resources] if args.key?(:user_defined_function_resources)
        end
      end
    end
  end
end
