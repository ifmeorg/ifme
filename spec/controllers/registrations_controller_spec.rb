# frozen_string_literal: true

RSpec.describe RegistrationsController, type: :controller do
  before(:each) {
    @request.env['devise.mapping'] = Devise.mappings[:user]
  }

  describe "#update" do
    let(:new_password) { "foobar_w!th_@" }

    context "when the user is logged in with Google OAuth" do
      let(:user_google) { create(:user_oauth, provider: 'google_oauth2') }

      before do
        stub_current_user_with(user_google)
      end

      it "updates without specifying current password" do
        update_params = { password: new_password, password_confirmation: new_password }
        allow_any_instance_of(RegistrationsController).to receive(:update_resource_params).and_return(update_params)
        put :update, params: update_params
        expect(response).to have_http_status(302)
      end
    end

    context "when the user is logged in with Facebook" do
      let(:user_facebook) { create(:user_oauth, provider: 'facebook') }

      before do
        stub_current_user_with(user_facebook)
      end

      it "updates without specifying current password" do
        update_params = { password: new_password, password_confirmation: new_password }
        allow_any_instance_of(RegistrationsController).to receive(:update_resource_params).and_return(update_params)
        put :update, params: update_params
        expect(response).to have_http_status(302)
      end
    end
  end
end
