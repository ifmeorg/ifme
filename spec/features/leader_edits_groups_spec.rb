require 'rails_helper'

RSpec.feature "LeaderEditsGroups", type: :feature do
  scenario 'successfully' do
    user = create :user
    login_as user
    group = create :group_with_member, userid: user.id, leader: true
    visit edit_group_path(group)

    expect(page).to have_content("Edit #{group.name}")
  end
end
