require 'rails_helper'

RSpec.feature "UserVisitsGroupsPages", type: :feature do
  feature 'User vists groups page' do
    scenario 'successfully' do
      user = create :user1
      login_as user
      group = create :group_with_member, user_id: user.id
      meeting = create :meeting, group_id: group.id
      create :meeting_member, user_id: user.id, meeting_id: meeting.id

      visit group_path(group)

      expect(page).to have_content group.name
    end
  end
end
