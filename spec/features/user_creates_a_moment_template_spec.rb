# frozen_string_literal: true

RSpec.feature 'UserCreatesAMomentTemplate', type: :feature, js: true do
  scenario 'unsuccessful' do
    user = create :user
    login_as user
    visit moment_templates_path
    click_button('New Template')
    find('#submit').click
    expect(page).to have_content 'This field cannot be empty!'
  end

  scenario 'successful' do
    user = create :user
    login_as user
    visit moment_templates_path
    click_button('New Template')
    find('input[aria-label="Name"]').set('Template Name')
    fill_in_textarea('Some template description', '#moment_template_description')
    find('#submit').click
    expect(page).to have_content 'Template Name'

    within '.story' do
      find('a[aria-label="Edit"]').click
    end

    expect(page).to have_content 'Some template description'
  end
end