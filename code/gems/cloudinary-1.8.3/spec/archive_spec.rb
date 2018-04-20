require 'spec_helper'
require 'cloudinary'
require 'rest_client'
require 'zip'

RSpec.shared_context 'archive' do

  before :all do
    Cloudinary::Uploader.upload(
      "http://res.cloudinary.com/demo/image/upload/sample.jpg",
      :public_id      => 'tag_samplebw',
      :tags           => [TEST_TAG, TIMESTAMP_TAG],
      :transformation => {
        :effect => :blackwhite
      }
    )
    Cloudinary::Uploader.upload(
      "http://res.cloudinary.com/demo/image/upload/sample.jpg",
      :public_id      => 'tag_sample',
      :tags           => [TEST_TAG, TIMESTAMP_TAG],
      :transformation => {
        :effect => :blackwhite
      }
    )
    Cloudinary::Uploader.upload(
      "http://res.cloudinary.com/demo/image/upload/sample.jpg",
      :public_id      => 'tag_sample_raw.jpg',
      :resource_type  => 'raw',
      :tags           => [TEST_TAG, TIMESTAMP_TAG],
    )
  end
  include_context "cleanup", TIMESTAMP_TAG
end

describe Cloudinary::Utils do
  include_context 'archive'

  describe '.generate_zip_download_url' do
    let(:options) { {} }
    let!(:archive_result) {
      Cloudinary::Utils.download_zip_url(
        {
          :target_public_id => 'gem_archive_test',
          :public_ids       => %w(tag_sample tag_samplebw),
          :target_tags      => [TEST_TAG, TIMESTAMP_TAG]
        }.merge(options))
    }

    describe 'public_ids' do
      it 'should generate a valid url' do
        expect(archive_result).not_to be_empty
      end
      it 'should include two files' do
        Zip::File.open_buffer(RestClient.get(archive_result)) do |zip_file|
          list = zip_file.glob('*').map(&:name)
          expect(list.length).to be(2)
          expect(list).to include('tag_sample.jpg', 'tag_samplebw.jpg')
        end
      end
    end
  end
end

describe Cloudinary::Uploader do
  include_context 'archive'

  let(:options) { {} }

  describe '.create_archive' do
    let!(:target_public_id) {
      "gem_test#{ SUFFIX}"
    }
    expected_keys = %w(
              resource_type
              type
              public_id
              version
              url
              secure_url
              created_at
              tags
              signature
              bytes
              etag
              resource_count
              file_count
            )
    let!(:archive_result) {
      Cloudinary::Uploader.create_archive(
        {
          :target_public_id => target_public_id,
          :public_ids       => %w(tag_sample tag_samplebw),
          :tags             => [TEST_TAG, TIMESTAMP_TAG],
          :transformations   => [{width: 100, height: 100, crop: "fill"},{effect: "grayscale"}],
          :skip_transformation_name => true
        }.merge(options))
    }
    let(:options) { { :mode => :create } }
    it 'should return a Hash with suitable set of keys' do
      expect(archive_result).to be_a(Hash)
      expect(archive_result.keys).to include(*expected_keys)
    end
  end
  describe 'create archive based on raw resources and missing public IDs' do
    let!(:target_public_id) {
      "gem_test#{ SUFFIX}"
    }
    let!(:archive_result) {
      Cloudinary::Uploader.create_archive(
        {
          :target_public_id => target_public_id,
          :public_ids       => %w(tag_sample_raw.jpg non-wxisting-resource),
          :resource_type    => 'raw',
          :allow_missing    => true
        }.merge(options))
    }
    let(:options) { { :mode => :create } }
    it 'should skip missing public IDs and successfully generate the archive containing raw resources' do
      expect(archive_result).to be_a(Hash)
      expect(archive_result["resource_count"]).to equal(1)
    end
  end
  describe '.create_zip' do
    it 'should call create_archive with "zip" format' do
      expect(Cloudinary::Uploader).to receive(:create_archive).with({ :tags => TEST_TAG }, "zip")
      Cloudinary::Uploader.create_zip({ :tags => TEST_TAG })
    end
  end
end