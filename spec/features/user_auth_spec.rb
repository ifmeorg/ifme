# frozen_string_literal: true

RSpec.feature 'UserAuthLogin', type: :feature, js: true do
  context 'when user has not confirmable yet and tries to login' do
    scenario 'successful logs in' do
      user = create :user_oauth, :unconfirmable
      login_as user

      visit moments_path

      expect(page.body).to_not have_content("confirm your email")
      expect(page).to have_current_path moments_path
    end
  end
end
