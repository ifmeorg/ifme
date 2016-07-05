require 'rails_helper'

RSpec.feature "UserVisitsGroupsPages", type: :feature do
  feature 'User vists groups page' do
    scenario 'successfully' do
      user = create :user1
      login_as user
      group = create :group_with_member, userid: user.id
      meeting = create :meeting, groupid: group.id
      create :meeting_member, userid: user.id, meetingid: meeting.id

      visit group_path(group)

      expect(page.title).to match group.name
      expect(page).to have_content group.description
    end
  end
end
