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

require 'google/apis/deploymentmanager_alpha/service.rb'
require 'google/apis/deploymentmanager_alpha/classes.rb'
require 'google/apis/deploymentmanager_alpha/representations.rb'

module Google
  module Apis
    # Google Cloud Deployment Manager Alpha API
    #
    # The Deployment Manager API allows users to declaratively configure, deploy and
    # run complex solutions on the Google Cloud Platform.
    #
    # @see https://cloud.google.com/deployment-manager/
    module DeploymentmanagerAlpha
      VERSION = 'Alpha'
      REVISION = '20170810'

      # View and manage your data across Google Cloud Platform services
      AUTH_CLOUD_PLATFORM = 'https://www.googleapis.com/auth/cloud-platform'

      # View your data across Google Cloud Platform services
      AUTH_CLOUD_PLATFORM_READ_ONLY = 'https://www.googleapis.com/auth/cloud-platform.read-only'

      # View and manage your Google Cloud Platform management resources and deployment status information
      AUTH_NDEV_CLOUDMAN = 'https://www.googleapis.com/auth/ndev.cloudman'

      # View your Google Cloud Platform management resources and deployment status information
      AUTH_NDEV_CLOUDMAN_READONLY = 'https://www.googleapis.com/auth/ndev.cloudman.readonly'
    end
  end
end
