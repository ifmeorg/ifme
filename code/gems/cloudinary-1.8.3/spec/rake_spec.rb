require 'spec_helper'
require 'cloudinary'

require 'tmpdir'
require 'pathname'

describe 'cloudinary:sync_static' do
  include_context 'rake' # context needs to have the exact rake task as name
  include Helpers::TempFileHelpers

  before(:all) do
    copy_root_to_temp('spec/data/sync_static/')

    # Reuse some existing spec assets so as not to add weight to the project
    copy_file_to_temp('spec/logo.png', 'app/assets/images/logo1.png')
    copy_file_to_temp('spec/logo.png', 'app/assets/images/logo2.png')
    copy_file_to_temp('samples/basic/lake.jpg', 'app/assets/images/lake1.jpg')
    copy_file_to_temp('samples/basic/lake.jpg', 'public/images/lake2.jpg')
  end

  after(:all) do
    clean_up_temp_files!
  end

  before (:each) do
    allow(Cloudinary).to receive(:app_root).and_return(Pathname.new(temp_root))
    Cloudinary::Static.send(:reset_static_file_config!)
  end

  after (:each) do
    # destroy all uploaded assets
    Cloudinary::Static.send(:build_metadata).each do |_, data|
      Cloudinary::Uploader.destroy(data['public_id'], {:type => :asset})
    end
    # delete metadata_file_path
    FileUtils.rm_f(Cloudinary::Static.send(:metadata_file_path))
    FileUtils.rm_f(Cloudinary::Static.send(:metadata_trash_file_path))
  end

  it 'should find correct file when running in default configuration' do
    # with default settings, 4 images only will be uploaded
    subject.invoke
    expect(Cloudinary::Static.send(:build_metadata).size).to eq 4
  end

  it 'should respect deprecated static_image_dirs config setting' do
    allow(Cloudinary.config).to receive(:static_image_dirs).and_return(['public/images'])
    subject.invoke
    expect(Cloudinary::Static.send(:build_metadata).size).to eq 1
  end

  it 'should allow to specify only dirs in images group, taking the file_mask from default' do
    allow(Cloudinary.config).to receive(:static_files).and_return({
                                                                    'images' => {
                                                                      'dirs' => ['public/images']
                                                                    }
                                                                  })
    subject.invoke
    expect(Cloudinary::Static.send(:build_metadata).size).to eq 1
  end

  it 'should allow to specify only file_mask in images group, taking the dirs from default' do
    allow(Cloudinary.config).to receive(:static_files).and_return({
                                                                    'images' => {
                                                                      'file_mask' => 'png'
                                                                    }
                                                                  })
    subject.invoke
    expect(Cloudinary::Static.send(:build_metadata).size).to eq 2
  end

  it 'should allow to specify regex expressions in file_mask' do
    allow(Cloudinary.config).to receive(:static_files).and_return({
                                                                    'images' => {
                                                                      'file_mask' => 'p.?g|jp.?'
                                                                    },
                                                                    'javascripts' => {
                                                                      'dirs' => ['app/assets/javascripts'],
                                                                      'file_mask' => 'js'
                                                                    },
                                                                    'stylesheets' => {
                                                                      'dirs' => ['app/assets/stylesheets'],
                                                                      'file_mask' => 'css'
                                                                    }
                                                                  })
    subject.invoke
    expect(Cloudinary::Static.send(:build_metadata).size).to eq 6
  end

  context 'Cloudinary::Utils.cloudinary_url' do
    def all_asset_forms_of(public_id)
      [ "/#{public_id}", public_id.split('/').last]
    end

    RSpec::Matchers.define :be_asset_mapped_by_cloudinary_url_to do |expected|
      match do |actual|
        actual = [actual] unless actual.respond_to? :all?
        actual.all? do |public_path|
          @public_path = public_path
          @actual = Cloudinary::Utils.cloudinary_url(public_path, :cloud_name => 'test', :type => 'asset')
          @actual == expected
        end
      end
      failure_message do |actual|
        "URL for '#{@public_path}' should have been '#{expected}' but was '#{@actual}'.#{ differ.diff_as_string(@actual, expected)}"
      end
      failure_message_when_negated do |actual|
        "URL for '#{@public_path}' should not have been '#{expected}'."
      end
      def differ
        RSpec::Support::Differ.new(
            :object_preparer => lambda { |object| RSpec::Matchers::Composable.surface_descriptions_in(object) },
            :color => RSpec::Matchers.configuration.color?
        )
      end

    end

    before(:each) do
      allow(Cloudinary.config).to receive(:static_files).and_return({
                                                                      'images' => {
                                                                        'dirs' => ['app/assets/images'],
                                                                        'file_mask' => 'p.?g|jp.?'
                                                                      },
                                                                      'javascripts' => {
                                                                        'dirs' => ['app/assets/javascripts'],
                                                                        'file_mask' => 'js'
                                                                      },
                                                                      'stylesheets' => {
                                                                        'dirs' => ['app/assets/stylesheets'],
                                                                        'file_mask' => 'css'
                                                                      }
                                                                    })

    end

    it 'should return Cloudinary asset urls for assets when Cloudinary.config.static_file_support is true' do
      allow(Cloudinary.config).to receive(:static_file_support).and_return(true)
      subject.invoke

      expect(['logo1.png', '/images/logo1.png']).to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/image/asset/logo1-7dc60722d4653261648038b579fdb89e.png')
      expect('images/logo1.png').not_to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/image/asset/logo1-7dc60722d4653261648038b579fdb89e.png')
      expect('1.js').to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/raw/asset/1-b01de57adb485efdde843154d030644e.js')
      expect(['javascripts/1.js', '/javascripts/1.js']).not_to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/raw/asset/1-b01de57adb485efdde843154d030644e.js')
      expect('1.css').to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/raw/asset/1-f24cc6123afd401ab86d8596cabc619f.css')
      expect(['stylesheets/1.css', '/stylesheets/1.css']).not_to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/raw/asset/1-f24cc6123afd401ab86d8596cabc619f.css')

      # without :type => 'asset'
      expect(Cloudinary::Utils.cloudinary_url('logo1.png')).not_to include('7dc60722d4653261648038b579fdb89e')
    end

    it 'should return Cloudinary asset urls for assets when Cloudinary.config.static_image_support is true (backwards compatibility)' do
      allow(Cloudinary.config).to receive(:static_image_support).and_return(true)
      subject.invoke

      expect(['logo1.png', '/images/logo1.png']).to be_asset_mapped_by_cloudinary_url_to('http://res.cloudinary.com/test/image/asset/logo1-7dc60722d4653261648038b579fdb89e.png')
    end
  end

end
