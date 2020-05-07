# frozen_string_literal: true

describe 'Display of recommended resource links', js: true do
  let(:user) { create :user }

  scenario 'User allows' do
    login_as user
    moment = create :moment, user_id: user.id, name: 'Teachers', resource_recommendations: 'true'
    visit moment_path(moment)
    expect(page).to have_content 'Insight Timer'
  end

  scenario 'User does not allow' do
    login_as user
    moment = create :moment, user_id: user.id, name: 'Teachers', resource_recommendations: 'false'
    visit moment_path(moment)
    expect(page).not_to have_content 'Insight Timer'
  end
end
