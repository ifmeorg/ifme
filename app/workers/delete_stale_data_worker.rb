# frozen_string_literal: true
class DeleteStaleDataWorker
  include Sidekiq::Worker

  ACTIVE_DURATION = 30.days

  def perform
    Users::DataRequest
      .where('updated_at < ?', (Time.current - ACTIVE_DURATION))
      .where(status_id: Users::DataRequest::STATUS[:success])
      .each do |dr|
      if dr.file_path.present? && File.exist?(dr.file_path)
        File.delete(dr.file_path)
      end
      dr.update(status_id: Users::DataRequest::STATUS[:deleted])
    end
  end
end
