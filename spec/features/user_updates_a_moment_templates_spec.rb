# frozen_string_literal: true

feature 'UserUpdatesAMomentTemplate', type: :feature, js: true do
  scenario 'unsuccessful' do
    user = create :user
    create :moment_template, user_id: user.id
    login_as user
    visit moment_templates_path
    expect(page).to have_content('Test Moment Template Name')

    within '.story' do
      find('a[aria-label="Edit"]').click
    end

    find('input[aria-label="Name"]').set('')
    find('#submit').click
    expect(page).to have_content 'This field cannot be empty!'
  end

  scenario 'successful' do
    user = create :user
    create :moment_template, user_id: user.id
    login_as user
    visit moment_templates_path
    expect(page).to have_content('Test Moment Template Name')

    within '.story' do
      find('a[aria-label="Edit"]').click
    end

    find('input[aria-label="Name"]').set('Template Name')
    fill_in_textarea('Some template description', '#moment_template_description')
    find('#submit').click
    expect(page).to have_content 'Template Name'

    within '.story' do
      click_button('Template Name')
    end

    expect(page).to have_content 'Some template description'
  end
end
