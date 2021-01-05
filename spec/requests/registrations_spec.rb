# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Registrations', type: :request do
  shared_examples 'successfully redirects' do
    before do
      sign_in user
      put user_registration_path, params: update_params
    end

    it { expect(response).to redirect_to(edit_user_registration_path) }
  end

  describe '#update' do

    let(:update_params){{}}

    context 'when the user is logged in with Google OAuth' do
      let(:user) { create(:user_oauth, provider: 'google_oauth2') }
      it_behaves_like 'successfully redirects'
    end

    context 'when the user is logged in with Facebook' do
      let(:user) { create(:user_oauth, provider: 'facebook') }
      it_behaves_like 'successfully redirects'
    end

    context 'when the user is logged in with password' do
      let(:user) { create(:user, provider: nil) }
      let(:new_password) { 'foobar_w!th_@' }

      context 'with valid params' do
        let(:update_params) do
          { user: { name: user.name, email: user.email, password_confirmation: new_password,
                    password: new_password, current_password: user.password} }
        end
        it_behaves_like 'successfully redirects'
      end

      context 'with invalid params' do
        it 'does not redirects' do
          sign_in user
          put user_registration_path, params: {}
          expect(response).not_to redirect_to(edit_user_registration_path)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
