# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Registrations', type: :request do
  shared_examples 'successfully updates user and redirects' do
    before do
      sign_in user
      put user_registration_path, params: update_params
      user.reload
    end

    it { expect(response).to redirect_to(edit_user_registration_path) }
    it { expect(user.comment_notify).to be(false) }
  end

  describe '#update' do
    let(:update_params) { { user: { comment_notify: 'false' } } }

    context 'when the user is logged in with Google OAuth' do
      let(:user) { create(:user_oauth, provider: 'google_oauth2') }
      it_behaves_like 'successfully updates user and redirects'
    end

    context 'when the user is logged in with Facebook' do
      let(:user) { create(:user_oauth, provider: 'facebook') }
      it_behaves_like 'successfully updates user and redirects'
    end

    context 'when the user is logged in' do
      let(:user) { create(:user, provider: nil) }
      let(:update_params) do
        { user: { name: user.name, email: user.email, password: new_password, password_confirmation: new_password,
                  current_password: user.password, comment_notify: 'false' } }
      end
      let(:new_password) { 'foobar_w!th_@' }
      it_behaves_like 'successfully updates user and redirects'

      it 'successfully changes password' do
        sign_in user
        put user_registration_path, params: update_params
        user.reload
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
