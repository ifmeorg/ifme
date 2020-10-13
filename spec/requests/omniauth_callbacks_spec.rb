# frozen_string_literal: true

describe 'OmniauthCallbacks', type: :request do
  let(:oauth_email) { 'example@xyze.it' }
  let(:oauth_token) { 'abcdefg12345' }

  def invite_user(email)
    inviter = create(:user)
    User.invite!({ email: email }, inviter).tap do |invitee|
      set_invitation_token_env(invitee)
    end
  end

  describe 'GET #google_oauth2' do
    before do
      set_devise_mapping_env
      set_omniauth_auth_env(provider: 'google_oauth2', email: oauth_email, token: oauth_token)
    end

    context "when google_oauth2 email doesn't exist in the system" do
      it 'creates user with info in google_oauth2' do
        get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

        user = User.find_by(email: oauth_email)
        expect(user).to be_present
      end

      it 'signs in and redirects to root' do
        get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

        expect(response).to redirect_to root_path
      end

      it 'enables oauth on user' do
        get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

        user = User.find_by(email: oauth_email)
        expect(user.oauth_enabled?).to eq true
      end
    end

    context 'when google_oauth2 email already exists in the system without token' do
      it 'updates the user with google_oauth2 credentials' do
        user = create(:user, email: oauth_email, token: nil)

        get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

        expect(user.reload.token).to eq oauth_token
      end

      it 'signs in and redirects to root' do
        create(:user, email: oauth_email, token: nil)

        get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

        expect(response).to redirect_to root_path
      end

      it 'enables oauth on user' do
        user = create(:user, email: oauth_email, token: nil)

        expect {
          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }
        }.to change {
          user.reload.oauth_enabled?
        }.from(false).to(true)
      end
    end

    context 'when google_oauth2 enabling fails' do
      it 'redirects to sign in path' do
        allow(User).to receive(:find_for_oauth).and_return(nil)

        get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when an invitation_token is passed in' do
      context 'when the user logs in with the same email as the invitation' do
        it 'sets invitation accepted at on invitee' do
          invitee = invite_user(oauth_email)

          expect {
            get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }
          }.to change {
            invitee.reload.invitation_accepted_at
          }.from(nil).to(ActiveSupport::TimeWithZone)
        end

        it 'signs in and redirects to root' do
          invite_user(oauth_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          expect(response).to redirect_to root_path
        end

        it 'enables oauth on user' do
          invitee = invite_user(oauth_email)

          expect {
            get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }
          }.to change {
            invitee.reload.oauth_enabled?
          }.from(false).to(true)
        end
      end

      context 'when the user logs in with a different email from the invitation' do
        let(:other_invitee_email) { 'no-invite@xyze.it' }

        it 'does set not invitation accepted at on invitee' do
          invite_user(other_invitee_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          invitee = User.find_by(email: oauth_email)
          expect(invitee.invitation_accepted_at).to be_blank
        end

        it 'signs in and redirects to root' do
          invite_user(other_invitee_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          expect(response).to redirect_to root_path
        end

        it 'enables oauth on user' do
          invite_user(other_invitee_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          user = User.find_by(email: oauth_email)
          expect(user.oauth_enabled?).to eq true
        end
      end
    end

    context 'when user avatar image is uploaded' do
      context 'when third party avatar is not nil' do
        it 'uploads avatar when third_party_avatar has changed' do
          user = create(:user, email: oauth_email, third_party_avatar: 'http://example.com/images/some-image.jpeg')
          avatar_image_url = 'http://example.com/images/different_profile.jpeg'
          set_avatar_env(avatar_image_url)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          expect(user.reload.third_party_avatar).to eq(avatar_image_url)
        end

        it 'uploads avatar when third_party_avatar is nil' do
          user = create(:user, email: oauth_email, third_party_avatar: nil)
          avatar_image_url = 'http://example.com/images/different_profile.jpeg'
          set_avatar_env(avatar_image_url)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          expect(user.reload.third_party_avatar).to eq(avatar_image_url)
        end

        it 'does not upload third party avatar if current avatar is the same' do
          avatar_image_url = 'http://example.com/images/profile.jpeg'
          user = create(:user, email: oauth_email, third_party_avatar: avatar_image_url)
          set_avatar_env(avatar_image_url)

          expect {
            get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }
          }.not_to change {
            user.reload.third_party_avatar
          }
        end
      end

      context 'when third party avatar is nil' do
        it 'does not set third_party_avatar' do
          set_avatar_env(nil)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'google' }

          user = User.find_by(email: oauth_email)
          expect(user.third_party_avatar).to be_nil
        end
      end
    end
  end

  describe 'GET #facebook' do
    before do
      set_devise_mapping_env
      set_omniauth_auth_env(provider: 'facebook', email: oauth_email, token: oauth_token)
    end

    context "when facebook email doesn't exist in the system" do
      it 'creates user with info in facebook' do
        get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

        user = User.find_by(email: oauth_email)
        expect(user).to be_present
      end

      it 'signs in and redirects to root' do
        get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

        expect(response).to redirect_to root_path
      end

      it 'enables oauth on user' do
        get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

        user = User.find_by(email: oauth_email)
        expect(user.oauth_enabled?).to eq true
      end
    end

    context 'when facebook email already exists in the system and token is nil' do
      it 'updates the user with facebook credentials' do
        user = create(:user, email: oauth_email, token: nil)

        get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

        expect(user.reload.token).to eq oauth_token
      end

      it 'signs in and redirects to root' do
        create(:user, email: oauth_email, token: nil)

        get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

        expect(response).to redirect_to root_path
      end

      it 'enables oauth on user' do
        user = create(:user, email: oauth_email, token: nil)

        expect {
          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }
        }.to change {
          user.reload.oauth_enabled?
        }.from(false).to(true)
      end
    end

    context 'when facebook enabling fails' do
      it 'redirects to sign in path' do
        allow(User).to receive(:find_for_oauth).and_return(nil)

        get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when an invitation_token is passed in' do
      context 'when the user logs in with the same email as the invitation' do
        it 'sets invitation accepted at on invitee' do
          invitee = invite_user(oauth_email)

          expect {
            get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }
          }.to change {
            invitee.reload.invitation_accepted_at
          }.from(nil).to(ActiveSupport::TimeWithZone)
        end

        it 'signs in and redirects to root' do
          invite_user(oauth_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          expect(response).to redirect_to root_path
        end

        it 'enables oauth on user' do
          invitee = invite_user(oauth_email)

          expect {
            get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }
          }.to change {
            invitee.reload.oauth_enabled?
          }.from(false).to(true)
        end
      end

      context 'when the user logs in with a different email from the invitation' do
        let(:other_invitee_email) { 'no-invite@xyze.it' }

        it 'does set not invitation accepted at on invitee' do
          invite_user(other_invitee_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          invitee = User.find_by(email: oauth_email)
          expect(invitee.invitation_accepted_at).to be_blank
        end

        it 'signs in and redirects to root' do
          invite_user(other_invitee_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          expect(response).to redirect_to root_path
        end

        it 'enables oauth on user' do
          invite_user(other_invitee_email)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          user = User.find_by(email: oauth_email)
          expect(user.oauth_enabled?).to eq true
        end
      end
    end

    context 'when user avatar image is uploaded' do
      context 'when third party avatar is not nil' do
        it 'uploads avatar when third_party_avatar has changed' do
          user = create(:user, email: oauth_email, third_party_avatar: 'http://example.com/images/some-image.jpeg')
          avatar_image_url = 'http://example.com/images/different_profile.jpeg'
          set_avatar_env(avatar_image_url)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          expect(user.reload.third_party_avatar).to eq(avatar_image_url)
        end

        it 'uploads avatar when third_party_avatar is nil' do
          user = create(:user, email: oauth_email, third_party_avatar: nil)
          avatar_image_url = 'http://example.com/images/different_profile.jpeg'
          set_avatar_env(avatar_image_url)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          expect(user.reload.third_party_avatar).to eq(avatar_image_url)
        end

        it 'does not upload third party avatar if current avatar is the same' do
          avatar_image_url = 'http://example.com/images/profile.jpeg'
          user = create(:user, email: oauth_email, third_party_avatar: avatar_image_url)
          set_avatar_env(avatar_image_url)

          expect {
            get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }
          }.not_to change {
            user.reload.third_party_avatar
          }
        end
      end

      context 'when third party avatar is nil' do
        it 'does not set third_party_avatar' do
          set_avatar_env(nil)

          get omniauth_login_omniauth_callbacks_path, params: { provider: 'facebook' }

          user = User.find_by(email: oauth_email)
          expect(user.third_party_avatar).to be_nil
        end
      end
    end
  end
end
