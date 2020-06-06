# frozen_string_literal: true

describe 'UserUpdatesACarePlanContact', js: true do
  scenario 'unsuccessful' do
    user = create :user
    create :care_plan_contact, user_id: user.id
    login_as user
    visit care_plan_path
    expect(page).to have_content('Lovely Person')

    within '.story' do
      find('a[aria-label="Edit"]').click
    end

    find('input[aria-label="Name"]').set('')
    find('#submit').click
    expect(page).to have_content 'This field cannot be empty!'
  end

  scenario 'successful' do
    user = create :user
    create :care_plan_contact, user_id: user.id
    login_as user
    visit care_plan_path
    expect(page).to have_content('Lovely Person')

    within '.story' do
      find('a[aria-label="Edit"]').click
    end

    find('input[aria-label="Name"]').set('Silly Person')
    find('input[aria-label="Phone number"]').set('4161234567')
    find('#submit').click
    expect(page).to have_content 'Silly Person'
    expect(page).to have_content '4161234567'
  end
end
