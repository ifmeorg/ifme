# frozen_string_literal: true

RSpec.describe ErrorsController, type: :request do
  describe 'GET #not_found' do
    it 'returns http 404' do
      get '/errors/not_found'
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #internal_server_error' do
    it 'returns http 500' do
      get '/errors/internal_server_error'
      expect(response).to have_http_status(500)
    end
  end
end
