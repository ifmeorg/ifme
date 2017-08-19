describe 'AddingMedication', js: true do
  let!(:user) { FactoryGirl.create(:user_oauth) }
  before do
    user.token = 'some token'
    user.access_expires_at = Time.zone.now + 600
    login_as user
    visit new_medication_path
  end

  it 'creates a new medication' do
    fill_in 'Name', with: 'A medication name'
    fill_in 'medication_comments', with: 'A comment'
    fill_in 'Strength', with: 100
    fill_in 'Total', with: 30
    fill_in 'Dosage', with: 2
    page.execute_script('$("#medication_refill").val("05/25/2016")')
    CalendarUploader.stub_chain(:new, :upload_event)
    expect(CalendarUploader).to_not receive(:new)
    click_on('Submit')
    expect(page).to have_content('A medication name')
    new_medication = user.medications.last
    expect(new_medication.name).to eq('A medication name')
    expect(new_medication.take_medication_reminder.active?).to eq(false)
    expect(new_medication.refill_reminder.active?).to eq(false)
  end

  context 'and turns on reminders' do
    it 'creates a new medication with reminders' do
      fill_in 'Name', with: 'A medication name'
      fill_in 'medication_comments', with: 'A comment'
      fill_in 'Strength', with: 100
      fill_in 'Total', with: 30
      fill_in 'Dosage', with: 2
      page.execute_script('$("#medication_refill").val("05/25/2016")')
      scroll_to_and_click('input#take_medication_reminder')
      scroll_to_and_click('input#refill_reminder')
      CalendarUploader.stub_chain(:new, :upload_event)
      expect(CalendarUploader).to_not receive(:new)
      click_on('Submit')
      expect(page).to have_content('A medication name')
      new_medication = user.medications.last
      expect(new_medication.take_medication_reminder.active?).to eq(true)
      expect(new_medication.refill_reminder.active?).to eq(true)
    end
  end

  it 'creates a new medication with Google Calendar reminder' do
    fill_in 'Name', with: 'A medication name'
    fill_in 'medication_comments', with: 'A comment'
    fill_in 'Strength', with: 100
    fill_in 'Total', with: 30
    fill_in 'Dosage', with: 30
    page.execute_script('$("#medication_refill").val("05/25/2016")')
    scroll_to_and_click('input#take_medication_reminder')
    scroll_to_and_click('input#refill_reminder')
    scroll_to_and_click('input#medication_add_to_google_cal')
    CalendarUploader.stub_chain(:new, :upload_event)
    expect(CalendarUploader).to receive_message_chain(:new, :upload_event)
    click_on('Submit')
    expect(page).to have_content('A medication name')
    new_medication = user.medications.last
    expect(new_medication.take_medication_reminder.active?).to eq(true)
    expect(new_medication.refill_reminder.active?).to eq(true)
  end

  context 'when uploader raises an error' do
    it 'redirects to sign in' do
      fill_in 'Name', with: 'A medication name'
      fill_in 'medication_comments', with: 'A comment'
      fill_in 'Strength', with: 100
      fill_in 'Total', with: 30
      fill_in 'Dosage', with: 30
      page.execute_script('$("#medication_refill").val("05/25/2016")')
      scroll_to_and_click('input#refill_reminder')
      scroll_to_and_click('input#medication_add_to_google_cal')
      CalendarUploader.stub_chain(:new, :upload_event).and_raise(StandardError.new('error'))
      click_on('Submit')
      expect(page).to have_content('Email')
      new_medication = user.medications.last
      expect(new_medication).to eq(nil)

    end
  end
end
