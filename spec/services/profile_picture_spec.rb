# frozen_string_literal: true

COMPONENT_NAME = 'Avatar';
IMG_CLASS = 'main_profile'
LOCAL_ASSET = '/assets/contributors/ABC123.jpg'
CLOUDINARY_HOST = 'res.cloudinary.com'
CLOUDINARY_ASSET_ID = 'XYZ789'
CLOUDINARY_ASSET_URL = "https://#{CLOUDINARY_HOST}/image/upload/#{CLOUDINARY_ASSET_ID}.jpg"

describe ProfilePicture do
  subject { described_class }

  describe '.fetch' do
    it 'returns HTML with class name and same URL for local portraits '\
    'in development environment' do
      rendered = subject.fetch(LOCAL_ASSET, className: IMG_CLASS)
      expect(rendered).to have_tag('script', with: { 'data-component-name': COMPONENT_NAME })
      expect(rendered).to include(LOCAL_ASSET)
      expect(rendered).not_to include(CLOUDINARY_HOST)
    end

    it 'returns HTML with class name and Cloudinary URL for local portraits '\
    'in production environment' do
      allow(Rails).to receive(:env) { 'production'.inquiry }
      rendered = subject.fetch(LOCAL_ASSET, className: IMG_CLASS)
      expect(rendered).to have_tag('script', with: { 'data-component-name': COMPONENT_NAME })
      expect(rendered).to include(LOCAL_ASSET)
      expect(rendered).to include(CLOUDINARY_HOST)
    end

    it 'returns HTML with class name and Cloudinary URL for Cloudinary-stored'\
    'portraits' do
      rendered = subject.fetch(CLOUDINARY_ASSET_URL, className: IMG_CLASS)
      expect(rendered).to have_tag('script', with: { 'data-component-name': COMPONENT_NAME })
      expect(rendered).to include(CLOUDINARY_ASSET_ID)
      expect(rendered).to include(CLOUDINARY_HOST)
    end
  end

  describe '.normalize_url' do
    it 'URL for local portraits in development environment' do
      url = subject.send(:normalize_url, LOCAL_ASSET)
      expect(url).to include(LOCAL_ASSET)
      expect(url).not_to include(CLOUDINARY_HOST)
    end

    it 'Cloudinary URL for local portraits in production environment' do
      allow(Rails).to receive(:env) { 'production'.inquiry }
      url = subject.send(:normalize_url, LOCAL_ASSET)
      expect(url).to include(LOCAL_ASSET)
      expect(url).to include(CLOUDINARY_HOST)
    end

    it 'Cloudinary URL for Cloudinary-stored portraits' do
      url = subject.send(:normalize_url, CLOUDINARY_ASSET_URL)
      expect(url).to include(CLOUDINARY_ASSET_ID)
      expect(url).to include(CLOUDINARY_HOST)
    end
  end

  describe '.cloudinary_src' do
    it 'returns true for Cloudinary URL' do
      expect(subject.send(:cloudinary_src, CLOUDINARY_ASSET_URL)).to be
    end

    it 'returns false for non-Cloudinary URL' do
      expect(subject.send(:cloudinary_src, LOCAL_ASSET)).not_to be
    end
  end

  describe '.get_cloudinary_image_id' do
    it 'returns id for a Cloudinary URL' do
      expect(subject.send(:get_cloudinary_image_id, CLOUDINARY_ASSET_URL)).to \
        eq(CLOUDINARY_ASSET_ID)
    end
  end
end
