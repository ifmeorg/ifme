describe 'UserCreatesGroups' do
  scenario 'successfully' do
    user = create :user
    login_as user
    visit new_group_path
    fill_in 'Name', with: 'A Group'
    fill_in 'Description', with: 'A Group Description'
    click_on 'Create Group'

    expect(page).to have_content 'A Group Description'
  end

  scenario 'unsucessfully' do
    user = create :user
    login_as user
    visit new_group_path
    click_on 'Create Group'

    expect(page).to have_content "Name can't be blank"
  end
end
