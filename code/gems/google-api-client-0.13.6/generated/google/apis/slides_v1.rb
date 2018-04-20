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

require 'google/apis/slides_v1/service.rb'
require 'google/apis/slides_v1/classes.rb'
require 'google/apis/slides_v1/representations.rb'

module Google
  module Apis
    # Google Slides API
    #
    # An API for creating and editing Google Slides presentations.
    #
    # @see https://developers.google.com/slides/
    module SlidesV1
      VERSION = 'V1'
      REVISION = '20170824'

      # View and manage the files in your Google Drive
      AUTH_DRIVE = 'https://www.googleapis.com/auth/drive'

      # View the files in your Google Drive
      AUTH_DRIVE_READONLY = 'https://www.googleapis.com/auth/drive.readonly'

      # View and manage your Google Slides presentations
      AUTH_PRESENTATIONS = 'https://www.googleapis.com/auth/presentations'

      # View your Google Slides presentations
      AUTH_PRESENTATIONS_READONLY = 'https://www.googleapis.com/auth/presentations.readonly'

      # View and manage your spreadsheets in Google Drive
      AUTH_SPREADSHEETS = 'https://www.googleapis.com/auth/spreadsheets'

      # View your Google Spreadsheets
      AUTH_SPREADSHEETS_READONLY = 'https://www.googleapis.com/auth/spreadsheets.readonly'
    end
  end
end
