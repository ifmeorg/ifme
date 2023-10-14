# frozen_string_literal: true
module Users
  class ReportsController < ApplicationController
    before_action :authenticate_user!
    include Users::ReportsHelper

    def submit_request
      status, response = submit_request_helper(current_user)
      render json: response, status:
    end

    def fetch_request_status
      status, response = fetch_request_status_helper(current_user,
                                                     params[:request_id])
      render json: response, status:
    end

    def download_data
      status, response = download_data_helper(current_user,
                                              params[:request_id])
      if status == 200
        send_file(response, status: 200)
      else
        render(json: response, status:)
      end
    end
  end
end
