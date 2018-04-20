require 'spec_helper'
require 'cloudinary'

module CarrierWave
  module Storage
    class Abstract
      def initialize(uploader)
        @uploader = uploader
      end

      attr_accessor :uploader
    end
  end
  class SanitizedFile; end
end

RSpec.describe Cloudinary::CarrierWave::Storage do
  describe '#store_cloudinary_identifier' do
    let(:column) { 'example_field' }
    let(:model) { double :model, _mounter: mount, write_attribute: true }
    let(:mount) { double :mount, serialization_column: column }
    let(:storage) { Cloudinary::CarrierWave::Storage.new(uploader) }
    let(:store_identifier) { storage.store_cloudinary_identifier('1', 'test.png') }
    let(:uploader) { double :uploader, model: model, mounted_as: :example, use_extended_identifier?: false }

    describe 'when the ORM is Neo4j 5 and above' do
      before { stub_const('Neo4j::VERSION', '5.0') }

      subject! { store_identifier }

      it 'writes the name to the datastore without triggering validations' do
        expect(model).to have_received(:write_attribute).with(column, 'v1/test.png')
      end
    end

    describe 'when the ORM is Neo4j 4' do
      before { stub_const('Neo4j::VERSION', '4.0') }

      it 'raises an unsupported exception' do
        expect { store_identifier }.to raise_error(CloudinaryException)
      end
    end
  end
end
