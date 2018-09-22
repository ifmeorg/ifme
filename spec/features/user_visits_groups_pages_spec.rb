# frozen_string_literal: true

RSpec.feature 'UserVisitsGroupsPages', type: :feature, js: true do
  feature 'User vists groups page' do
    scenario 'successfully' do
      user = create :user1
      login_as user
      group = create :group_with_member, user_id: user.id
      ally = create :user2
      create :allyships_accepted, user_id: user.id, ally_id: ally.id
      available_group = create :group_with_member, user_id: user.id

      visit groups_path

      expect(page).to have_content group.name
      expect(page).to have_content available_group.name
    end
  end
end
