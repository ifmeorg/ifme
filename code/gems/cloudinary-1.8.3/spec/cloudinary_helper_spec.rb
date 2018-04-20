require 'rspec'
require 'spec_helper'
require 'cloudinary'
require 'action_view'
require 'cloudinary/helper'

helper_class = Class.new do
  include CloudinaryHelper
end

RSpec.describe CloudinaryHelper do
  let(:helper) { helper_class.new }
  let(:options) { {} }
  before :each do
    Cloudinary.config({})
  end
  context "#cl_image_upload_tag" do
    let(:options) {{:multiple => true}}
    before do
      if defined? allow
        allow(Cloudinary::Utils).to receive_messages :cloudinary_api_url => '', :sign_request => Hash.new
        allow(helper).to receive(:build_callback_url).and_return('')
      else
        Cloudinary::Utils.should_receive(:cloudinary_api_url).and_return('')
        Cloudinary::Utils.should_receive(:sign_request).and_return(Hash.new)
        helper.should_receive(:build_callback_url).and_return('')
      end
    end
    let(:test_tag) { TestTag.new( helper.cl_image_upload_tag('image_id', options)) }

    it "allow multiple upload" do
      expect(test_tag['data-cloudinary-field']).to eq('image_id[]')
      expect(test_tag['multiple']).to eq('multiple')
    end
  end
  context "#cl_upload_tag" do
    let(:options) {{:multiple => true}}
    before do
      if defined? allow
        allow(Cloudinary::Utils).to receive_messages :cloudinary_api_url => '', :sign_request => Hash.new
        allow(helper).to receive(:build_callback_url).and_return('')
      else
        Cloudinary::Utils.should_receive(:cloudinary_api_url).and_return('')
        Cloudinary::Utils.should_receive(:sign_request).and_return(Hash.new)
        helper.should_receive(:build_callback_url).and_return('')
      end
    end
    let(:test_tag) { TestTag.new( helper.cl_upload_tag('image_id', options)) }

    it "allow multiple upload" do
      expect(test_tag['data-cloudinary-field']).to eq('image_id[]')
      expect(test_tag['multiple']).to eq('multiple')
    end
  end

  context "#cl_image_tag" do
    let(:test_tag) { TestTag.new( helper.cl_image_tag('sample.jpg', options)) }

    context ":responsive_width" do
      let(:options) { {:responsive_width => true, :cloud_name => "test"} }
      it "should use data-src for responsive_width" do
        expect(test_tag.name).to match( 'img')
        expect(test_tag['class']).to eq("cld-responsive")
        expect(test_tag['data-src']).to eq( "http://res.cloudinary.com/test/image/upload/c_limit,w_auto/sample.jpg")
      end
    end

    context ":dpr_auto" do
      let(:options) { {:dpr => :auto, :cloud_name => "test"} }
      it "should use data-src for dpr auto" do
        expect(test_tag.name).to match( 'img')
        expect(test_tag['class']).to eq( 'cld-hidpi')
        expect(test_tag['data-src']).to eq( "http://res.cloudinary.com/test/image/upload/dpr_auto/sample.jpg")
      end
    end

    context ":client_hints" do
      shared_examples "client_hints" do
        it "should not use data-src or set responsive class" do
          expect(test_tag.name).to match( 'img')
          expect(test_tag['class']).to be_nil
          expect(test_tag['data-src']).to be_nil
          expect(test_tag['src']).to eq( "http://res.cloudinary.com/test/image/upload/dpr_auto,w_auto/sample.jpg")
        end
        it "should override :responsive" do
          Cloudinary.config.responsive = true
          expect(test_tag.name).to match( 'img')
          expect(test_tag['class']).to be_nil
          expect(test_tag['data-src']).to be_nil
          expect(test_tag['src']).to eq( "http://res.cloudinary.com/test/image/upload/dpr_auto,w_auto/sample.jpg")
        end
      end
      context "as option" do
        let(:options) { {:dpr => :auto, :cloud_name => "test", :width => "auto", :client_hints => true} }
        include_examples "client_hints"
      end
      context "as global configuration" do
        before do
          Cloudinary.config.client_hints = true
        end
        let(:options) { {:dpr => :auto, :cloud_name => "test", :width => "auto"} }
        include_examples "client_hints"
      end

      context "false" do
        let(:options) { {:width => :auto, :cloud_name => "test", :client_hints => false} }
        it "should use normal responsive behaviour" do
          expect(test_tag.name).to match( 'img')
          expect(test_tag['class']).to eq( 'cld-responsive')
          expect(test_tag['data-src']).to eq( "http://res.cloudinary.com/test/image/upload/w_auto/sample.jpg")
        end
      end
      context "width" do
        let(:options) { {:dpr => :auto, :cloud_name => "test", :width => "auto:breakpoints", :client_hints => true}}
        it "supports auto width" do
          expect(test_tag['src']).to eq( "http://res.cloudinary.com/test/image/upload/dpr_auto,w_auto:breakpoints/sample.jpg")
        end
      end
    end
  end

  context "#cl_client_hints_meta_tag" do
    it "should create a meta tag" do
      tag = TestTag.new( helper.cl_client_hints_meta_tag)
      expect(tag.name).to match('meta')
      expect(tag['content']).to eq('DPR, Viewport-Width, Width')
      expect(tag['http-equiv']).to eq('Accept-CH')
    end
  end

  context "auth_token" do
    it "should add token to an image tag url" do
      tag = helper.cl_image_tag "sample.jpg",
                                :cloud_name => 'test123',
                                :sign_url => true,
                                :type => "authenticated",
                                :version => "1486020273",
                                :auth_token => {key: KEY, start_time: 11111111, duration: 300}
      expect(tag).to match /<img.*src="http:\/\/res.cloudinary.com\/test123\/image\/authenticated\/v1486020273\/sample.jpg\?__cld_token__=st=11111111~exp=11111411~hmac=9bd6f41e2a5893da8343dc8eb648de8bf73771993a6d1457d49851250caf3b80.*>/

    end

  end
  describe "image_path" do

    before :all do
      class Cloudinary::Static
        class << self
          def reset_metadata
            @metadata = nil
            @static_file_config = nil
            @public_prefixes = nil
          end
        end
      end
    end

    before :each do
      @static_support = Cloudinary.config.static_image_support
      @static_file = Cloudinary::Static::METADATA_FILE
      Cloudinary::Static.reset_metadata
    end

    after :each do
      Cloudinary.config.static_image_support = @static_support
      Kernel::silence_warnings { Cloudinary::Static::METADATA_FILE = @static_file }
      Cloudinary::Static.reset_metadata
    end

    context 'type=="asset"' do
      it "should not transform images staring with /" do
        expect(helper.image_path('/bar')).to eq('/bar')
      end
      it "should not transform images staring with /images unless asset is found and static_support is true" do
        Cloudinary.config.static_image_support = false
        expect(helper.image_path('/images/foo.jpg')).to eq('/images/foo.jpg')
        expect(helper.image_path('some-folder/foo.gif')).to eq("/images/some-folder/foo.gif")
        Kernel::silence_warnings { Cloudinary::Static::METADATA_FILE = "spec/sample_asset_file.tsv"}
        Cloudinary::Static.reset_metadata
        expect(helper.image_path('/images/foo.jpg'))
            .to eq("/images/foo.jpg")
        expect(helper.image_path('some-folder/foo.gif')).to eq("/images/some-folder/foo.gif")
        Cloudinary.config.static_image_support = true
        expect(helper.image_path('/images/foo.jpg')).to eq("http://res.cloudinary.com/sdk-test/image/asset/images-foo.jpg")
        expect(helper.image_path('foo.jpg')).to eq("http://res.cloudinary.com/sdk-test/image/asset/images-foo.jpg")
        expect(helper.image_path('some-folder/foo.gif')).to eq('/images/some-folder/foo.gif')
      end
    end
  end
end
