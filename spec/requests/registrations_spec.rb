# frozen_string_literal: true

RSpec.describe 'Registrations', type: :request do

  shared_examples "sucessful password update" do
    let(:update_params) { { password: new_password, password_confirmation: new_password } }
    before do
      sign_in user
      put user_registration_path, params: update_params
    end

    it { expect(response).to redirect_to(edit_user_registration_path) }
  end

  describe "update password" do
    let(:new_password) { "foobar_w!th_@" }

    context "when the user is logged in with Google OAuth" do
      let(:user) { create(:user_oauth, provider: 'google_oauth2') }
      it_behaves_like "sucessful password update"
    end

    context "when the user is logged in with Facebook" do
      let(:user) { create(:user_oauth, provider: 'facebook') }
      it_behaves_like "sucessful password update"
    end
  end
end
