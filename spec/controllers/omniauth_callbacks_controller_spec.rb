# frozen_string_literal: true

RSpec.describe OmniauthCallbacksController, type: :controller do
  shared_examples 'successful sign in with oauth details' do
    it 'should sign in and redirect to root' do
      expect(subject.current_user).to eq user
      expect(response).to redirect_to('/')
    end

    it 'should create authentication with auth_method('google')' do
      expect(user.reload.oauth_enabled?).to eq true
    end

    it 'should create authentication with facebook' do
      expect(user.reload.oauth_enabled?).to eq true
    end
  end

  describe 'GET #auth_method('google')' do
    before { stub_env_for_omniauth }
    let(:oauth_email) { request.env['omniauth.auth']['info']['email'] }
    let(:oauth_user) { User.find_by(email: oauth_email) }

    context 'when auth_method('google') email doesnt exist in the system' do
      let(:user) { oauth_user }

      before { get :auth_method('google') }

      it 'creates user with info in auth_method('google')' do
        expect(user.name).to eq 'Test User'
      end

      include_examples 'successful sign in with oauth details'
    end

    context 'when auth_method('google') email already exist in the system' do
      let!(:user) { create(:user, email: 'example@xyze.it') }

      before { get :auth_method('google') }

      it 'updates the user with auth_method('google') credentials' do
        expect(user.reload.token).to eq 'abcdefg12345'
      end

      include_examples 'successful sign in with oauth details'
    end

    context 'when auth_method('google') enabling fails' do
      before do
        stub_env_for_omniauth
        allow(User).to receive(:find_for_oauth)
          .with(request.env['omniauth.auth']).and_return(nil)
        get :auth_method('google')
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
        get :auth_method('google')
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

    context 'user avatar image uploads' do
      before { stub_env_for_omniauth }
      let(:oauth_email) { request.env['omniauth.auth']['info']['email'] }
      let(:oauth_user) { User.find_by(email: oauth_email) }
      let(:user) { oauth_user }
      before { get :auth_method('google') }

      context 'when third party avatar is not nil' do
        it 'uploads avatar when third_party_avatar has changed' do
          new_avatar = 'http://example.com/images/different_profile.jpeg'
          request.env['omniauth.auth']['info']['image'] = new_avatar
          get :auth_method('google')

          expect(user.third_party_avatar).to eq(new_avatar)
        end

        it 'uploads avatar when third_party_avatar is nil' do
          expect(user.third_party_avatar).to eq(request.env['omniauth.auth']['info']['image'])
        end

        it 'does not upload third party avatar if current avatar is the same' do
          third_party_avatar = request.env['omniauth.auth']['info']['image']
          expect(user).not_to receive(:third_party_avatar=)
        end
      end

      context 'when third party avatar is nil' do
        it 'does not set third_party_avatar' do
          request.env['omniauth.auth']['info']['image'] = nil
          expect(user).not_to receive(:third_party_avatar=)
        end
      end
    end
  end

  describe 'GET #facebook' do
    before { stub_env_for_omniauth_fb }
    let(:oauth_email) { request.env['omniauth.auth']['info']['email'] }
    let(:oauth_user) { User.find_by(email: oauth_email) }

    context 'when facebook email doesnt exist in the system' do
      let(:user) { oauth_user }

      before { get :auth_method('facebook') }

      it 'creates user with info in facebook' do
        expect(user.name).to eq 'Test User'
      end

      include_examples 'successful sign in with oauth details'
    end

    context 'when facebook email already exist in the system' do
      let!(:user) { create(:user, email: 'example@xyze.it') }

      before { get :auth_method('facebook') }

      it 'updates the user with facebook credentials' do
        expect(user.reload.token).to eq 'abcdefg12345'
      end

      include_examples 'successful sign in with oauth details'
    end

    context 'when facebook enabling fails' do
      before do
        stub_env_for_omniauth_fb
        allow(User).to receive(:find_for_oauth)
          .with(request.env['omniauth.auth']).and_return(nil)
        get :auth_method('facebook')
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
        get :auth_method('facebook')
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

    context 'user avatar image uploads' do
      before { stub_env_for_omniauth_fb }
      let(:oauth_email) { request.env['omniauth.auth']['info']['email'] }
      let(:oauth_user) { User.find_by(email: oauth_email) }
      let(:user) { oauth_user }
      before { get :auth_method('facebook') }

      context 'when third party avatar exists' do
        it 'uploads avatar when third_party_avatar has changed' do
          new_avatar = 'http://example.com/images/different_profile.jpeg'
          request.env['omniauth.auth']['info']['image'] = new_avatar
          get :auth_method('facebook')

          expect(user.third_party_avatar).to eq(new_avatar)
        end

        it 'uploads avatar when third_party_avatar is nil' do
          expect(user.third_party_avatar).to eq(request.env['omniauth.auth']['info']['image'])
        end

        it 'does not upload third party avatar if current avatar is the same' do
          third_party_avatar = request.env['omniauth.auth']['info']['image']
          expect(user).not_to receive(:third_party_avatar=)
        end
      end


      context 'when third party avatar is nil' do
        it 'does not set third_party_avatar' do
          request.env['omniauth.auth']['info']['image'] = nil
            expect(user).not_to receive(:third_party_avatar=)
          end
        end
      end
    end
  end
