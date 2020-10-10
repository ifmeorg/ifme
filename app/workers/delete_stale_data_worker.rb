class DeleteStaleDataWorker
  include Sidekiq::Worker
  
  ACTIVE_DURATION = 30.days

  def perform()
    Users::DataRequest.where("updated_at < ?", (Time.current() - 30.days))
      .where(status_id: Users::DataRequest::STATUS[:success])
      .each do |dr|
      File.delete(self.file_path) if (self.file_path.present? && File.exist?(self.file_path))
      dr.update(status_id: Users::DataRequest::STATUS[:deleted])
    end
  end
end
