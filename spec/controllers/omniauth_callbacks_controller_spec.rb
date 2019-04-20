# frozen_string_literal: true

RSpec.describe OmniauthCallbacksController, type: :controller do
  shared_examples 'successful sign in with oauth details' do
    it 'should sign in and redirect to root' do
      expect(subject.current_user).to eq user
      expect(response).to redirect_to('/')
    end

    it 'should create authentication with google_oauth2' do
      expect(user.reload.google_oauth2_enabled?).to eq true
    end
  end

  describe 'GET #google_oauth2' do
    before { stub_env_for_omniauth }
    let(:oauth_email) { request.env['omniauth.auth']['info']['email'] }
    let(:oauth_user) { User.find_by(email: oauth_email) }

    context 'when google_oauth2 email doesnt exist in the system' do
      let(:user) { oauth_user }

      before { get :google_oauth2 }

      it 'creates user with info in google_oauth2' do
        expect(user.name).to eq 'Test User'
      end

      include_examples 'successful sign in with oauth details'
    end

    context 'when google_oauth2 email already exist in the system' do
      let!(:user) { create(:user, email: 'example@xyze.it') }

      before { get :google_oauth2 }

      it 'updates the user with google_oauth2 credentials' do
        expect(user.reload.token).to eq 'abcdefg12345'
      end

      include_examples 'successful sign in with oauth details'
    end

    context 'when google_oauth2 enabling fails' do
      before do
        stub_env_for_omniauth
        allow(User).to receive(:find_for_google_oauth2)
          .with(request.env['omniauth.auth']).and_return(nil)
        get :google_oauth2
      end

      it 'redirects to sign in path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when an invitation_token is passed in' do
      let(:inviter) { create(:user) }
      let(:invitee_email) { oauth_email }
      let!(:invitee) { User.invite!({ email: invitee_email }, inviter) }

      before do
        request.env['omniauth.params'] = { 'invitation_token' => invitee.invitation_token }
        get :google_oauth2
      end

      context 'when the user logs in with the same email as the invitation' do
        let(:user) { invitee }

        include_examples 'successful sign in with oauth details'
        it { expect(user.reload.invitation_accepted_at).to be_present }
      end

      context 'when the user logs in with a different email from the invitation' do
        let(:invitee_email) { 'no-invite@xyze.it' }
        let(:user) { oauth_user }

        include_examples 'successful sign in with oauth details'

        it { expect(user.reload.invitation_accepted_at).to be_blank }
      end
    end
  end
end
