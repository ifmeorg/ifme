# frozen_string_literal: true

IMG_CLASS = 'main_profile'
LOCAL_ASSET = '/assets/contributors/ABC123.jpg'
CLOUDINARY_HOST = 'res.cloudinary.com'
CLOUDINARY_ASSET = "https://#{CLOUDINARY_HOST}/image/upload/ABC123.jpg"

describe ProfilePicture do
  subject { described_class }

  describe '.fetch' do
    it 'returns HTML with class name and same URL for local portraits '\
    'in development environment' do
      expect(subject.fetch(LOCAL_ASSET, IMG_CLASS)).to \
        have_tag('img', with: { src: LOCAL_ASSET, class: IMG_CLASS })
    end

    it 'returns HTML with class name and Cloudinary URL for local portraits '\
    'in production environment' do
      allow(Rails).to receive(:env) { 'production'.inquiry }
      rendered = subject.fetch(LOCAL_ASSET, IMG_CLASS)
      expect(rendered).to have_tag('img', with: { class: IMG_CLASS })
      expect(rendered).to include(CLOUDINARY_HOST)
      expect(rendered).to include(LOCAL_ASSET)
    end

    it 'returns HTML with class name and Cloudinary URL for Cloudinary-stored'\
    'portraits' do
      rendered = subject.fetch(CLOUDINARY_ASSET, IMG_CLASS)
      expect(rendered).to have_tag('img', with: { class: IMG_CLASS })
      expect(rendered).to include(CLOUDINARY_HOST)
    end
  end

  describe '.get_cloudinary_image_id' do
    it 'returns id for a Cloudinary URL' do
      expect(subject.send(:get_cloudinary_image_id, CLOUDINARY_ASSET)).to \
        eq('ABC123')
    end
  end
end
