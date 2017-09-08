# frozen_string_literal: true

describe CalendarUploader do
  it 'uploads an event to Google Calendar' do
    service = double
    allow(service).to receive_message_chain(:insert_event)
    allow(service).to receive_message_chain(:authorization=, :access_token=)

    uploader = CalendarUploader.new(summary: 'an exciting event',
                                    date: '2015/02/14',
                                    access_token: 'a token',
                                    email: 'an email',
                                    service: service)

    expect(service).to receive(:insert_event)

    uploader.upload_event
  end
end
