RSpec.feature 'UserUpdatesGroups', type: :feature do
  scenario 'leader removes another leader' do
    leader = create :user1
    login_as leader
    other_leader = create :user2
    group = create :group
    create :group_member, user: leader, group: group, leader: true
    create :group_member, user: other_leader, group: group, leader: true

    visit edit_group_path(group)
    uncheck "group_leader_#{other_leader.id}"
    click_button 'Update Group'

    expect(group.leaders).to eq [leader]
  end

  scenario 'leader adds another leader' do
    leader = create :user1
    login_as leader
    other_user = create :user2
    group = create :group
    create :group_member, user: leader, group: group, leader: true
    create :group_member, user: other_user, group: group, leader: false

    visit edit_group_path(group)
    check "group_leader_#{other_user.id}"
    click_button 'Update Group'

    expect(group.leaders).to include(other_user)
  end
end
