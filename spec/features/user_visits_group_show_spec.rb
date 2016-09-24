RSpec.feature "UserVisitsGroupsPages", type: :feature do
  feature 'User vists groups page' do
    scenario 'successfully' do
      user = create :user1
      leader = create :user2
      login_as user
      group = create :group_with_member, userid: user.id
      meeting = create :meeting, groupid: group.id
      create :meeting_member, userid: user.id, meetingid: meeting.id
      create :group_leader, userid: leader.id, groupid: group.id

      visit group_path(group)

      expect(page.title).to match group.name
      expect(page).to have_content group.name
      expect(page).to have_content "Led by: #{leader.name}"
    end
  end
end
