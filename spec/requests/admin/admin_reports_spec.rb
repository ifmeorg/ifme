require 'rails_helper'

RSpec.describe "Admin::Reports", type: :request do
  describe "GET /admin_reports" do
    it "works! (now write some real specs)" do
      get admin_reports_path
      expect(response).to have_http_status(200)
    end
  end
end
