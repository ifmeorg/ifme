# frozen_string_literal: true

RSpec.describe ::Meetings::GoogleCalendarEventController, type: :controller do
  include_context(:logged_in_user)
  let(:user) { create(:user_oauth) }
  let(:meeting) { create(:meeting) }
  let(:calendar_uploader) { double }

  describe '#create' do
    let!(:meeting_member) { create(:meeting_member, user_id: user.id, meeting_id: meeting.id) }
    let!(:calendar_event) { double(id: "someid") }

    it 'calls calendar_uploader#upload_event' do
      expect(CalendarUploader).to receive(:new).with(
        summary: meeting.name,
        date: meeting.date_time,
        access_token: user.google_access_token,
        email: user.email
      ).and_return(calendar_uploader)

      expect(calendar_uploader).to receive(:upload_event).and_return(calendar_event)

      post(:create, params: { meeting_id: meeting.id })

      expect(meeting_member.reload.google_cal_event_id).to eq(calendar_event.id)

      expect(response).to redirect_to(group_path(meeting.group_id))
      expect(flash[:notice]).to eq(I18n.t('meetings.google_cal.create.success'))
    end
  end

  describe '#destroy' do
    let!(:meeting_member) { create(:meeting_member, user_id: user.id, meeting_id: meeting.id, google_cal_event_id: "id1") }
    let!(:remove_response) { double }

    it 'calls calendar_uploader#delete_event' do
      expect(CalendarUploader).to receive(:new).with(
        summary: nil,
        date: nil,
        access_token: user.google_access_token,
        email: nil,
      ).and_return(calendar_uploader)

      expect(calendar_uploader).to receive(:delete_event).and_return(remove_response)

      delete(:destroy, params: { meeting_id: meeting.id })

      expect(meeting_member.reload.google_cal_event_id).to eq(nil)

      expect(response).to redirect_to(group_path(meeting.group_id))
      expect(flash[:notice]).to eq(I18n.t('meetings.google_cal.destroy.success'))
    end
  end
end
