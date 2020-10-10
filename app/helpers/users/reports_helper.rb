module Users::ReportsHelper

  def submit_request_helper(user)
    begin
      return 200, {request_id: user.generate_data_request()}
    rescue => e
      return 422, {error: e.message}
    end
  end

  def fetch_request_status_helper(user, request_id)
    return 400, {error: "Request id can be blank."} if request_id.blank?
    data_request = user.data_requests.find_by(request_id: request_id)
    return 404, {error: "No such request exists for current user."} if data_request.blank?
    return 200, {current_status: data_request.status_id}
  end

  def download_data_helper(user, request_id)
    return 400, {error: "Request id can be blank."} if request_id.blank?
    data_request = user.data_requests.find_by(request_id: request_id, status_id: Users::DataRequest::STATUS[:success])
    return 404, {error: "Requested csv not found."} if (data_request.blank? || !File.exist?("#{data_request.file_path}"))
    return 200, data_request.file_path
  end

end
