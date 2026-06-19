# frozen_string_literal: true

require 'sidekiq/testing'
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

  # Use fake mode so perform_async enqueues locally without touching Redis.
  around do |example|
    Sidekiq::Testing.fake!
    example.run
  ensure
    ProcessDataRequestWorker.clear
    Sidekiq::Testing.disable!
  end

  before do
    login_as user
    visit edit_user_registration_path
  end

  # The widget sets status='enqueued' optimistically on click — before the POST
  # response arrives — so "Your data is being prepared" appears in the browser
  # before the server has processed anything. Polling DataRequest.exists? is not
  # sufficient because after_commit (which enqueues the job) fires after the
  # transaction commits but could be preempted before perform_async is called.
  # Polling the fake job queue directly is the reliable signal.
  def wait_for_job_queued(timeout: 10)
    Timeout.timeout(timeout) do
      loop do
        break if ProcessDataRequestWorker.jobs.any?
        sleep 0.1
      end
    end
  end

  scenario 'sees the download data button on the edit profile page' do
    expect(page).to have_button('Download my user data')
  end

  scenario 'clicking the button triggers a data request and shows processing state' do
    click_button('Download my user data')
    expect(page).to have_content('Your data is being prepared')
  end

  scenario 'shows a download link once the data is ready' do
    data_request = nil

    click_button('Download my user data')
    expect(page).to have_content('Your data is being prepared')

    # Wait for the job to appear in the fake queue, then run it.
    wait_for_job_queued
    ProcessDataRequestWorker.drain

    data_request = Users::DataRequest.find_by(
      user_id: user.id,
      status_id: Users::DataRequest::STATUS[:success]
    )

    # Browser polls every 3s; after drain the next poll returns current_status: 2
    # and the widget renders the download link.
    expect(page).to have_selector(
      "a[href='/users/data/download?request_id=#{data_request.request_id}']",
      wait: 15
    )
  ensure
    data_request&.reload
    File.delete(data_request.file_path) if data_request&.file_path && File.exist?(data_request.file_path.to_s)
  end

  scenario 'the generated CSV file contains the user data' do
    data_request = nil

    click_button('Download my user data')
    expect(page).to have_content('Your data is being prepared')

    wait_for_job_queued
    ProcessDataRequestWorker.drain

    data_request = Users::DataRequest.find_by(
      user_id: user.id,
      status_id: Users::DataRequest::STATUS[:success]
    )

    expect(data_request).not_to be_nil
    csv_content = Zlib::GzipReader.open(data_request.file_path, &:read)

    expect(csv_content).to include(user.email)
    expect(csv_content).to include('My Test Moment')
    expect(csv_content).to include('A moment comment')
    expect(csv_content).to include('My Test Strategy')
    expect(csv_content).to include('A strategy comment')
  ensure
    File.delete(data_request.file_path) if data_request&.file_path && File.exist?(data_request.file_path.to_s)
  end
end
