# frozen_string_literal: true

require 'zlib'

feature 'UserDownloadsData', type: :feature, js: true do
  let(:user) { create(:user1) }
  let!(:moment) { create(:moment, user_id: user.id, name: 'My Test Moment') }
  let!(:moment_comment) do
    create(:comment, commentable_type: 'Moment', commentable_id: moment.id,
                     comment_by: user.id, comment: 'A moment comment')
  end
  let!(:strategy) { create(:strategy, user_id: user.id, name: 'My Test Strategy') }
  let!(:strategy_comment) do
    create(:comment, commentable_type: 'Strategy', commentable_id: strategy.id,
                     comment_by: user.id, comment: 'A strategy comment')
  end

  before do
    login_as user
    visit edit_user_registration_path
  end

  scenario 'sees the download data button on the edit profile page' do
    expect(page).to have_button('Download my user data')
  end

  scenario 'clicking the button triggers a data request and shows processing state' do
    click_button('Download my user data')
    expect(page).to have_content('Your data is being prepared')
  end

  scenario 'shows a download link once the data is ready' do
    click_button('Download my user data')
    expect(page).to have_content('Your data is being prepared')
    expect(page).to have_css("a[href*='/users/data/download']", wait: 15)
  end

  scenario 'the generated CSV file contains the user data' do
    click_button('Download my user data')
    expect(page).to have_css("a[href*='/users/data/download']", wait: 15)

    data_request = Users::DataRequest.find_by(
      user_id: user.id,
      status_id: Users::DataRequest::STATUS[:success]
    )

    expect(data_request).not_to be_nil
    csv_content = Zlib::GzipReader.new(StringIO.new(data_request.file_data)).read

    expect(csv_content).to include(user.email)
    expect(csv_content).to include('My Test Moment')
    expect(csv_content).to include('A moment comment')
    expect(csv_content).to include('My Test Strategy')
    expect(csv_content).to include('A strategy comment')
  end
end
