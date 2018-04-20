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
    module DataprocV1beta2
      # Google Cloud Dataproc API
      #
      # Manages Hadoop-based clusters and jobs on Google Cloud Platform.
      #
      # @example
      #    require 'google/apis/dataproc_v1beta2'
      #
      #    Dataproc = Google::Apis::DataprocV1beta2 # Alias the module
      #    service = Dataproc::DataprocService.new
      #
      # @see https://cloud.google.com/dataproc/
      class DataprocService < Google::Apis::Core::BaseService
        # @return [String]
        #  API key. Your API key identifies your project and provides you with API access,
        #  quota, and reports. Required unless you provide an OAuth 2.0 token.
        attr_accessor :key

        # @return [String]
        #  Available to use for quota purposes for server-side applications. Can be any
        #  arbitrary string assigned to a user, but should not exceed 40 characters.
        attr_accessor :quota_user

        def initialize
          super('https://dataproc.googleapis.com/', '')
          @batch_path = 'batch'
        end
        
        # Creates a cluster in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the cluster belongs
        #   to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [Google::Apis::DataprocV1beta2::Cluster] cluster_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_region_cluster(project_id, region, cluster_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta2/projects/{projectId}/regions/{region}/clusters', options)
          command.request_representation = Google::Apis::DataprocV1beta2::Cluster::Representation
          command.request_object = cluster_object
          command.response_representation = Google::Apis::DataprocV1beta2::Operation::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a cluster in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the cluster belongs
        #   to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] cluster_name
        #   Required. The cluster name.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_region_cluster(project_id, region, cluster_name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta2/projects/{projectId}/regions/{region}/clusters/{clusterName}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Operation::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['clusterName'] = cluster_name unless cluster_name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets cluster diagnostic information. After the operation completes, the
        # Operation.response field contains DiagnoseClusterOutputLocation.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the cluster belongs
        #   to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] cluster_name
        #   Required. The cluster name.
        # @param [Google::Apis::DataprocV1beta2::DiagnoseClusterRequest] diagnose_cluster_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def diagnose_cluster(project_id, region, cluster_name, diagnose_cluster_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta2/projects/{projectId}/regions/{region}/clusters/{clusterName}:diagnose', options)
          command.request_representation = Google::Apis::DataprocV1beta2::DiagnoseClusterRequest::Representation
          command.request_object = diagnose_cluster_request_object
          command.response_representation = Google::Apis::DataprocV1beta2::Operation::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['clusterName'] = cluster_name unless cluster_name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the resource representation for a cluster in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the cluster belongs
        #   to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] cluster_name
        #   Required. The cluster name.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Cluster] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Cluster]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_region_cluster(project_id, region, cluster_name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta2/projects/{projectId}/regions/{region}/clusters/{clusterName}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Cluster::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Cluster
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['clusterName'] = cluster_name unless cluster_name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists all regions/`region`/clusters in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the cluster belongs
        #   to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] filter
        #   Optional. A filter constraining the clusters to list. Filters are case-
        #   sensitive and have the following syntax:field = value AND field = value ...
        #   where field is one of status.state, clusterName, or labels.[KEY], and [KEY] is
        #   a label key. value can be * to match all values. status.state can be one of
        #   the following: ACTIVE, INACTIVE, CREATING, RUNNING, ERROR, DELETING, or
        #   UPDATING. ACTIVE contains the CREATING, UPDATING, and RUNNING states. INACTIVE
        #   contains the DELETING and ERROR states. clusterName is the name of the cluster
        #   provided at creation time. Only the logical AND operator is supported; space-
        #   separated items are treated as having an implicit AND operator.Example filter:
        #   status.state = ACTIVE AND clusterName = mycluster AND labels.env = staging AND
        #   labels.starred = *
        # @param [Fixnum] page_size
        #   Optional. The standard List page size.
        # @param [String] page_token
        #   Optional. The standard List page token.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::ListClustersResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::ListClustersResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_region_clusters(project_id, region, filter: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta2/projects/{projectId}/regions/{region}/clusters', options)
          command.response_representation = Google::Apis::DataprocV1beta2::ListClustersResponse::Representation
          command.response_class = Google::Apis::DataprocV1beta2::ListClustersResponse
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates a cluster in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project the cluster belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] cluster_name
        #   Required. The cluster name.
        # @param [Google::Apis::DataprocV1beta2::Cluster] cluster_object
        # @param [String] graceful_decommission_timeout
        #   Optional. Timeout for graceful YARN decomissioning. Graceful decommissioning
        #   allows removing nodes from the cluster without interrupting jobs in progress.
        #   Timeout specifies how long to wait for jobs in progress to finish before
        #   forcefully removing nodes (and potentially interrupting jobs). Default timeout
        #   is 0 (for forceful decommission), and the maximum allowed timeout is 1 day.
        #   Only supported on Dataproc image versions 1.2 and higher.
        # @param [String] update_mask
        #   Required. Specifies the path, relative to <code>Cluster</code>, of the field
        #   to update. For example, to change the number of workers in a cluster to 5, the
        #   <code>update_mask</code> parameter would be specified as <code>config.
        #   worker_config.num_instances</code>, and the PATCH request body would specify
        #   the new value, as follows:
        #   `
        #   "config":`
        #   "workerConfig":`
        #   "numInstances":"5"
        #   `
        #   `
        #   `
        #   Similarly, to change the number of preemptible workers in a cluster to 5, the <
        #   code>update_mask</code> parameter would be <code>config.
        #   secondary_worker_config.num_instances</code>, and the PATCH request body would
        #   be set as follows:
        #   `
        #   "config":`
        #   "secondaryWorkerConfig":`
        #   "numInstances":"5"
        #   `
        #   `
        #   `
        #   <strong>Note:</strong> currently only some fields can be updated: |Mask|
        #   Purpose| |labels|Updates labels| |config.worker_config.num_instances|Resize
        #   primary worker group| |config.secondary_worker_config.num_instances|Resize
        #   secondary worker group|
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_region_cluster(project_id, region, cluster_name, cluster_object = nil, graceful_decommission_timeout: nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:patch, 'v1beta2/projects/{projectId}/regions/{region}/clusters/{clusterName}', options)
          command.request_representation = Google::Apis::DataprocV1beta2::Cluster::Representation
          command.request_object = cluster_object
          command.response_representation = Google::Apis::DataprocV1beta2::Operation::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Operation
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['clusterName'] = cluster_name unless cluster_name.nil?
          command.query['gracefulDecommissionTimeout'] = graceful_decommission_timeout unless graceful_decommission_timeout.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Starts a job cancellation request. To access the job resource after
        # cancellation, call regions/`region`/jobs.list or regions/`region`/jobs.get.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the job belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] job_id
        #   Required. The job ID.
        # @param [Google::Apis::DataprocV1beta2::CancelJobRequest] cancel_job_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Job] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Job]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def cancel_job(project_id, region, job_id, cancel_job_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta2/projects/{projectId}/regions/{region}/jobs/{jobId}:cancel', options)
          command.request_representation = Google::Apis::DataprocV1beta2::CancelJobRequest::Representation
          command.request_object = cancel_job_request_object
          command.response_representation = Google::Apis::DataprocV1beta2::Job::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Job
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['jobId'] = job_id unless job_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes the job from the project. If the job is active, the delete fails, and
        # the response returns FAILED_PRECONDITION.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the job belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] job_id
        #   Required. The job ID.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_region_job(project_id, region, job_id, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta2/projects/{projectId}/regions/{region}/jobs/{jobId}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Empty::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Empty
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['jobId'] = job_id unless job_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the resource representation for a job in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the job belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] job_id
        #   Required. The job ID.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Job] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Job]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_region_job(project_id, region, job_id, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta2/projects/{projectId}/regions/{region}/jobs/{jobId}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Job::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Job
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['jobId'] = job_id unless job_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists regions/`region`/jobs in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the job belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] cluster_name
        #   Optional. If set, the returned jobs list includes only jobs that were
        #   submitted to the named cluster.
        # @param [String] filter
        #   Optional. A filter constraining the jobs to list. Filters are case-sensitive
        #   and have the following syntax:field = value AND field = value ...where field
        #   is status.state or labels.[KEY], and [KEY] is a label key. value can be * to
        #   match all values. status.state can be either ACTIVE or INACTIVE. Only the
        #   logical AND operator is supported; space-separated items are treated as having
        #   an implicit AND operator.Example filter:status.state = ACTIVE AND labels.env =
        #   staging AND labels.starred = *
        # @param [String] job_state_matcher
        #   Optional. Specifies enumerated categories of jobs to list (default = match ALL
        #   jobs).
        # @param [Fixnum] page_size
        #   Optional. The number of results to return in each response.
        # @param [String] page_token
        #   Optional. The page token, returned by a previous call, to request the next
        #   page of results.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::ListJobsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::ListJobsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_region_jobs(project_id, region, cluster_name: nil, filter: nil, job_state_matcher: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta2/projects/{projectId}/regions/{region}/jobs', options)
          command.response_representation = Google::Apis::DataprocV1beta2::ListJobsResponse::Representation
          command.response_class = Google::Apis::DataprocV1beta2::ListJobsResponse
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.query['clusterName'] = cluster_name unless cluster_name.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['jobStateMatcher'] = job_state_matcher unless job_state_matcher.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates a job in a project.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the job belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [String] job_id
        #   Required. The job ID.
        # @param [Google::Apis::DataprocV1beta2::Job] job_object
        # @param [String] update_mask
        #   Required. Specifies the path, relative to <code>Job</code>, of the field to
        #   update. For example, to update the labels of a Job the <code>update_mask</code>
        #   parameter would be specified as <code>labels</code>, and the PATCH request
        #   body would specify the new value. <strong>Note:</strong> Currently, <code>
        #   labels</code> is the only field that can be updated.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Job] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Job]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_region_job(project_id, region, job_id, job_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:patch, 'v1beta2/projects/{projectId}/regions/{region}/jobs/{jobId}', options)
          command.request_representation = Google::Apis::DataprocV1beta2::Job::Representation
          command.request_object = job_object
          command.response_representation = Google::Apis::DataprocV1beta2::Job::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Job
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.params['jobId'] = job_id unless job_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Submits a job to a cluster.
        # @param [String] project_id
        #   Required. The ID of the Google Cloud Platform project that the job belongs to.
        # @param [String] region
        #   Required. The Cloud Dataproc region in which to handle the request.
        # @param [Google::Apis::DataprocV1beta2::SubmitJobRequest] submit_job_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Job] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Job]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def submit_job(project_id, region, submit_job_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta2/projects/{projectId}/regions/{region}/jobs:submit', options)
          command.request_representation = Google::Apis::DataprocV1beta2::SubmitJobRequest::Representation
          command.request_object = submit_job_request_object
          command.response_representation = Google::Apis::DataprocV1beta2::Job::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Job
          command.params['projectId'] = project_id unless project_id.nil?
          command.params['region'] = region unless region.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Starts asynchronous cancellation on a long-running operation. The server makes
        # a best effort to cancel the operation, but success is not guaranteed. If the
        # server doesn't support this method, it returns google.rpc.Code.UNIMPLEMENTED.
        # Clients can use Operations.GetOperation or other methods to check whether the
        # cancellation succeeded or whether the operation completed despite cancellation.
        # On successful cancellation, the operation is not deleted; instead, it becomes
        # an operation with an Operation.error value with a google.rpc.Status.code of 1,
        # corresponding to Code.CANCELLED.
        # @param [String] name
        #   The name of the operation resource to be cancelled.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def cancel_project_region_operation(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v1beta2/{+name}:cancel', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Empty::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Empty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a long-running operation. This method indicates that the client is no
        # longer interested in the operation result. It does not cancel the operation.
        # If the server doesn't support this method, it returns google.rpc.Code.
        # UNIMPLEMENTED.
        # @param [String] name
        #   The name of the operation resource to be deleted.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_region_operation(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v1beta2/{+name}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Empty::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Empty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the latest state of a long-running operation. Clients can use this method
        # to poll the operation result at intervals as recommended by the API service.
        # @param [String] name
        #   The name of the operation resource.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_region_operation(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta2/{+name}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::Operation::Representation
          command.response_class = Google::Apis::DataprocV1beta2::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists operations that match the specified filter in the request. If the server
        # doesn't support this method, it returns UNIMPLEMENTED.NOTE: the name binding
        # allows API services to override the binding to use different resource name
        # schemes, such as users/*/operations. To override the binding, API services can
        # add a binding such as "/v1/`name=users/*`/operations" to their service
        # configuration. For backwards compatibility, the default name includes the
        # operations collection id, however overriding users must ensure the name
        # binding is the parent resource, without the operations collection id.
        # @param [String] name
        #   The name of the operation's parent resource.
        # @param [String] filter
        #   The standard list filter.
        # @param [Fixnum] page_size
        #   The standard list page size.
        # @param [String] page_token
        #   The standard list page token.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DataprocV1beta2::ListOperationsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DataprocV1beta2::ListOperationsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_region_operations(name, filter: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v1beta2/{+name}', options)
          command.response_representation = Google::Apis::DataprocV1beta2::ListOperationsResponse::Representation
          command.response_class = Google::Apis::DataprocV1beta2::ListOperationsResponse
          command.params['name'] = name unless name.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end

        protected

        def apply_command_defaults(command)
          command.query['key'] = key unless key.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
        end
      end
    end
  end
end
