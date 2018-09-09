describe 'UserCreatesAMedication', js: true do
  let(:user) { create(:user_oauth) }
  let(:medication) { user.medications.last }
  let(:name) { 'A medication name' }

  before do
    login_as user
    visit new_medication_path
  end

  context 'invalid form input' do
    it 'does not create a new Medication' do
      click_on 'Submit'
      expect(page).to have_content('New Medication')
      expect(page).to have_css('label.alertText')
    end
  end

  context 'valid form input' do
    before do
      CalendarUploader.stub_chain(:new, :upload_event)
      fill_in 'Name', with: name
      fill_in 'medication_comments', with: 'A comment'
      fill_in 'Strength', with: 100
      fill_in 'Total', with: 30
      fill_in 'Dosage', with: 2
      page.execute_script('$("#medication_refill").val("05/25/2016")')
    end

    it 'creates a new medication' do
      expect(CalendarUploader).to_not receive(:new)

      click_on('Submit')

      within '.pageTitle' do
        expect(page).to have_content(name)
      end
      expect(medication.name).to eq(name)
      expect(medication.take_medication_reminder.active?).to be false
      expect(medication.refill_reminder.active?).to be false
    end

    context 'with reminders checked' do
      it 'activates reminders' do
        scroll_to_and_click('#take_medication_reminder')
        scroll_to_and_click('#refill_reminder')

        expect(CalendarUploader).to_not receive(:new)

        click_on('Submit')
        expect(find('.pageTitle')).to have_content(name)

        expect(medication.take_medication_reminder.active?).to be true
        expect(medication.refill_reminder.active?).to be true
      end
    end

    context 'with Google Calendar reminders checked' do
      it 'activates reminders' do
        scroll_to_and_click('#take_medication_reminder')
        scroll_to_and_click('#refill_reminder')
        scroll_to_and_click('#medication_add_to_google_cal')

        expect(CalendarUploader).to receive_message_chain(:new, :upload_event)

        click_on('Submit')
        expect(find('.pageTitle')).to have_content(name)

        expect(medication.take_medication_reminder.active?).to be true
        expect(medication.refill_reminder.active?).to be true
      end
    end

    context 'when uploader raises an error' do
      before do
        CalendarUploader.stub_chain(:new, :upload_event).and_raise(StandardError)
      end

      it 'redirects to sign in' do
        scroll_to_and_click('#refill_reminder')
        scroll_to_and_click('#medication_add_to_google_cal')

        click_on('Submit')

        expect(find('#new_user')).to be_present
        expect(medication).to be nil
      end
    end
  end
end
