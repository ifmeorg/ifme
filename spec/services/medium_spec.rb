# frozen_string_literal: true

describe Medium do
  subject { Medium.new.posts }

  context 'when the API is available' do
    let(:response_json) do
      { 'items' => [{ 'title' => 'Test Post', 'link' => 'https://medium.com/ifme/test', 'author' => 'Test Author' }] }.to_json
    end

    before do
      allow(URI).to receive(:open).and_yield(StringIO.new(response_json))
    end

    it 'returns posts with title and link' do
      expect(subject.first['title']).to be_truthy
      expect(subject.first['link']).to be_truthy
    end
  end

  context 'when the API returns a 429 Too Many Requests error' do
    before do
      allow(URI).to receive(:open).and_raise(
        OpenURI::HTTPError.new('429 Too Many Requests', StringIO.new)
      )
    end

    it 'returns an empty array' do
      expect(subject).to eq([])
    end
  end

  context 'when a network error occurs' do
    before do
      allow(URI).to receive(:open).and_raise(SocketError)
    end

    it 'returns an empty array' do
      expect(subject).to eq([])
    end
  end

  context 'when the response is not valid JSON' do
    before do
      allow(URI).to receive(:open).and_yield(StringIO.new('not valid json'))
    end

    it 'returns an empty array' do
      expect(subject).to eq([])
    end
  end
end
