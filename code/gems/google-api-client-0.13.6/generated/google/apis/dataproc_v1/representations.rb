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
    module DataprocV1
      
      class AcceleratorConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CancelJobRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Cluster
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClusterConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClusterMetrics
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClusterOperationMetadata
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClusterOperationStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClusterStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiagnoseClusterRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiagnoseClusterResults
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DiskConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Empty
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GceClusterConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HadoopJob
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HiveJob
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InstanceGroupConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Job
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class JobPlacement
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class JobReference
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class JobScheduling
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class JobStatus
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListClustersResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListJobsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListOperationsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class LoggingConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ManagedGroupConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NodeInitializationAction
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Operation
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PigJob
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PySparkJob
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class QueryList
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SoftwareConfig
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SparkJob
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SparkSqlJob
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Status
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SubmitJobRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class YarnApplication
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AcceleratorConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :accelerator_count, as: 'acceleratorCount'
          property :accelerator_type_uri, as: 'acceleratorTypeUri'
        end
      end
      
      class CancelJobRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class Cluster
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cluster_name, as: 'clusterName'
          property :cluster_uuid, as: 'clusterUuid'
          property :config, as: 'config', class: Google::Apis::DataprocV1::ClusterConfig, decorator: Google::Apis::DataprocV1::ClusterConfig::Representation
      
          hash :labels, as: 'labels'
          property :metrics, as: 'metrics', class: Google::Apis::DataprocV1::ClusterMetrics, decorator: Google::Apis::DataprocV1::ClusterMetrics::Representation
      
          property :project_id, as: 'projectId'
          property :status, as: 'status', class: Google::Apis::DataprocV1::ClusterStatus, decorator: Google::Apis::DataprocV1::ClusterStatus::Representation
      
          collection :status_history, as: 'statusHistory', class: Google::Apis::DataprocV1::ClusterStatus, decorator: Google::Apis::DataprocV1::ClusterStatus::Representation
      
        end
      end
      
      class ClusterConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :config_bucket, as: 'configBucket'
          property :gce_cluster_config, as: 'gceClusterConfig', class: Google::Apis::DataprocV1::GceClusterConfig, decorator: Google::Apis::DataprocV1::GceClusterConfig::Representation
      
          collection :initialization_actions, as: 'initializationActions', class: Google::Apis::DataprocV1::NodeInitializationAction, decorator: Google::Apis::DataprocV1::NodeInitializationAction::Representation
      
          property :master_config, as: 'masterConfig', class: Google::Apis::DataprocV1::InstanceGroupConfig, decorator: Google::Apis::DataprocV1::InstanceGroupConfig::Representation
      
          property :secondary_worker_config, as: 'secondaryWorkerConfig', class: Google::Apis::DataprocV1::InstanceGroupConfig, decorator: Google::Apis::DataprocV1::InstanceGroupConfig::Representation
      
          property :software_config, as: 'softwareConfig', class: Google::Apis::DataprocV1::SoftwareConfig, decorator: Google::Apis::DataprocV1::SoftwareConfig::Representation
      
          property :worker_config, as: 'workerConfig', class: Google::Apis::DataprocV1::InstanceGroupConfig, decorator: Google::Apis::DataprocV1::InstanceGroupConfig::Representation
      
        end
      end
      
      class ClusterMetrics
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          hash :hdfs_metrics, as: 'hdfsMetrics'
          hash :yarn_metrics, as: 'yarnMetrics'
        end
      end
      
      class ClusterOperationMetadata
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cluster_name, as: 'clusterName'
          property :cluster_uuid, as: 'clusterUuid'
          property :description, as: 'description'
          hash :labels, as: 'labels'
          property :operation_type, as: 'operationType'
          property :status, as: 'status', class: Google::Apis::DataprocV1::ClusterOperationStatus, decorator: Google::Apis::DataprocV1::ClusterOperationStatus::Representation
      
          collection :status_history, as: 'statusHistory', class: Google::Apis::DataprocV1::ClusterOperationStatus, decorator: Google::Apis::DataprocV1::ClusterOperationStatus::Representation
      
          collection :warnings, as: 'warnings'
        end
      end
      
      class ClusterOperationStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :details, as: 'details'
          property :inner_state, as: 'innerState'
          property :state, as: 'state'
          property :state_start_time, as: 'stateStartTime'
        end
      end
      
      class ClusterStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :detail, as: 'detail'
          property :state, as: 'state'
          property :state_start_time, as: 'stateStartTime'
          property :substate, as: 'substate'
        end
      end
      
      class DiagnoseClusterRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class DiagnoseClusterResults
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :output_uri, as: 'outputUri'
        end
      end
      
      class DiskConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :boot_disk_size_gb, as: 'bootDiskSizeGb'
          property :num_local_ssds, as: 'numLocalSsds'
        end
      end
      
      class Empty
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class GceClusterConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :internal_ip_only, as: 'internalIpOnly'
          hash :metadata, as: 'metadata'
          property :network_uri, as: 'networkUri'
          property :service_account, as: 'serviceAccount'
          collection :service_account_scopes, as: 'serviceAccountScopes'
          property :subnetwork_uri, as: 'subnetworkUri'
          collection :tags, as: 'tags'
          property :zone_uri, as: 'zoneUri'
        end
      end
      
      class HadoopJob
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :archive_uris, as: 'archiveUris'
          collection :args, as: 'args'
          collection :file_uris, as: 'fileUris'
          collection :jar_file_uris, as: 'jarFileUris'
          property :logging_config, as: 'loggingConfig', class: Google::Apis::DataprocV1::LoggingConfig, decorator: Google::Apis::DataprocV1::LoggingConfig::Representation
      
          property :main_class, as: 'mainClass'
          property :main_jar_file_uri, as: 'mainJarFileUri'
          hash :properties, as: 'properties'
        end
      end
      
      class HiveJob
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :continue_on_failure, as: 'continueOnFailure'
          collection :jar_file_uris, as: 'jarFileUris'
          hash :properties, as: 'properties'
          property :query_file_uri, as: 'queryFileUri'
          property :query_list, as: 'queryList', class: Google::Apis::DataprocV1::QueryList, decorator: Google::Apis::DataprocV1::QueryList::Representation
      
          hash :script_variables, as: 'scriptVariables'
        end
      end
      
      class InstanceGroupConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :accelerators, as: 'accelerators', class: Google::Apis::DataprocV1::AcceleratorConfig, decorator: Google::Apis::DataprocV1::AcceleratorConfig::Representation
      
          property :disk_config, as: 'diskConfig', class: Google::Apis::DataprocV1::DiskConfig, decorator: Google::Apis::DataprocV1::DiskConfig::Representation
      
          property :image_uri, as: 'imageUri'
          collection :instance_names, as: 'instanceNames'
          property :is_preemptible, as: 'isPreemptible'
          property :machine_type_uri, as: 'machineTypeUri'
          property :managed_group_config, as: 'managedGroupConfig', class: Google::Apis::DataprocV1::ManagedGroupConfig, decorator: Google::Apis::DataprocV1::ManagedGroupConfig::Representation
      
          property :num_instances, as: 'numInstances'
        end
      end
      
      class Job
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :driver_control_files_uri, as: 'driverControlFilesUri'
          property :driver_output_resource_uri, as: 'driverOutputResourceUri'
          property :hadoop_job, as: 'hadoopJob', class: Google::Apis::DataprocV1::HadoopJob, decorator: Google::Apis::DataprocV1::HadoopJob::Representation
      
          property :hive_job, as: 'hiveJob', class: Google::Apis::DataprocV1::HiveJob, decorator: Google::Apis::DataprocV1::HiveJob::Representation
      
          hash :labels, as: 'labels'
          property :pig_job, as: 'pigJob', class: Google::Apis::DataprocV1::PigJob, decorator: Google::Apis::DataprocV1::PigJob::Representation
      
          property :placement, as: 'placement', class: Google::Apis::DataprocV1::JobPlacement, decorator: Google::Apis::DataprocV1::JobPlacement::Representation
      
          property :pyspark_job, as: 'pysparkJob', class: Google::Apis::DataprocV1::PySparkJob, decorator: Google::Apis::DataprocV1::PySparkJob::Representation
      
          property :reference, as: 'reference', class: Google::Apis::DataprocV1::JobReference, decorator: Google::Apis::DataprocV1::JobReference::Representation
      
          property :scheduling, as: 'scheduling', class: Google::Apis::DataprocV1::JobScheduling, decorator: Google::Apis::DataprocV1::JobScheduling::Representation
      
          property :spark_job, as: 'sparkJob', class: Google::Apis::DataprocV1::SparkJob, decorator: Google::Apis::DataprocV1::SparkJob::Representation
      
          property :spark_sql_job, as: 'sparkSqlJob', class: Google::Apis::DataprocV1::SparkSqlJob, decorator: Google::Apis::DataprocV1::SparkSqlJob::Representation
      
          property :status, as: 'status', class: Google::Apis::DataprocV1::JobStatus, decorator: Google::Apis::DataprocV1::JobStatus::Representation
      
          collection :status_history, as: 'statusHistory', class: Google::Apis::DataprocV1::JobStatus, decorator: Google::Apis::DataprocV1::JobStatus::Representation
      
          collection :yarn_applications, as: 'yarnApplications', class: Google::Apis::DataprocV1::YarnApplication, decorator: Google::Apis::DataprocV1::YarnApplication::Representation
      
        end
      end
      
      class JobPlacement
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cluster_name, as: 'clusterName'
          property :cluster_uuid, as: 'clusterUuid'
        end
      end
      
      class JobReference
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :job_id, as: 'jobId'
          property :project_id, as: 'projectId'
        end
      end
      
      class JobScheduling
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :max_failures_per_hour, as: 'maxFailuresPerHour'
        end
      end
      
      class JobStatus
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :details, as: 'details'
          property :state, as: 'state'
          property :state_start_time, as: 'stateStartTime'
          property :substate, as: 'substate'
        end
      end
      
      class ListClustersResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :clusters, as: 'clusters', class: Google::Apis::DataprocV1::Cluster, decorator: Google::Apis::DataprocV1::Cluster::Representation
      
          property :next_page_token, as: 'nextPageToken'
        end
      end
      
      class ListJobsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :jobs, as: 'jobs', class: Google::Apis::DataprocV1::Job, decorator: Google::Apis::DataprocV1::Job::Representation
      
          property :next_page_token, as: 'nextPageToken'
        end
      end
      
      class ListOperationsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :next_page_token, as: 'nextPageToken'
          collection :operations, as: 'operations', class: Google::Apis::DataprocV1::Operation, decorator: Google::Apis::DataprocV1::Operation::Representation
      
        end
      end
      
      class LoggingConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          hash :driver_log_levels, as: 'driverLogLevels'
        end
      end
      
      class ManagedGroupConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :instance_group_manager_name, as: 'instanceGroupManagerName'
          property :instance_template_name, as: 'instanceTemplateName'
        end
      end
      
      class NodeInitializationAction
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :executable_file, as: 'executableFile'
          property :execution_timeout, as: 'executionTimeout'
        end
      end
      
      class Operation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :done, as: 'done'
          property :error, as: 'error', class: Google::Apis::DataprocV1::Status, decorator: Google::Apis::DataprocV1::Status::Representation
      
          hash :metadata, as: 'metadata'
          property :name, as: 'name'
          hash :response, as: 'response'
        end
      end
      
      class PigJob
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :continue_on_failure, as: 'continueOnFailure'
          collection :jar_file_uris, as: 'jarFileUris'
          property :logging_config, as: 'loggingConfig', class: Google::Apis::DataprocV1::LoggingConfig, decorator: Google::Apis::DataprocV1::LoggingConfig::Representation
      
          hash :properties, as: 'properties'
          property :query_file_uri, as: 'queryFileUri'
          property :query_list, as: 'queryList', class: Google::Apis::DataprocV1::QueryList, decorator: Google::Apis::DataprocV1::QueryList::Representation
      
          hash :script_variables, as: 'scriptVariables'
        end
      end
      
      class PySparkJob
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :archive_uris, as: 'archiveUris'
          collection :args, as: 'args'
          collection :file_uris, as: 'fileUris'
          collection :jar_file_uris, as: 'jarFileUris'
          property :logging_config, as: 'loggingConfig', class: Google::Apis::DataprocV1::LoggingConfig, decorator: Google::Apis::DataprocV1::LoggingConfig::Representation
      
          property :main_python_file_uri, as: 'mainPythonFileUri'
          hash :properties, as: 'properties'
          collection :python_file_uris, as: 'pythonFileUris'
        end
      end
      
      class QueryList
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :queries, as: 'queries'
        end
      end
      
      class SoftwareConfig
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :image_version, as: 'imageVersion'
          hash :properties, as: 'properties'
        end
      end
      
      class SparkJob
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :archive_uris, as: 'archiveUris'
          collection :args, as: 'args'
          collection :file_uris, as: 'fileUris'
          collection :jar_file_uris, as: 'jarFileUris'
          property :logging_config, as: 'loggingConfig', class: Google::Apis::DataprocV1::LoggingConfig, decorator: Google::Apis::DataprocV1::LoggingConfig::Representation
      
          property :main_class, as: 'mainClass'
          property :main_jar_file_uri, as: 'mainJarFileUri'
          hash :properties, as: 'properties'
        end
      end
      
      class SparkSqlJob
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :jar_file_uris, as: 'jarFileUris'
          property :logging_config, as: 'loggingConfig', class: Google::Apis::DataprocV1::LoggingConfig, decorator: Google::Apis::DataprocV1::LoggingConfig::Representation
      
          hash :properties, as: 'properties'
          property :query_file_uri, as: 'queryFileUri'
          property :query_list, as: 'queryList', class: Google::Apis::DataprocV1::QueryList, decorator: Google::Apis::DataprocV1::QueryList::Representation
      
          hash :script_variables, as: 'scriptVariables'
        end
      end
      
      class Status
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :code, as: 'code'
          collection :details, as: 'details'
          property :message, as: 'message'
        end
      end
      
      class SubmitJobRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :job, as: 'job', class: Google::Apis::DataprocV1::Job, decorator: Google::Apis::DataprocV1::Job::Representation
      
        end
      end
      
      class YarnApplication
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :name, as: 'name'
          property :progress, as: 'progress'
          property :state, as: 'state'
          property :tracking_url, as: 'trackingUrl'
        end
      end
    end
  end
end
