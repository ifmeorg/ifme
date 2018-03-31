#frozen_string_literal: true

RSpec.feature "UserAuthwithFacebook", type: :feature do
  OmniAuth.config.test_mode = true

  def mock_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: "facebook",
      uid: "12345678910",
      info: ({
        email: "janedoe@ifme.com",
        name: "Jane Doe"
      }),
      credentials: ({
        token: "abcde",
        expires_at: Time.zone.now.to_i,
        refresh_token: "12345abcdefg"
      }),
    })
  end

  before(:each) do
    mock_auth_hash
  end

  after(:each) do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  def log_in
    visit root_path
    click_link('Sign in', match: :first)
    click_on 'Sign in with Facebook'
  end

  scenario 'successfully' do
    log_in

    expect(page).to have_content 'Hello Jane Doe!'
    expect(page).to have_content 'Sign out'
  end

  scenario 'user cannot sign in with invalid account' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    log_in
    expect(current_path).to eql(new_user_session_path)
    expect(page).to have_content('Could not authenticate you from Facebook because "Invalid credentials"')
  end

  scenario 'user signs out successfully' do
    log_in

    click_link('Sign out', match: :first)
    expect(page).to have_content 'Signed out'
  end
end
