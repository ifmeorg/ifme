# frozen_string_literal: true

describe 'Error', type: :request do
  describe 'GET #not_found' do
    it 'returns http 404' do
      get errors_not_found_path
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #internal_server_error' do
    it 'returns http 500' do
      get errors_internal_server_error_path
      expect(response).to have_http_status(500)
    end
  end
end
