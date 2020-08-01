# frozen_string_literal: true

describe 'UserDeletesACarePlanContact', js: true do
  scenario 'successful' do
    user = create :user
    create :care_plan_contact, user_id: user.id
    login_as user
    visit care_plan_path
    expect(page).to have_content('Lovely Person')

    within '.story' do
      find('a[aria-label="Delete"]').click
    end

    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content('Lovely Person')
  end
end
