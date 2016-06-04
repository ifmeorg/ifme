require 'rails_helper'

RSpec.feature "UserVisitsGroupsPages", type: :feature do
  feature 'User vists groups page' do
    scenario 'successfully' do
      user = create :user1
      login_as user
      group = create :group_with_member, userid: user.id
      ally = create :user2
      create :allyships_accepted, user_id: user.id, ally_id: ally.id
      available_group = create :group_with_member, userid: user.id

      visit groups_path

      expect(page).to have_content group.name
      expect(page).to have_content available_group.name
    end
  end
end
