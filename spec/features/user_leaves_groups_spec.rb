RSpec.feature 'UserLeavesGroups', type: :feature, js: true do
  scenario 'user leaves group that they belong to' do
    user = create :user1
    login_as user
    group = create :group_with_member, user_id: user.id
    other_group_member = create :user2
    create :group_member, user_id: other_group_member.id, group_id: group.id
    visit groups_path
    click_link 'Leave'
    expect(page).to have_content("You have left #{group.name}")
    expect(current_path).to eq(groups_path)
  end

  scenario 'user removes other member from group' do
    leader = create :user1
    login_as leader
    group = create :group_with_member, user_id: leader.id, leader: true
    other_member = create :user2
    create :group_member, user_id: other_member.id, group_id: group.id
    visit groups_path
    find('.groupMembersButton').click
    click_link 'Remove'
    expect(page).to have_content(
      "You have removed #{other_member.name} from #{group.name}")
    expect(current_path).to eq(groups_path)
  end
end
