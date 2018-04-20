require 'rspec'
require 'spec_helper'
require 'cloudinary'
require 'action_view'
require 'cloudinary/helper'
require 'rails/version'

if ::Rails::VERSION::MAJOR < 4
  def config
    @config ||= {}
  end
  def controller
    @controller ||={}
  end
end
describe CloudinaryHelper do
  before :all do
    # Test the helper in the context it runs in in production
    ActionView::Base.send :include, CloudinaryHelper

  end
  before(:each) do
    Cloudinary.config do |config|
      config.cloud_name          = "test123"
      config.secure_distribution = nil
      config.private_cdn         = false
      config.secure              = false
      config.cname               = nil
      config.cdn_subdomain       = false
      config.api_key             = "1234"
      config.api_secret          = "b"
    end
  end

  let(:helper) {
    ActionView::Base.new
  }
  let(:root_path) { "http://res.cloudinary.com/test123" }
  let(:upload_path) { "#{root_path}/video/upload" }

  describe 'cl_video_tag' do
    let(:basic_options) { { :cloud_name => "test123"} }
    let(:options) { basic_options }
    let(:test_tag) { TestTag.new helper.cl_video_tag("movie", options) }
    context "when options include video tag attributes" do
      let(:options) { basic_options.merge({ :autoplay => true,
                                            :controls => true,
                                            :loop     => true,
                                            :muted    => true,
                                            :preload  => true }) }
      it "should support video tag parameters" do
        expect(test_tag.attributes.keys).to include("autoplay", "controls", "loop", "muted", "preload")
      end
    end

    context 'when given transformations' do
      let(:options) {
        basic_options.merge(
          :source_types => "mp4",
          :html_height  => "100",
          :html_width   => "200",
          :crop         => :scale,
          :height       => "200",
          :width        => "400",
          :video_codec  => { :codec => 'h264' },
          :audio_codec  => 'acc',
          :start_offset => 3) }

      it 'should create a tag with "src" attribute that includes the transformations' do
        expect(test_tag["src"]).to be_truthy
        expect(test_tag["src"]).to include("ac_acc")
        expect(test_tag["src"]).to include("vc_h264")
        expect(test_tag["src"]).to include("so_3")
        expect(test_tag["src"]).to include("w_400")
        expect(test_tag["src"]).to include("h_200")
      end
      it 'should have the correct tag height' do
        expect(test_tag["src"]).to include("ac_acc")
        expect(test_tag["height"]).to eq("100")
      end
    end

    describe ":source_types" do
      context "when a single source type is provided" do
        let(:options) { basic_options.merge(:source_types => "mp4") }
        it "should create a video tag" do
          expect(test_tag.name).to eq("video")
          expect(test_tag['src']).to eq( "#{upload_path}/movie.mp4")
        end
        it "should not have a `type` attribute" do
          expect(test_tag.attributes).not_to include("type")
        end
        it "should not have inner `source` tags" do
          expect(test_tag.children.map(&:name)).not_to include("source")
        end
      end

      context 'when provided with multiple source types' do
        let(:options) { basic_options.merge(:source_types => %w(mp4 webm ogv)) }
        it "should create a tag with multiple source tags" do
          expect(test_tag.children.length).to eq(3)
          expect(test_tag.children[0].name).to eq("source")
          expect(test_tag.children[1].name).to eq("source")
          expect(test_tag.children.map{|c| c['src']}).to all( include("video/upload"))
        end
        it "should order the source tags according to the order of the source_types" do
          expect(test_tag.children[0][:type]).to eq("video/mp4")
          expect(test_tag.children[1][:type]).to eq("video/webm")
          expect(test_tag.children[2][:type]).to eq("video/ogg")
        end
      end
    end

    describe ":poster" do
      context "when poster is not provided" do
        it "should default to jpg with the video transformation" do
          expect(test_tag[:poster]).to eq(helper.cl_video_thumbnail_path("movie", { :format => 'jpg' }))
        end
      end

      context "when given a string" do
        let(:options) { basic_options.merge(:poster => TEST_IMAGE_URL) }
        it "should include a poster attribute with the given string as url" do
          expect(test_tag.attributes).to include('poster')
          expect(test_tag[:poster]).to eq(TEST_IMAGE_URL)
        end
      end

      context "when poster is a hash" do
        let(:options) { basic_options.merge(:poster => { :gravity => "north" }) }
        it "should include a poster attribute with the given options" do
          expect(test_tag[:poster]).to eq("#{upload_path}/g_north/movie.jpg")
        end
        context "when a public id is provided" do
          let(:options) { basic_options.merge(:poster => { :public_id => 'myposter.jpg', :gravity => "north" }) }
          it "should include a poster attribute with an image path and the given options" do
            expect(test_tag[:poster]).to eq("#{root_path}/image/upload/g_north/myposter.jpg")
          end


        end
      end

      context "when poster parameter is nil or false" do
        let(:options) { basic_options.merge(:poster => nil) }
        it "should not include a poster attribute in the tag for nil" do
          expect(test_tag.attributes).not_to include('poster')
        end
        let(:options) { basic_options.merge(:poster => false) }
        it "should not include a poster attribute in the tag for false" do
          expect(test_tag.attributes).not_to include('poster')
        end
      end
    end

    context ":source_transformation" do
      let(:options) { basic_options.merge(:source_types          => %w(mp4 webm),
                                          :source_transformation => { 'mp4'  => { 'quality' => 70 },
                                                                      'webm' => { 'quality' => 30 } }
      ) }
      it "should produce the specific transformation for each type" do
        expect(test_tag.children_by_type("video/mp4")[0][:src]).to include("q_70")
        expect(test_tag.children_by_type("video/webm")[0][:src]).to include("q_30")
      end

    end

    describe ':fallback_content' do
      context 'when given fallback_content parameter' do
        let(:fallback) { "<span id=\"spanid\">Cannot display video</span>" }
        let(:options) { basic_options.merge(:fallback_content => fallback) }
        it "should include fallback content in the tag" do
          expect(test_tag.children).to include(TestTag.new(fallback))
        end
      end

      context "when given a block" do
        let(:test_tag) do
          # Actual code being tested ----------------
          html = helper.cl_video_tag("movie", options) do
            "Cannot display video!"
          end
          # -----------------------------------
          TestTag.new(html)
        end
        it 'should treat the block return value as fallback content' do
          expect(test_tag.children).to include("Cannot display video!")
        end
      end
      describe "dimensions" do
        context "when `:crop => 'fit'`" do
          let(:options) { basic_options.merge(:crop => 'fit') }
          it "should not include a width and height attributes" do
            expect(test_tag.attributes.keys).not_to include("width", "height")
          end
        end
        context "when `:crop => 'limit'`" do
          let(:options) { basic_options.merge(:crop => 'limit') }
          it "should not include a width and height attributes" do
            expect(test_tag.attributes.keys).not_to include("width", "height")
          end
        end
      end
    end
  end
  describe 'cl_video_thumbnail_path' do
    let(:source) { "movie_id" }
    let(:options) { {} }
    let(:path) { helper.cl_video_thumbnail_path(source, options) }
    it "should generate a cloudinary URI to the video thumbnail" do
      expect(path).to eq("#{upload_path}/movie_id.jpg")
    end
  end
  describe 'cl_video_thumbnail_tag' do
    let(:source) { "movie_id" }
    let(:options) { {} }
    let(:result_tag) { TestTag.new(helper.cl_video_thumbnail_tag(source, options)) }
    describe ":resource_type" do
      context "'video' (default)" do
        let(:options) { { :resource_type => 'video' } }
        it "should have a 'video/upload' path" do
          expect(result_tag.name).to eq('img')
          expect(result_tag[:src]).to include("video/upload")
        end
        it "should generate an img tag with file extension `jpg`" do
          expect(result_tag[:src]).to end_with("movie_id.jpg")
        end
      end
      context "'image'" do
        let(:options) { { :resource_type => 'image' } }
        it "should have a 'image/upload' path" do
          expect(result_tag.name).to eq('img')
          expect(result_tag[:src]).to include("image/upload")
        end
        it "should generate an img tag with file extension `jpg`" do
          expect(result_tag[:src]).to end_with("movie_id.jpg")
        end
      end
      context "'raw'" do
        let(:options) { { :resource_type => 'raw' } }
        it "should have a 'raw/upload' path" do
          expect(result_tag.name).to eq('img')
          expect(result_tag[:src]).to include("raw/upload")
        end
        it "should generate an img tag with file extension `jpg`" do
          expect(result_tag[:src]).to end_with("movie_id.jpg")
        end
      end
    end
  end
end
