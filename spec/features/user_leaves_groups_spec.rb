require 'rails_helper'

RSpec.feature "UserLeavesGroups", type: :feature do
  scenario "sucessfully" do
    user = create :user1
    login_as user
    group = create :group_with_member, user_id: user.id
    other_group_member = create :user2
    create :group_member, user_id: other_group_member.id, group_id: group.id
    visit groups_path

    click_link "Leave"

    expect(page).to have_content("You have left #{group.name}")
  end
end
