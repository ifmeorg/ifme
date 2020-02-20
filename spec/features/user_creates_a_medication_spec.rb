# frozen_string_literal: true

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
      find('#submit').click
      expect(page).to have_content('New Medication')
      expect(page).to have_css('.labelError')
    end
  end

  context 'valid form input' do
    before do
      CalendarUploader.stub_chain(:new, :upload_event)
      find('#medication_name').set(name)
      fill_in_textarea('A comment', '#medication_comments')
      find('#medication_strength').set(100)
      find('#medication_total').set(30)
      find('#medication_dosage').set(2)
      find('#medication_refill').set('2018-09-14')
    end

    it 'creates a new medication' do
      find('#submit').click
      expect(CalendarUploader).to_not receive(:new)

      within '.pageTitle' do
        expect(page).to have_content(name)
      end

      expect(medication.name).to eq(name)
      expect(medication.take_medication_reminder.active?).to be false
      expect(medication.refill_reminder.active?).to be false
    end

    context 'with reminders checked' do
      it 'activates reminders' do
        find('#medication_refill_reminder_attributes').click
        find('#medication_take_medication_reminder_attributes').click
        find('#submit').click
        expect(CalendarUploader).to_not receive(:new)
        expect(find('.pageTitle')).to have_content(name)
        expect(medication.take_medication_reminder.active?).to be true
        expect(medication.refill_reminder.active?).to be true
      end
    end

    context 'with Google Calendar reminders checked' do
      before do
        CalendarUploader.stub_chain(:new, :upload_event).and_return(true)
      end

      it 'activates reminders' do
        find('#medication_refill_reminder_attributes').click
        find('#medication_take_medication_reminder_attributes').click
        find('#medication_add_to_google_cal').click
        expect(CalendarUploader).to receive_message_chain(:new, :upload_event)
        find('#submit').click
        expect(find('.pageTitle')).to have_content(name)
        expect(medication.take_medication_reminder.active?).to be true
        expect(medication.refill_reminder.active?).to be true
      end
    end

    context 'when uploader raises an error' do
      before do
        CalendarUploader.stub_chain(:new, :upload_event)
                        .and_raise(Google::Apis::ClientError.new('error'))
      end

      it 'redirects to sign in' do
        find('#medication_refill_reminder_attributes').click
        find('#medication_add_to_google_cal').click
        find('#submit').click
        expect(find('#new_user')).to be_present
        expect(medication).to be nil
      end
    end
  end
end
