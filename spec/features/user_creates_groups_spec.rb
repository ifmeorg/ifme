# frozen_string_literal: true

describe 'UserCreatesGroups', js: true do
  scenario 'successful' do
    user = create :user
    login_as user
    visit new_group_path
    find('#group_name').set('A Group')
    fill_in_textarea('A Group Description', '#group_description')
    find('#submit').click
    expect(page).to have_content 'A Group Description'
  end

  scenario 'unsuccessful' do
    user = create :user
    login_as user
    visit new_group_path
    find('#submit').click
    expect(page).to have_content 'New Group'
    expect(page).to have_css('.labelError')
  end
end
