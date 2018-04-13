#frozen_string_literal: true

RSpec.feature "UserAuthwithFacebook", js: true, type: :feature do
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
    within('span#title_expand') { find('i.expand').click }
    within('ul#expand_me') { find('a[href="/users/sign_out"]').click }
  end

  scenario 'user cannot sign in with invalid account' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    log_in
    expect(current_path).to eql(new_user_session_path)
    expect(page).to have_content('Could not authenticate you from Facebook because "Invalid credentials"')
  end

  scenario 'user signs out successfully' do
    log_in

     within('span#title_expand') { find('i.expand').click }
    within('ul#expand_me') { find('a[href="/users/sign_out"]').click }
    expect(page).to have_content 'if me is a community for mental health experiences More communities need mental health support.'
  end
end
