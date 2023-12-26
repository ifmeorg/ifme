# frozen_string_literal: true

describe Medium do
  subject { Medium.new.posts }

  it 'retrieve Medium posts from API' do
    expect(subject.first['title']).to be_truthy
    expect(subject.first['link']).to be_truthy
  end
end
