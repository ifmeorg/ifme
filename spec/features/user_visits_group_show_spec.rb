RSpec.feature "UserVisitsGroupsPages", type: :feature do
  feature 'User vists groups page' do
    scenario 'successfully' do
      user = create :user1
      leader = create :user2
      login_as user
      group = create :group_with_member, user_id: user.id
      meeting = create :meeting, group_id: group.id
      create :meeting_member, user_id: user.id, meetingid: meeting.id
      create :group_leader, user_id: leader.id, group_id: group.id

      visit group_path(group)

      expect(page.title).to match group.name
      expect(page).to have_content group.name
      expect(page).to have_content "Led by: #{leader.name}"
    end
  end
end
