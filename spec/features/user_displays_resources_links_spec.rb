# frozen_string_literal: true

describe 'Display of recommended resource links', js: true do
  let(:user) { create :user2, :with_allies }
  scenario 'User allows' do
    login_as user
    moment = create :moment, user_id: user.id, name: 'Teachers', resource_recommendations: 'true'
    visit moment_path(moment)
    expect(page).to have_content 'Insight Timer'
  end
end
