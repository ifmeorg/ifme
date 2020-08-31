# frozen_string_literal: true

RSpec.describe 'GoogleCalendarEvent', type: :request do
  let(:user) { create(:user_oauth) }
  let(:meeting) { create(:meeting) }
  let(:calendar_uploader) { double }
  let!(:calendar_event) { double(id: 'someid') }
  let!(:exception_message) { 'Exception message' }

  before do
    sign_in user
    expect(CalendarUploader).to receive(:new).with(user.access_token).and_return(calendar_uploader)
  end

  describe '#create' do
    let!(:meeting_member) { create(:meeting_member, user_id: user.id, meeting_id: meeting.id) }

    context 'success' do
      it 'calls calendar_uploader#upload_event' do
        expect(calendar_uploader).to receive(:upload_event).with(meeting.name, meeting.date_time)
                                                           .and_return(calendar_event)

        post meeting_google_calendar_event_path(meeting_id: meeting.id)

        expect(meeting_member.reload.google_cal_event_id).to eq(calendar_event.id)

        expect(response).to redirect_to(group_path(meeting.group_id))
        expect(flash[:notice]).to eq(I18n.t('meetings.google_cal.create.success'))
      end
    end

    context 'error' do
      context 'raises client_error_exception' do
        it 'returns client_error_exception message' do
          expect(calendar_uploader).to receive(:upload_event).with(meeting.name, meeting.date_time)
                                                             .and_raise(Google::Apis::ClientError.new(exception_message))

          post meeting_google_calendar_event_path(meeting_id: meeting.id)

          expect(meeting_member.reload.google_cal_event_id).to eq(nil)
          expect(response).to redirect_to(group_path(meeting.group_id))

          message = I18n.t('meetings.google_cal.create.error') + ' ' + exception_message
          expect(flash[:alert]).to eq(message)
        end
      end
      context 'raises server_error_exception' do
        it 'returns server_error_exception message' do
          expect(calendar_uploader).to receive(:upload_event).with(meeting.name, meeting.date_time)
                                                             .and_raise(Google::Apis::ServerError.new(exception_message))

          post meeting_google_calendar_event_path(meeting_id: meeting.id)

          expect(meeting_member.reload.google_cal_event_id).to eq(nil)
          expect(response).to redirect_to(group_path(meeting.group_id))

          message = I18n.t('meetings.google_cal.create.error') + ' ' + exception_message
          expect(flash[:alert]).to eq(message)
        end
      end
    end
  end

  describe '#destroy' do
    let!(:meeting_member) { create(:meeting_member, user_id: user.id, meeting_id: meeting.id, google_cal_event_id: calendar_event.id) }
    let!(:remove_response) { double }

    context 'success' do
      it 'calls calendar_uploader#delete_event' do
        expect(calendar_uploader).to receive(:delete_event).with(calendar_event.id)
                                                           .and_return('')

        delete meeting_google_calendar_event_path(meeting_id: meeting.id)

        expect(meeting_member.reload.google_cal_event_id).to eq(nil)
        expect(response).to redirect_to(group_path(meeting.group_id))

        expect(flash[:notice]).to eq(I18n.t('meetings.google_cal.destroy.success'))
      end
    end

    context 'error' do
      context 'raises client_error_exception' do
        it 'calls returns client_error_exception message' do
          expect(calendar_uploader).to receive(:delete_event).with(calendar_event.id)
                                                             .and_raise(Google::Apis::ClientError.new(exception_message))

          delete meeting_google_calendar_event_path(meeting_id: meeting.id)

          expect(meeting_member.reload.google_cal_event_id).to eq(calendar_event.id)
          expect(response).to redirect_to(group_path(meeting.group_id))

          message = I18n.t('meetings.google_cal.destroy.error') + ' ' + exception_message
          expect(flash[:alert]).to eq(message)
        end
      end
      context 'raises server_error_exception' do
        it 'calls returns server_error_exception message' do
          expect(calendar_uploader).to receive(:delete_event).with(calendar_event.id)
                                                             .and_raise(Google::Apis::ServerError.new(exception_message))

          delete meeting_google_calendar_event_path(meeting_id: meeting.id)

          expect(meeting_member.reload.google_cal_event_id).to eq(calendar_event.id)
          expect(response).to redirect_to(group_path(meeting.group_id))

          message = I18n.t('meetings.google_cal.destroy.error') + ' ' + exception_message
          expect(flash[:alert]).to eq(message)
        end
      end
    end
  end
end
