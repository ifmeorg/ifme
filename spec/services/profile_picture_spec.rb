# frozen_string_literal: true

CLOUDINARY_URL = 'https://res.cloudinary.com/image/upload/ABC123.jpg'

describe ProfilePicture do
  subject { described_class }

  describe '.fetch' do
    it 'returns HTML with class name and path for normal portraits' do
      expect(subject.fetch('some_image_url', 'some_class')).to \
      have_tag('img', :with => {
        :src => 'some_image_url',
        :class => 'some_class'
      })
    end

    it 'returns HTML with class name and path for Cloudinary portraits' do
      expect(subject.fetch(CLOUDINARY_URL, 'some_class')).to \
      have_tag('img', :with => {
        :class => 'some_class'
      })
    end
  end

  describe '.get_cloudinary_image_id' do
    it 'returns id for a Cloudinary URL' do
      expect(subject.send(:get_cloudinary_image_id, CLOUDINARY_URL)).to \
      eq('ABC123')
    end
  end
end
