# frozen_string_literal: true
describe CalendarUploader do
  let(:service) { double }
  let(:uploader) { CalendarUploader.new('a token') }

  describe 'upload event' do
    context 'date is a string' do
      it 'uploads an event to Google Calendar' do
        uploader.calendar_service = service
        expect(service).to receive(:insert_event)
        uploader.upload_event('an exciting event', '2015/02/14')
      end
    end

    context 'date is a DateTime object' do
      it 'uploads an event to Google Calendar' do
        uploader.calendar_service = service
        expect(service).to receive(:insert_event)
        uploader.upload_event('an exciting event', DateTime.now.in_time_zone)
      end
    end
  end

  describe 'delete event' do
    context 'calls google calendar service delete_event' do
      it 'and removes event from google calendar' do
        uploader.calendar_service = service
        expect(service).to receive(:delete_event)
        uploader.delete_event('event_id')
      end
    end
  end
end
