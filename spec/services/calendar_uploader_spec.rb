describe CalendarUploader do
  it "uploads an event to Google Calendar" do
    uploader = CalendarUploader.new(summary: "an exciting event", date: "2015/02/14", access_token: "a token", email: "an email")
    service = double
    allow(service).to receive_message_chain(:events, :insert)
    client = double
    allow(uploader).to receive(:client) { client }
    allow(client).to receive_message_chain(:authorization, :access_token=)

    expect(client).to receive(:authorization)
    expect(client).to receive(:discovered_api).with('calendar', 'v3') { service}
    expect(client).to receive(:execute!)
    uploader.upload_event
  end
end
