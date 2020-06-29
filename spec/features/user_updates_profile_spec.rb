# frozen_string_literal: true

describe 'UserUpdatesProfile', js: true do
  let(:new_password) { "foobar_w!th_Password" }

  describe 'user logged in with Google OAuth' do
    let(:user_google) { create(:user_oauth, provider: 'google_oauth2') }

    feature 'Updating password' do
      it 'is successful' do
        login_as user_google
        visit edit_user_registration_path

        find('#user_password').set(new_password)
        find('#user_password_confirmation').set(new_password)
        find('#submit').click

        expect(page).to have_content 'Your account has been updated successfully.'
      end
    end
  end

  describe 'user logged in with Facebook OAuth' do
    let(:user_facebook) { create(:user_oauth, provider: 'facebook') }

    feature 'Updating password' do
      it 'is successful' do
        login_as user_facebook
        visit edit_user_registration_path

        find('#user_password').set(new_password)
        find('#user_password_confirmation').set(new_password)
        find('#submit').click

        expect(page).to have_content 'Your account has been updated successfully.'
      end
    end
  end
end
