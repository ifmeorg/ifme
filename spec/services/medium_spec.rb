# frozen_string_literal: true

describe Medium do
  subject { Medium.new.posts }

  it 'retrieve Medium posts from API' do
    expect(subject.first[1]['previewContent']['bodyModel']['paragraphs'][1]['text']).to be_truthy
    expect(subject.first[1]['title']).to be_truthy
    expect(subject.first[1]['uniqueSlug']).to be_truthy
  end
end
