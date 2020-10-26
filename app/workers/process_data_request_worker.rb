# frozen_string_literal: true
class ProcessDataRequestWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(request_id)
    data_request = Users::DataRequest.find_by(request_id: request_id)
    return if data_request.blank? ||
              data_request.status_id == Users::DataRequest::STATUS[:success]

    data_request.create_csv
  end
end
