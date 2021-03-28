# frozen_string_literal: true

RSpec.feature 'UserDeletesAMomentTemplate', type: :feature, js: true do
  scenario 'successful' do
    user = create :user
    create :moment_template, user_id: user.id
    login_as user
    visit moment_templates_path
    expect(page).to have_content('Test Moment Template Name')

    within '.story' do
      find('a[aria-label="Delete"]').click
    end

    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content('Test Moment Template Name')
  end
end
