require 'spec_helper'
require 'cloudinary'

describe Cloudinary::Utils do

  before :each do
    Cloudinary.config do |config|
      # config.cloud_name = "demo"
      config.secure_distribution = nil
      config.private_cdn         = false
      config.secure              = false
      config.cname               = nil
      config.cdn_subdomain       = false
    end
  end

  let(:cloud_name) { Cloudinary.config.cloud_name }
  let(:root_path) { "http://res.cloudinary.com/#{cloud_name}" }
  let(:upload_path) { "#{root_path}/image/upload" }

  it "should allow overriding cloud_name in options" do
    expect(["test", { :cloud_name => "test321" }])
      .to produce_url("http://res.cloudinary.com/test321/image/upload/test")
            .and empty_options
  end

  it "should use default secure distribution if secure=true" do
    expect(["test", { :secure => true }])
      .to produce_url("https://res.cloudinary.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should allow overriding secure distribution if secure=true" do
    expect(["test", { :secure => true, :secure_distribution => "something.else.com" }])
      .to produce_url("https://something.else.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should take secure distribution from config if secure=true" do
    Cloudinary.config.secure_distribution = "config.secure.distribution.com"
    expect(["test", { :secure => true }])
      .to produce_url("https://config.secure.distribution.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should default to akamai if secure is given with private_cdn and no secure_distribution" do
    expect(["test", { :secure => true, :private_cdn => true }])
      .to produce_url("https://#{cloud_name}-res.cloudinary.com/image/upload/test")
            .and empty_options
  end

  it "should not add cloud_name if secure private_cdn and secure non akamai secure_distribution" do
    expect(["test", { :secure => true, :private_cdn => true, :secure_distribution => "something.cloudfront.net" }])
      .to produce_url("https://something.cloudfront.net/image/upload/test")
            .and empty_options
  end

  it "should allow overriding private_cdn if private_cdn=true" do
    expect(["test", { :private_cdn => true }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/image/upload/test")
            .and empty_options
  end

  it "should allow overriding private_cdn if private_cdn=false" do
    Cloudinary.config.private_cdn = true
    expect(["test", { :private_cdn => false }])
      .to produce_url("#{upload_path}/test")
            .and empty_options
  end

  it "should allow overriding cname if cname=example.com" do
    expect(["test", { :cname => "example.com" }])
      .to produce_url("http://example.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should allow overriding cname if cname=false" do
    Cloudinary.config.cname = "example.com"
    expect(["test", { :cname => false }])
      .to produce_url("#{upload_path}/test")
            .and empty_options
  end

  it "should use format from options" do
    expect(["test", { :format => :jpg }])
      .to produce_url("#{upload_path}/test.jpg")
            .and empty_options
  end

  it "should support url_suffix in shared distribution" do
    expect(["test", { :url_suffix => "hello" }])
      .to produce_url("http://res.cloudinary.com/#{cloud_name}/images/test/hello")
            .and empty_options
    expect(["test", { :url_suffix => "hello", :angle => 0 }])
      .to produce_url("http://res.cloudinary.com/#{cloud_name}/images/a_0/test/hello")
            .and empty_options
  end

  it "should disallow url_suffix in non upload types" do
    expect { Cloudinary::Utils.cloudinary_url("test", { :url_suffix => "hello", :private_cdn => true, :type => :facebook }) }.to raise_error(CloudinaryException)
  end

  it "should disallow url_suffix with / or ." do
    expect { Cloudinary::Utils.cloudinary_url("test", { :url_suffix => "hello/world", :private_cdn => true }) }.to raise_error(CloudinaryException)
    expect { Cloudinary::Utils.cloudinary_url("test", { :url_suffix => "hello.world", :private_cdn => true }) }.to raise_error(CloudinaryException)
  end

  it "should support url_suffix for private_cdn" do
    expect(["test", { :url_suffix => "hello", :private_cdn => true }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/images/test/hello")
            .and empty_options
    expect(["test", { :url_suffix => "hello", :angle => 0, :private_cdn => true }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/images/a_0/test/hello")
            .and empty_options
  end

  it "should put format after url_suffix" do
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :format => "jpg" }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/images/test/hello.jpg")
            .and empty_options
  end

  it "should sign a url" do
    expected = Cloudinary::Utils.cloudinary_url "some_public_id.jpg", 
                                     :cloud_name => "test", 
                                     :api_key => "123456789012345", 
                                     :api_secret => "AbcdEfghIjklmnopq1234567890", 
                                     :type => "authenticated", 
                                     :sign_url => true, 
                                     :overlay => "text:Helvetica_50:test+text"
    expect(expected).to eq("http://res.cloudinary.com/test/image/authenticated/s--j5Z1ILxd--/l_text:Helvetica_50:test+text/some_public_id.jpg")
  end

  it "should not sign the url_suffix" do
    expected_signture = Cloudinary::Utils.cloudinary_url("test", :format => "jpg", :sign_url => true).match(/s--[0-9A-Za-z_-]{8}--/).to_s
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :format => "jpg", :sign_url => true }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/images/#{expected_signture}/test/hello.jpg")
            .and empty_options

    expected_signture = Cloudinary::Utils.cloudinary_url("test", :format => "jpg", :angle => 0, :sign_url => true).match(/s--[0-9A-Za-z_-]{8}--/).to_s
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :format => "jpg", :angle => 0, :sign_url => true }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/images/#{expected_signture}/a_0/test/hello.jpg")
            .and empty_options
  end

  it "should support url_suffix for raw uploads" do
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :resource_type => :raw }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/files/test/hello")
            .and empty_options
  end

  it "should support url_suffix for videos" do
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :resource_type => :video }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/videos/test/hello")
            .and empty_options
  end

  it "should support url_suffix for private images" do
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :resource_type => :image, :type => :private }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/private_images/test/hello")
            .and empty_options
    expect(["test", { :url_suffix => "hello", :private_cdn => true, :format => "jpg", :resource_type => :image, :type => :private }])
      .to produce_url("http://#{cloud_name}-res.cloudinary.com/private_images/test/hello.jpg")
            .and empty_options
  end

  it "should support url_suffix for authenticated images" do
    expect(["test", { :url_suffix => "hello", :format => "jpg", :resource_type => :image, :type => :authenticated }])
      .to produce_url("http://res.cloudinary.com/#{cloud_name}/authenticated_images/test/hello.jpg")
            .and empty_options
  end


  describe 'root_path support' do

    it "should allow use_root_path in shared distribution" do
      # expect{Cloudinary::Utils.cloudinary_url("test", {:use_root_path=>true})}.to raise_error(CloudinaryException)
      expect(["test", { :use_root_path => true, :private_cdn => false }])
        .to produce_url("#{root_path}/test")
              .and empty_options
      expect(["test", { :use_root_path => true, :private_cdn => false, :angle => 0 }])
        .to produce_url("#{root_path}/a_0/test")
              .and empty_options
    end

    it "should support use_root_path for private_cdn" do
      expect(["test", { :use_root_path => true, :private_cdn => true }])
        .to produce_url("http://#{cloud_name}-res.cloudinary.com/test")
              .and empty_options
      expect(["test", { :use_root_path => true, :private_cdn => true, :angle => 0 }])
        .to produce_url("http://#{cloud_name}-res.cloudinary.com/a_0/test")
              .and empty_options
    end

    it "should support use_root_path together with url_suffix for private_cdn" do
      expect(["test", { :use_root_path => true, :url_suffix => "hello", :private_cdn => true }])
        .to produce_url("http://#{cloud_name}-res.cloudinary.com/test/hello")
              .and empty_options
    end

    it "should disallow use_root_path if not image/upload" do
      expect { Cloudinary::Utils.cloudinary_url("test", { :use_root_path => true, :private_cdn => true, :type => :facebook }) }.to raise_error(CloudinaryException)
      expect { Cloudinary::Utils.cloudinary_url("test", { :use_root_path => true, :private_cdn => true, :resource_type => :raw }) }.to raise_error(CloudinaryException)
    end

  end
  describe ":width, :height" do
    it "should use width and height from options only if crop is given" do
      expect(["test", { :width => 100, :height => 100 }])
        .to produce_url("#{upload_path}/test")
              .and mutate_options_to({ :width => 100, :height => 100 })
      expect(["test", { :width => 100, :height => 100, :crop => :crop }])
        .to produce_url("#{upload_path}/c_crop,h_100,w_100/test")
              .and mutate_options_to({ :width => 100, :height => 100 })
    end

    it "should not pass width and height to html in case of fit, lfill or limit crop" do
      expect(["test", { :width => 100, :height => 100, :crop => :limit }])
        .to produce_url("#{upload_path}/c_limit,h_100,w_100/test")
              .and empty_options
      expect(["test", { :width => 100, :height => 100, :crop => :lfill }])
        .to produce_url("#{upload_path}/c_lfill,h_100,w_100/test")
              .and empty_options
      expect(["test", { :width => 100, :height => 100, :crop => :fit }])
        .to produce_url("#{upload_path}/c_fit,h_100,w_100/test")
              .and empty_options
    end

    it "should not pass width and height to html in case angle was used" do
      expect(["test", { :width => 100, :height => 100, :crop => :scale, :angle => :auto }])
        .to produce_url("#{upload_path}/a_auto,c_scale,h_100,w_100/test")
              .and empty_options
    end
    it "should support size" do
      expect(["test", { :size => "10x10", :crop => :crop }])
        .to produce_url("#{upload_path}/c_crop,h_10,w_10/test")
              .and mutate_options_to({ :width => "10", :height => "10" })
    end
    it "should support auto width" do
      expect(["test", { :width => "auto:20", :crop => :fill }])
          .to produce_url("#{upload_path}/c_fill,w_auto:20/test")
      expect(["test", { :width => "auto:20:350", :crop => :fill }])
          .to produce_url("#{upload_path}/c_fill,w_auto:20:350/test")
      expect(["test", { :width => "auto:breakpoints", :crop => :fill }])
          .to produce_url("#{upload_path}/c_fill,w_auto:breakpoints/test")
      expect(["test", { :width => "auto:breakpoints_100_1900_20_15", :crop => :fill }])
          .to produce_url("#{upload_path}/c_fill,w_auto:breakpoints_100_1900_20_15/test")
      expect(["test", { :width => "auto:breakpoints:json", :crop => :fill }])
          .to produce_url("#{upload_path}/c_fill,w_auto:breakpoints:json/test")
    end
    it 'should support ih,iw' do
      expect(["test", {:width => "iw", :height => "ih", :crop => :crop}])
          .to produce_url("#{upload_path}/c_crop,h_ih,w_iw/test")
    end
  end

  it "should use x, y, radius, prefix, gravity and quality from options" do
    expect(["test", { :x => 1, :y => 2, :radius => 3, :gravity => :center, :quality => 0.4, :prefix => "a" }])
      .to produce_url("#{upload_path}/g_center,p_a,q_0.4,r_3,x_1,y_2/test")
            .and empty_options

    expect(["test", { :width => 0.5, :crop => :crop, :gravity => :auto }])
      .to produce_url("#{upload_path}/c_crop,g_auto,w_0.5/test")
            .and empty_options
  end

  describe "gravity" do
    it "should support auto" do
      expect(["test", {width: 100, height: 100, crop: 'crop', gravity: 'auto'}])
          .to produce_url("http://res.cloudinary.com/#{cloud_name}/image/upload/c_crop,g_auto,h_100,w_100/test")
                  .and mutate_options_to({width: 100, height: 100})
      expect(["test", {width: 100, height: 100, crop: 'crop', gravity: 'auto'}])
          .to produce_url("http://res.cloudinary.com/#{cloud_name}/image/upload/c_crop,g_auto,h_100,w_100/test")
                  .and mutate_options_to({width: 100, height: 100})
    end
    it "should support focal gravity" do
      ["adv_face", "adv_faces", "adv_eyes", "face", "faces", "body", "no_faces"].each do |focal|
        expect(["test", {width: 100, height: 100, crop: 'crop', gravity: "auto:#{focal}"}])
            .to produce_url("http://res.cloudinary.com/#{cloud_name}/image/upload/c_crop,g_auto:#{focal},h_100,w_100/test")
                    .and mutate_options_to({width: 100, height: 100})
      end
    end
    it "should support auto level with thumb cropping" do
      [0, 10, 100].each do |level|
        expect(["test", {width: 100, height: 100, crop: 'thumb', gravity: "auto:#{level}"}])
            .to produce_url("http://res.cloudinary.com/#{cloud_name}/image/upload/c_thumb,g_auto:#{level},h_100,w_100/test")
                    .and mutate_options_to({width: 100, height: 100})
        expect(["test", {width: 100, height: 100, crop: 'thumb', gravity: "auto:adv_faces:#{level}"}])
            .to produce_url("http://res.cloudinary.com/#{cloud_name}/image/upload/c_thumb,g_auto:adv_faces:#{level},h_100,w_100/test")
                    .and mutate_options_to({width: 100, height: 100})
      end
    end
    it "should support custom_no_override" do
      expect(["test", {width: 100, height: 100, crop: 'crop', gravity: "auto:custom_no_override"}])
          .to produce_url("http://res.cloudinary.com/#{cloud_name}/image/upload/c_crop,g_auto:custom_no_override,h_100,w_100/test")
                  .and mutate_options_to({width: 100, height: 100})
    end
  end

  describe ":quality" do
    it "support a percent value" do
      expect(["test", { :x => 1, :y => 2, :radius => 3, :gravity => :center, :quality => 80, :prefix => "a" }])
          .to produce_url("#{upload_path}/g_center,p_a,q_80,r_3,x_1,y_2/test")

      expect(["test", { :x => 1, :y => 2, :radius => 3, :gravity => :center, :quality => "80:444", :prefix => "a" }])
          .to produce_url("#{upload_path}/g_center,p_a,q_80:444,r_3,x_1,y_2/test")
    end
    it "should support auto value" do

      expect(["test", { :x => 1, :y => 2, :radius => 3, :gravity => :center, :quality => "auto", :prefix => "a" }])
          .to produce_url("#{upload_path}/g_center,p_a,q_auto,r_3,x_1,y_2/test")

      expect(["test", { :x => 1, :y => 2, :radius => 3, :gravity => :center, :quality => "auto:good", :prefix => "a" }])
          .to produce_url("#{upload_path}/g_center,p_a,q_auto:good,r_3,x_1,y_2/test")

    end
  end

  describe ":transformation" do
    it "should support named tranformation" do
      expect(["test", { :transformation => "blip" }])
        .to produce_url("#{upload_path}/t_blip/test")
              .and empty_options
    end

    it "should support array of named tranformations" do
      expect(["test", { :transformation => ["blip", "blop"] }])
        .to produce_url("#{upload_path}/t_blip.blop/test")
              .and empty_options
    end

    it "should support base tranformation" do
      expect(["test", { :transformation => { :x => 100, :y => 100, :crop => :fill }, :crop => :crop, :width => 100 }])
        .to produce_url("#{upload_path}/c_fill,x_100,y_100/c_crop,w_100/test")
              .and mutate_options_to({ :width => 100 })
    end

    it "should support array of base tranformations" do
      expect(["test", { :transformation => [{ :x => 100, :y => 100, :width => 200, :crop => :fill }, { :radius => 10 }], :crop => :crop, :width => 100 }])
        .to produce_url("#{upload_path}/c_fill,w_200,x_100,y_100/r_10/c_crop,w_100/test")
              .and mutate_options_to({ :width => 100 })
    end

    it "should support array of tranformations" do
      result = Cloudinary::Utils.generate_transformation_string([{ :x => 100, :y => 100, :width => 200, :crop => :fill }, { :radius => 10 }])
      expect(result).to eq("c_fill,w_200,x_100,y_100/r_10")
    end

    it "should not include empty tranformations" do
      expect(["test", { :transformation => [{}, { :x => 100, :y => 100, :crop => :fill }, {}] }])
        .to produce_url("#{upload_path}/c_fill,x_100,y_100/test")
              .and empty_options
    end
  end


  it "should use type from options" do
    expect(["test", { :type => :facebook }])
      .to produce_url("#{root_path}/image/facebook/test")
            .and empty_options
  end

  it "should use resource_type from options" do
    expect(["test", { :resource_type => :raw }])
      .to produce_url("#{root_path}/raw/upload/test")
            .and empty_options
  end

  it "should ignore http links only if type is not given or is asset" do
    expect(["http://test", { :type => nil }])
      .to produce_url("http://test")
            .and empty_options
    expect(["http://test", { :type => :asset }])
      .to produce_url("http://test")
            .and empty_options
    expect(["http://test", { :type => :fetch }])
      .to produce_url("#{root_path}/image/fetch/http://test")
            .and empty_options
  end

  it "should use allow absolute links to /images" do
    expect(["/images/test", {}])
      .to produce_url("#{upload_path}/test")
            .and empty_options
  end

  it "should use ignore absolute links not to /images" do
    expect(["/js/test", {}])
      .to produce_url("/js/test")
            .and empty_options
  end

  it "should escape fetch urls" do
    expect(["http://blah.com/hello?a=b", { :type => :fetch }])
      .to produce_url("#{root_path}/image/fetch/http://blah.com/hello%3Fa%3Db")
            .and empty_options
  end

  it "should should escape http urls" do
    expect(["http://www.youtube.com/watch?v=d9NF2edxy-M", { :type => :youtube }])
      .to produce_url("#{root_path}/image/youtube/http://www.youtube.com/watch%3Fv%3Dd9NF2edxy-M")
            .and empty_options
  end

  it "should support background" do
    expect(["test", { :background => "red" }])
      .to produce_url("#{upload_path}/b_red/test")
            .and empty_options
    expect(["test", { :background => "#112233" }])
      .to produce_url("#{upload_path}/b_rgb:112233/test")
            .and empty_options
  end

  it "should support default_image" do
    expect(["test", { :default_image => "default" }])
      .to produce_url("#{upload_path}/d_default/test")
            .and empty_options
  end

  it "should support angle" do
    expect(["test", { :angle => "55" }])
      .to produce_url("#{upload_path}/a_55/test")
            .and empty_options
    expect(["test", { :angle => ["auto", "55"] }])
      .to produce_url("#{upload_path}/a_auto.55/test")
            .and empty_options
  end

  it "should support format for fetch urls" do
    expect(["http://cloudinary.com/images/logo.png", { :format => "jpg", :type => :fetch }])
      .to produce_url("#{root_path}/image/fetch/f_jpg/http://cloudinary.com/images/logo.png")
            .and empty_options
  end

  it "should support effect" do
    expect(["test", { :effect => "sepia" }])
      .to produce_url("#{upload_path}/e_sepia/test")
            .and empty_options
  end

  it "should support effect with hash param" do
    expect(["test", { :effect => { "sepia" => -10 } }])
      .to produce_url("#{upload_path}/e_sepia:-10/test")
            .and empty_options
  end

  it "should support effect with array param" do
    expect(["test", { :effect => ["sepia", 10] }])
      .to produce_url("#{upload_path}/e_sepia:10/test")
            .and empty_options
  end

  it "should support keyframe_interval" do
    expect(["test", { :keyframe_interval => 10 }])
      .to produce_url("#{upload_path}/ki_10/test")
            .and empty_options
  end

  it "should support streaming_profile" do
    expect(["test", { :streaming_profile => "some-profile" }])
      .to produce_url("#{upload_path}/sp_some-profile/test")
            .and empty_options
  end

  shared_examples "a signed url" do |specific_options = {}, specific_transformation = ""|
    let(:expected_transformation) do
      (specific_transformation.blank? || specific_transformation.match(/\/$/)) ? specific_transformation : "#{specific_transformation}/"
    end
    let! (:authenticated_image) do
      Cloudinary::Uploader.upload "http://res.cloudinary.com/demo/image/upload/sample.jpg",
                                  :type => 'authenticated',
                                  :tags => TEST_TAG
    end
    let(:options) { { :version => authenticated_image['version'], :sign_url => true, :type => :authenticated }.merge(specific_options) }
    let(:authenticated_path) { "#{root_path}/image/authenticated" }

    it "should correctly sign URL with version" do
      expect(["#{authenticated_image['public_id']}.jpg", options])
        .to produce_url(%r"#{authenticated_path}/s--[\w-]+--/#{expected_transformation}v#{authenticated_image['version']}/#{authenticated_image['public_id']}.jpg")
              .and empty_options
    end
    it "should correctly sign URL with transformation and version" do
      options[:transformation] = { :crop => "crop", :width => 10, :height => 20 }
      expect(["#{authenticated_image['public_id']}.jpg", options])
        .to produce_url(%r"#{authenticated_path}/s--[\w-]+--/c_crop,h_20,w_10/#{expected_transformation}v#{authenticated_image['version']}/#{authenticated_image['public_id']}.jpg")
              .and empty_options
    end
    it "should correctly sign URL with transformation" do
      options[:transformation] = { :crop => "crop", :width => 10, :height => 20 }
      expect(["#{authenticated_image['public_id']}.jpg", options])
        .to produce_url(%r"#{authenticated_path}/s--[\w-]+--/c_crop,h_20,w_10/#{expected_transformation}v#{authenticated_image['version']}/#{authenticated_image['public_id']}.jpg")
              .and empty_options
                     .and be_served_by_cloudinary
    end
    it "should correctly sign fetch URL" do
      options[:type] = :fetch
      expect(["http://res.cloudinary.com/demo/sample.png", options])
        .to produce_url(%r"^#{root_path}/image/fetch/s--[\w-]+--/#{expected_transformation}v#{authenticated_image['version']}/http://res.cloudinary.com/demo/sample.png$")
              .and empty_options
    end
  end


  { 'overlay' => :l, :underlay => :u }.each do |param, letter|
    describe param do
      let(:root_path) { "http://res.cloudinary.com/#{cloud_name}" }
      let(:layers_options) { [
        # [name,                    options,                                              result]
        ["string", "text:hello", "text:hello"],
        ["public_id", { "public_id" => "logo" }, "logo"],
        ["public_id with folder", { "public_id" => "folder/logo" }, "folder:logo"],
        ["private", { "public_id" => "logo", "type" => "private" }, "private:logo"],
        ["format", { "public_id" => "logo", "format" => "png" }, "logo.png"],
        ["video", { "resource_type" => "video", "public_id" => "cat" }, "video:cat"],
      ] }
      it "should support #{param}" do
        layers_options.each do |name, options, result|
          expect(["test", { param => options }]).to produce_url("#{upload_path}/#{letter}_#{result}/test").and empty_options
        end
      end

      it "should not pass width/height to html for #{param}" do
        expect(["test", { param => "text:hello", :height => 100, :width => 100 }])
          .to produce_url("#{upload_path}/h_100,#{letter}_text:hello,w_100/test")
                .and empty_options
      end
    end
  end

  describe "text" do

    text_layer   = "Hello World, /Nice to meet you?"
    text_encoded = "Hello%20World%252C%20%252FNice%20to%20meet%20you%3F"

    before :all do
      Cloudinary::Uploader.text(text_layer, {
        :public_id   => "test_text",
        :overwrite   => true,
        :font_family => "Arial",
        :font_size   => "18",
        :tags        => TEST_TAG
      })
      srt = Tempfile.new(['test_subtitles', '.srt'])
      srt.write <<-END
      1
      00:00:10,500 --> 00:00:13,000
      Hello World, Nice to meet you?

      END
      srt.rewind
      Cloudinary::Uploader.upload srt, :public_id => 'subtitles.srt', :resource_type => 'raw', :overwrite => true, :tags => TEST_TAG
      srt.unlink
    end

    include_context "cleanup"

    { 'overlay' => 'l' }.each do |param, short| # 'underlay' => 'u' behaves the same as overlay
      describe param do
        let(:root_path) { "http://res.cloudinary.com/#{cloud_name}" }
        # [name, options, result]
        layers_options= [
          ["string", "text:test_text:hello", "text:test_text:hello"],
          ["explicit layer parameter", "text:test_text:#{text_encoded}", "text:test_text:#{text_encoded}"],
          ["text parameter", { :public_id => "test_text", :text => text_layer }, "text:test_text:#{text_encoded}"],
          ["text with font family and size parameters", { :text => text_layer, :font_family => "Arial", :font_size => "18" }, "text:Arial_18:#{text_encoded}"],
          ["text with text style parameter", { :text => text_layer, :font_family => "Arial", :font_size => "18", :font_weight => "bold", :font_style => "italic", :letter_spacing => 4, :line_spacing => 2 }, "text:Arial_18_bold_italic_letter_spacing_4_line_spacing_2:#{text_encoded}"],
          ["subtitles", { :resource_type => "subtitles", :public_id => "subtitles.srt" }, "subtitles:subtitles.srt"],
          ["subtitles with font family and size", { :resource_type => "subtitles", :public_id => "subtitles.srt", :font_family => "Arial", :font_size => "40" }, "subtitles:Arial_40:subtitles.srt"]
        ]
        layers_options.each do |name, options, result|
          it "should support #{name}" do
            expect(["sample.jpg", { param => options }]).to produce_url("#{upload_path}/#{short}_#{result}/sample.jpg").and empty_options
            # expect("#{upload_path}/#{short}_#{result}/sample.jpg").to be_served_by_cloudinary
          end
          unless options.is_a? String || param == 'underlay'
            op        = Hash.new
            op[param] = options
            it_behaves_like "a signed url", op, "#{short}_#{result}"
          end
        end

        it "should not pass width/height to html for #{param}" do
          expect(["test", { param => "text:test_text", :height => 100, :width => 100 }])
            .to produce_url("#{upload_path}/h_100,#{short}_text:test_text,w_100/test")
                  .and empty_options

        end
      end
    end
  end


  it "should use ssl_detected if secure is not given as parameter and not set to true in configuration" do
    expect(["test", { :ssl_detected => true }])
      .to produce_url("https://res.cloudinary.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should use secure if given over ssl_detected and configuration" do
    Cloudinary.config.secure = true
    expect(["test", { :ssl_detected => true, :secure => false }])
      .to produce_url("#{upload_path}/test")
            .and empty_options
  end

  it "should use secure: true from configuration over ssl_detected" do
    Cloudinary.config.secure = true
    expect(["test", { :ssl_detected => false }])
      .to produce_url("https://res.cloudinary.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should support extenal cname" do
    expect(["test", { :cname => "hello.com" }])
      .to produce_url("http://hello.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should support extenal cname with cdn_subdomain on" do
    expect(["test", { :cname => "hello.com", :cdn_subdomain => true }])
      .to produce_url("http://a2.hello.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should support cdn_subdomain with secure on if using shared_domain" do
    expect(["test", { :secure => true, :cdn_subdomain => true }])
      .to produce_url("https://res-2.cloudinary.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should support secure_cdn_subdomain false override with secure" do
    expect(["test", { :secure => true, :cdn_subdomain => true, :secure_cdn_subdomain => false }])
      .to produce_url("https://res.cloudinary.com/#{cloud_name}/image/upload/test")
            .and empty_options
  end

  it "should support secure_cdn_subdomain true override with secure" do
    expect(["test", { :secure => true, :cdn_subdomain => true, :secure_cdn_subdomain => true, :private_cdn => true }])
      .to produce_url("https://#{cloud_name}-res-2.cloudinary.com/image/upload/test")
            .and empty_options
  end

  it "should support string param" do
    expect(["test", { "effect" => { "sepia" => 10 } }])
      .to produce_url("#{upload_path}/e_sepia:10/test")
            .and empty_options
  end

  it "should support border" do
    expect(["test", { "border" => { :width => 5 } }])
      .to produce_url("#{upload_path}/bo_5px_solid_black/test")
            .and empty_options
    expect(["test", { "border" => { :width => 5, :color => "#ffaabbdd" } }])
      .to produce_url("#{upload_path}/bo_5px_solid_rgb:ffaabbdd/test")
            .and empty_options
    expect(["test", { "border" => "1px_solid_blue" }])
      .to produce_url("#{upload_path}/bo_1px_solid_blue/test")
            .and empty_options
    expect(["test", { "border" => "2" }]).to produce_url("#{upload_path}/test").and mutate_options_to({ :border => "2" })
  end

  it "should support flags" do
    expect(["test", { "flags" => "abc" }])
      .to produce_url("#{upload_path}/fl_abc/test")
            .and empty_options
    expect(["test", { "flags" => ["abc", "def"] }])
      .to produce_url("#{upload_path}/fl_abc.def/test")
            .and empty_options
  end

  it "should support aspect ratio" do
    expect(["test", { "aspect_ratio" => "1.0" }])
      .to produce_url("#{upload_path}/ar_1.0/test")
            .and empty_options
    expect(["test", { "aspect_ratio" => "3:2" }])
      .to produce_url("#{upload_path}/ar_3:2/test")
            .and empty_options
  end

  it "build_upload_params should not destroy options" do
    options = { :width => 100, :crop => :scale }
    expect(Cloudinary::Uploader.build_upload_params(options)[:transformation]).to eq("c_scale,w_100")
    expect(options.length).to eq(2)
  end

  it "build_upload_params canonize booleans" do
    options = { :backup         => true, :use_filename => false, :colors => :true,
                :image_metadata => :false, :invalidate => 1 }
    params  = Cloudinary::Uploader.build_upload_params(options)
    expect(Cloudinary::Api.only(params, *options.keys))
      .to eq(:backup         => 1,
             :use_filename   => 0,
             :colors         => 1,
             :image_metadata => 0,
             :invalidate     => 1
          )
    options = { :colors => "true", :exif => "false", :eager_async => "1" }
    params  = Cloudinary::Uploader.build_upload_params(options)
    expect(Cloudinary::Api.only(params, *options.keys))
      .to eq(:exif => 0, :colors => 1, :eager_async => 1)
    expect(Cloudinary::Uploader.build_upload_params(:backup => nil)[:backup]).to be_nil
    expect(Cloudinary::Uploader.build_upload_params({})[:backup]).to be_nil
  end

  it "should add version if public_id contains /" do
    expect(["folder/test", {}])
      .to produce_url("#{upload_path}/v1/folder/test")
            .and empty_options
    expect(["folder/test", { :version => 123 }])
      .to produce_url("#{upload_path}/v123/folder/test")
            .and empty_options
  end

  it "should not add version if public_id contains version already" do
    expect(["v1234/test", {}])
      .to produce_url("#{upload_path}/v1234/test")
            .and empty_options
  end

  it "should allow to shorted image/upload urls" do
    expect(["test", { :shorten => true }])
      .to produce_url("#{root_path}/iu/test")
            .and empty_options
  end

  it "should allow to use folders in PreloadedFile" do
    signature = Cloudinary::Utils.api_sign_request({ :public_id => "folder/file", :version => "1234" }, Cloudinary.config.api_secret)
    preloaded = Cloudinary::PreloadedFile.new("image/upload/v1234/folder/file.jpg#" + signature)
    expect(preloaded).to be_valid
  end

  it "should escape public_ids" do
    [
      ["a b", "a%20b"],
      ["a+b", "a%2Bb"],
      ["a%20b", "a%20b"],
      ["a-b", "a-b"],
      ["a??b", "a%3F%3Fb"],
      ["parentheses(interject)", "parentheses%28interject%29"]
    ].each do
    |source, target|
      expect(Cloudinary::Utils.cloudinary_url(source)).to eq("#{upload_path}/#{target}")
    end
  end


  describe ":sign_url" do
    it_behaves_like "a signed url"
  end

  describe ":sign_version (deprecated)" do
    it_behaves_like "a signed url", :sign_version => true
  end

  it "should correctly sign_request" do
    params = Cloudinary::Utils.sign_request(
      {
        :public_id => "folder/file",
        :version   => "1234" },
      {
        :cloud_name => "demo",
        :api_key    => "1234",
        :api_secret => "b"
      }
    )
    expect(params).to include(:signature => "7a3349cbb373e4812118d625047ede50b90e7b67")
  end

  it "should support responsive width" do
    expect(["test", { :width => 100, :height => 100, :crop => :crop, :responsive_width => true }])
      .to produce_url("#{upload_path}/c_crop,h_100,w_100/c_limit,w_auto/test")
            .and mutate_options_to({ :responsive => true })
    Cloudinary.config.responsive_width_transformation = { :width => :auto, :crop => :pad }
    expect(["test", { :width => 100, :height => 100, :crop => :crop, :responsive_width => true }])
      .to produce_url("#{upload_path}/c_crop,h_100,w_100/c_pad,w_auto/test")
            .and mutate_options_to({ :responsive => true })
  end

  it "should correctly encode double arrays" do
    expect(Cloudinary::Utils.encode_double_array([1, 2, 3, 4])).to eq("1,2,3,4")
    expect(Cloudinary::Utils.encode_double_array([[1, 2, 3, 4], [5, 6, 7, 8]])).to eq("1,2,3,4|5,6,7,8")
  end

  describe ":if" do
    describe 'with literal condition string' do
      it "should include the if parameter as the first component in the transformation string" do
        expect(["sample", { if: "w_lt_200", crop: "fill", height: 120, width: 80 }])
          .to produce_url("#{upload_path}/if_w_lt_200,c_fill,h_120,w_80/sample")
        expect(["sample", { crop: "fill", height: 120, if: "w_lt_200", width: 80 }])
          .to produce_url("#{upload_path}/if_w_lt_200,c_fill,h_120,w_80/sample")

      end
      it "should allow multiple conditions when chaining transformations " do
        expect(["sample", transformation: [{ if: "w_lt_200", crop: "fill", height: 120, width: 80 },
                                           { if: "w_gt_400", crop: "fit", width: 150, height: 150 },
                                           { effect: "sepia" }]])
          .to produce_url("#{upload_path}/if_w_lt_200,c_fill,h_120,w_80/if_w_gt_400,c_fit,h_150,w_150/e_sepia/sample")
      end

      describe "including spaces and operators" do
        it "should translate operators" do
          expect(["sample", { if: "w < 200", crop: "fill", height: 120, width: 80 }])
            .to produce_url("#{upload_path}/if_w_lt_200,c_fill,h_120,w_80/sample")
        end
      end

      describe 'if end' do
        it "should include the if_end as the last parameter in its component" do
          expect(["sample", transformation: [{ if: "w_lt_200" },
                                             { crop: "fill", height: 120, width: 80, effect: "sharpen" },
                                             { effect: "brightness:50" },
                                             { effect: "shadow", color: "red" },
                                             { if: "end" }]])
            .to produce_url("#{upload_path}/if_w_lt_200/c_fill,e_sharpen,h_120,w_80/e_brightness:50/co_red,e_shadow/if_end/sample")
        end
        it "should support if_else with transformation parameters" do
          expect(["sample", transformation: [{ if: "w_lt_200", crop: "fill", height: 120, width: 80 },
                                             { if: "else", crop: "fill", height: 90, width: 100 }]])
            .to produce_url("#{upload_path}/if_w_lt_200,c_fill,h_120,w_80/if_else,c_fill,h_90,w_100/sample")
        end
        it "if_else should be without any transformation parameters" do
          expect(["sample", transformation: [{ if: "w_lt_200" },
                                             { crop: "fill", height: 120, width: 80 },
                                             { if: "else" },
                                             { crop: "fill", height: 90, width: 100 }]])
            .to produce_url("#{upload_path}/if_w_lt_200/c_fill,h_120,w_80/if_else/c_fill,h_90,w_100/sample")
        end
      end
      it "should support and translate operators:  '=', '!=', '<', '>', '<=', '>=', '&&', '||'" do

        all_operators =
          'if_' +
            'w_eq_0_and' +
            '_w_ne_0_or' +
            '_h_lt_0_and' +
            '_ar_gt_0_and' +
            '_pc_lte_0_and' +
            '_fc_gte_0' +
            ',e_grayscale'

        expect( ["sample",
                 :if =>"width = 0 && w != 0 || height < 0 and aspect_ratio > 0 and page_count <= 0 and face_count >= 0",
                 :effect =>"grayscale"])
          .to produce_url("#{upload_path}/#{all_operators}/sample")
    end

    end
  end

  describe "variables" do
    it "array should define a set of variables" do
      options = {
          :if => "face_count > 2",
          :variables => [ ["$z", 5], ["$foo", "$z * 2"] ],
          :crop => "scale", :width => "$foo * 200"
        }
      t = Cloudinary::Utils.generate_transformation_string options
      expect(t).to eq("if_fc_gt_2,$z_5,$foo_$z_mul_2,c_scale,w_$foo_mul_200")
    end
    it "'$key' should define a variable" do
      options = { :transformation => [
        {"$foo" => 10 },
        {:if => "face_count > 2"},
        {:crop => "scale", :width => "$foo * 200 / face_count"},
        {:if => "end"}
      ] }
      t = Cloudinary::Utils.generate_transformation_string options
      expect(t).to eq("$foo_10/if_fc_gt_2/c_scale,w_$foo_mul_200_div_fc/if_end")
    end
    it "should support text values" do
      expect( ["sample", :effect => "$efname:100", "$efname" => "!blur!"]).to produce_url "#{upload_path}/$efname_!blur!,e_$efname:100/sample"

    end
    it "should support string interpolation" do
      expect( ["sample", :crop => "scale", :overlay => {:text => "$(start)Hello $(name)$(ext), $(no ) $( no)$(end)", :font_family => "Arial", :font_size => "18"} ]).to produce_url "#{upload_path}/c_scale,l_text:Arial_18:$(start)Hello%20$(name)$(ext)%252C%20%24%28no%20%29%20%24%28%20no%29$(end)/sample"

    end
  end

  describe "context" do
    it 'should escape pipe and backslash characters' do
      context = {"caption" => "different = caption", "alt2" => "alt|alternative"}
      result = Cloudinary::Utils.encode_context(context)
      expect(result).to eq("caption=different \\= caption|alt2=alt\\|alternative")
                            .or eq("alt2=alt\\|alternative|caption=different \\= caption")

    end
    it 'should support symbols' do
      context = {:symbol_key => "string_value", "string_key" => :symbol_value}
      result = Cloudinary::Utils.encode_context(context)
      expect(result).to eq("string_key=symbol_value|symbol_key=string_value")
                  .or eq("symbol_key=string_value|string_key=symbol_value")
    end
  end
end
