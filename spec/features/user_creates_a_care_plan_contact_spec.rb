# frozen_string_literal: true

describe 'UserCreatesACarePlanContact', js: true do
  scenario 'unsuccessful' do
    user = create :user
    login_as user
    visit care_plan_path
    click_button('New Contact')
    find('#submit').click
    expect(page).to have_content 'This field cannot be empty!'
  end

  scenario 'successful' do
    user = create :user
    login_as user
    visit care_plan_path
    click_button('New Contact')
    find('input[aria-label="Name"]').set('Test1 Lastname')
    find('input[aria-label="Phone number"]').set('4160000000')
    find('#submit').click
    expect(page).to have_content 'Test1 Lastname'
    expect(page).to have_content '4160000000'
  end
end