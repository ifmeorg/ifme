require 'spec_helper'
require 'cloudinary'

RSpec.configure do |c|
  c.filter_run_excluding :large => true
end

describe Cloudinary::Uploader do
  break puts("Please setup environment for api test to run") if Cloudinary.config.api_secret.blank?
  include_context "cleanup", TIMESTAMP_TAG

  it "should successfully upload file" do
    result = Cloudinary::Uploader.upload(TEST_IMG, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["width"]).to eq(TEST_IMG_W)
    expect(result["height"]).to eq(TEST_IMG_H)
    expected_signature = Cloudinary::Utils.api_sign_request({:public_id=>result["public_id"], :version=>result["version"]}, Cloudinary.config.api_secret)
    expect(result["signature"]).to eq(expected_signature)
  end

  it "should successfully upload a file from pathname", :pathname => true do
    result = Cloudinary::Uploader.upload(Pathname.new(TEST_IMG), :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["width"]).to eq(TEST_IMG_W)
  end

  it "should successfully upload file by url" do
    result = Cloudinary::Uploader.upload("http://cloudinary.com/images/old_logo.png", :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["width"]).to eq(TEST_IMG_W)
    expect(result["height"]).to eq(TEST_IMG_H)
    expected_signature = Cloudinary::Utils.api_sign_request({:public_id=>result["public_id"], :version=>result["version"]}, Cloudinary.config.api_secret)
    expect(result["signature"]).to eq(expected_signature)
  end

  it "should successfully upload file asynchronously" do
    result = Cloudinary::Uploader.upload(Pathname.new(TEST_IMG), :async => true)
    expect(result["status"]).to eq("pending")
  end

  describe '.rename' do
    before(:all) do
      @result        = Cloudinary::Uploader.upload(TEST_IMG, :tags => [TEST_TAG, TIMESTAMP_TAG])
      @resource_1_id = @result["public_id"]
      @resource_1_type = @result["type"]
      result         = Cloudinary::Uploader.upload("spec/favicon.ico", :tags => [TEST_TAG, TIMESTAMP_TAG])
      @resource_2_id = result["public_id"]
    end

    it 'should rename a resource' do
      Cloudinary::Uploader.rename(@resource_1_id, @resource_1_id+"2")
      expect(Cloudinary::Api.resource(@resource_1_id+"2")).not_to be_nil
      @resource_1_id = @resource_1_id+"2" # will not update if expect fails
    end
    it 'should not allow renaming to an existing ID' do
      id             = @resource_2_id
      @resource_2_id = @resource_1_id+"2" # if rename doesn't fail, this is the new ID
      expect { Cloudinary::Uploader.rename(id, @resource_1_id+"2") }.to raise_error(CloudinaryException)
      @resource_2_id = id
    end
    it 'should allow changing type of an uploaded resource' do
      id = @resource_2_id
      from_type = @resource_1_type
      to_type = "private"
      Cloudinary::Uploader.rename(id, id, :type => from_type, :to_type => to_type)
      expect(Cloudinary::Api.resource(id, type: to_type)).to_not be_empty
      Cloudinary::Uploader.rename(id, id, :type => to_type, :to_type => from_type)
    end
    context ':overwrite => true' do
      it 'should rename to an existing ID' do
        new_id = Cloudinary::Uploader.upload(TEST_IMG, :tags => [TEST_TAG, TIMESTAMP_TAG])["public_id"]
        Cloudinary::Uploader.rename(@resource_2_id, new_id, :overwrite => true)
        expect(Cloudinary::Api.resource(new_id)["format"]).to eq("ico")
        @resource_2_id = new_id # will not update if expect fails
      end
    end
    context ':invalidate => true' do
      it 'should notify the server to invalidate the resource in the CDN' do
        # Can't test the result, so we just verify the parameter is send to the server
        expected ={
            :url => /.*\/rename$/,
            [:payload, :invalidate] => 1,
            [:payload, :from_public_id] => @resource_2_id,
            [:payload, :to_public_id] => @resource_2_id+"2"
        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
        Cloudinary::Uploader.rename(@resource_2_id, @resource_2_id+"2", :invalidate => true) # will not affect the server
      end

    end
  end

  it "should support explicit" do
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :public_id] => "sample", [:payload, :eager] => "c_scale,w_2.0"))
    result = Cloudinary::Uploader.explicit("sample", :type=>"upload", :eager=>[{:crop=>"scale", :width=>"2.0"}])
  end
  
  it "should support eager" do
    result = Cloudinary::Uploader.upload(TEST_IMG, :eager =>[{ :crop =>"scale", :width =>"2.0"}], :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["eager"].length).to be(1)
    expect(result).to have_deep_hash_values_of(["eager", 0, "transformation"] => "c_scale,w_2.0")
    result = Cloudinary::Uploader.upload(TEST_IMG, :eager =>"c_scale,w_2.0", :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["eager"].length).to be(1)
    expect(result).to have_deep_hash_values_of(["eager", 0, "transformation"] => "c_scale,w_2.0")
    result = Cloudinary::Uploader.upload(TEST_IMG, :eager =>[
                          "c_scale,w_2.0",
                          { :crop =>"crop", :width =>"0.5", :format => "tiff"},
                          [[{:crop =>"crop", :width =>"0.5"},{:angle =>90}]],
                          [[{:crop =>"crop", :width =>"0.5"},{:angle =>90}],"tiff"]
                      ], :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["eager"].length).to be(4)
    expect(result).to have_deep_hash_values_of(
                          ["eager", 0, "transformation"] => "c_scale,w_2.0",
                          ["eager", 1, "transformation"] => "c_crop,w_0.5/tiff",
                          ["eager", 2, "transformation"] => "c_crop,w_0.5/a_90",
                          ["eager", 3, "transformation"] => "c_crop,w_0.5/a_90/tiff"
                      )
  end

  it "should support headers" do
    Cloudinary::Uploader.upload(TEST_IMG, :headers =>["Link: 1"], :tags => [TEST_TAG, TIMESTAMP_TAG])
    Cloudinary::Uploader.upload(TEST_IMG, :headers =>{ "Link" => "1"}, :tags => [TEST_TAG, TIMESTAMP_TAG])
  end

  it "should successfully generate text image" do
    result = Cloudinary::Uploader.text("hello world", :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["width"]).to be > 1
    expect(result["height"]).to be > 1
  end

  describe "tag" do
    describe "add_tag" do
      it "should correctly add tags" do
        expected ={
            :url => /.*\/tags/,
            [:payload, :tag] => "new_tag",
            [:payload, :public_ids] => ["some_public_id1", "some_public_id2"],
            [:payload, :command] => "add"
        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

        Cloudinary::Uploader.add_tag( "new_tag", ["some_public_id1", "some_public_id2"])
      end
    end

    describe "remove_tag" do
      it "should correctly remove tag" do
        expected ={
            :url => /.*\/tags/,
            [:payload, :tag] => "tag",
            [:payload, :public_ids] => ["some_public_id1", "some_public_id2"],
            [:payload, :command] => "remove"
        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

        Cloudinary::Uploader.remove_tag("tag", ["some_public_id1", "some_public_id2"])
      end
    end

    describe "replace_tag" do
      it "should correctly replace tag" do
        expected ={
            :url => /.*\/tags/,
            [:payload, :tag] => "tag",
            [:payload, :public_ids] => ["some_public_id1", "some_public_id2"],
            [:payload, :command] => "replace"
        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

        Cloudinary::Uploader.replace_tag("tag", ["some_public_id1", "some_public_id2"])
      end
    end

    describe "remove_all_tags" do
      it "should correctly remove all tags" do
        expected ={
            :url => /.*\/tags/,
            [:payload, :public_ids] => ["some_public_id1", "some_public_id2"],
            [:payload, :command] => "remove_all"
        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

        Cloudinary::Uploader.remove_all_tags(["some_public_id1", "some_public_id2"])
      end
    end

  end


  describe "context", :focus => true do
    describe "add_context" do
      it "should correctly add context", :focus => true do
        expected ={
            :url => /.*\/context/,
            [:payload, :context] => "key1=value1|key2=value2",
            [:payload, :public_ids] => ["some_public_id1", "some_public_id2"],
            [:payload, :command] => "add"
        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

        Cloudinary::Uploader.add_context( {:key1 => :value1, :key2 => :value2}, ["some_public_id1", "some_public_id2"])
      end
    end

    describe "remove_all_context" do
      it "should correctly remove all context", :focus => true do
        expected ={
            :url => /.*\/context/,
            [:payload, :public_ids] => ["some_public_id1", "some_public_id2"],
            [:payload, :command] => "remove_all",
            [:payload, :type] => "private"

        }
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

        Cloudinary::Uploader.remove_all_context(["some_public_id1", "some_public_id2"], :type => "private")
      end
    end

  end


  
  it "should correctly handle unique_filename" do
    result = Cloudinary::Uploader.upload(TEST_IMG, :use_filename => true, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["public_id"]).to match(/logo_[a-zA-Z0-9]{6}/)
    result = Cloudinary::Uploader.upload(TEST_IMG, :use_filename => true, :unique_filename => false, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["public_id"]).to eq("logo")
  end
  
  it "should allow whitelisted formats if allowed_formats", :allowed=>true do
    result = Cloudinary::Uploader.upload(TEST_IMG, :allowed_formats => ["png"], :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["format"]).to eq("png")
  end
  
  it "should prevent non whitelisted formats from being uploaded if allowed_formats is specified", :allowed=>true do
    expect{Cloudinary::Uploader.upload(TEST_IMG, :allowed_formats => ["jpg"], :tags => [TEST_TAG, TIMESTAMP_TAG])}.to raise_error(CloudinaryException)
  end
  
  it "should allow non whitelisted formats if type is specified and convert to that type", :allowed=>true do
    result = Cloudinary::Uploader.upload(TEST_IMG, :allowed_formats => ["jpg"], :format => "jpg", :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["format"]).to eq("jpg")
  end
  
  it "should allow sending face coordinates" do
    coordinates = [[120, 30, 109, 150], [121, 31, 110, 151]]
    result_coordinates = [[120, 30, 109, 51], [121, 31, 110, 51]]
    result = Cloudinary::Uploader.upload(TEST_IMG, { :face_coordinates => coordinates, :faces => true, :tags => [TEST_TAG, TIMESTAMP_TAG]})
    expect(result["faces"]).to eq(result_coordinates)

    different_coordinates = [[122, 32, 111, 152]]
    Cloudinary::Uploader.explicit(result["public_id"], {:face_coordinates => different_coordinates, :faces => true, :type => "upload", :tags => [TEST_TAG, TIMESTAMP_TAG]})
    info = Cloudinary::Api.resource(result["public_id"], {:faces => true})
    expect(info["faces"]).to eq(different_coordinates)
  end
  
  it "should allow sending context" do
    context = {"key1"=>'value1', "key2" => 'valu\e2', "key3" => 'val=u|e3', "key4" => 'val\=ue'}
    result = Cloudinary::Uploader.upload(TEST_IMG, { :context => context, :tags => [TEST_TAG, TIMESTAMP_TAG]})
    info = Cloudinary::Api.resource(result["public_id"], {:context => true})
    expect(info["context"]).to eq({"custom" => context})
  end
  
  it "should support requesting manual moderation" do
    result = Cloudinary::Uploader.upload(TEST_IMG, { :moderation => :manual, :tags => [TEST_TAG, TIMESTAMP_TAG]})
    expect(result["moderation"][0]["status"]).to eq("pending")
    expect(result["moderation"][0]["kind"]).to eq("manual")
  end
    
  it "should support requesting raw conversion" do
    expect{Cloudinary::Uploader.upload("spec/docx.docx", {:resource_type => :raw, :raw_convert => :illegal, :tags => [TEST_TAG, TIMESTAMP_TAG]})}.to raise_error(CloudinaryException, /Illegal value|not a valid/)
  end
  
  it "should support requesting categorization" do
    expect{Cloudinary::Uploader.upload(TEST_IMG, { :categorization => :illegal, :tags => [TEST_TAG, TIMESTAMP_TAG]})}.to raise_error(CloudinaryException, /Illegal value|not a valid|is invalid/)
  end
  
  it "should support requesting detection" do
    expect{Cloudinary::Uploader.upload(TEST_IMG, { :detection => :illegal, :tags => [TEST_TAG, TIMESTAMP_TAG]})}.to raise_error(CloudinaryException, /Illegal value|not a valid/)
  end

  it "should support upload_large", :large => true do
    io = StringIO.new
    header = "BMJ\xB9Y\x00\x00\x00\x00\x00\x8A\x00\x00\x00|\x00\x00\x00x\x05\x00\x00x\x05\x00\x00\x01\x00\x18\x00\x00\x00\x00\x00\xC0\xB8Y\x00a\x0F\x00\x00a\x0F\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\x00\x00\xFF\x00\x00\xFF\x00\x00\x00\x00\x00\x00\xFFBGRs\x00\x00\x00\x00\x00\x00\x00\x00T\xB8\x1E\xFC\x00\x00\x00\x00\x00\x00\x00\x00fff\xFC\x00\x00\x00\x00\x00\x00\x00\x00\xC4\xF5(\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
    io.puts(header)
    5880000.times{ io.write("\xFF") }
    io.rewind
    result = Cloudinary::Uploader.upload_large(io, :chunk_size => 5243000, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["resource_type"]).to eq('raw')
    io.rewind
    result = Cloudinary::Uploader.upload_large(io, :resource_type => 'image', :chunk_size => 5243000, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result["resource_type"]).to eq('image')
    expect(result["width"]).to eq(1400)
    expect(result["height"]).to eq(1400)
    expect(result["format"]).to eq("bmp")
  end

  it "should allow fallback of upload large with remote url to regular upload", :focus => true do
    file = "http://cloudinary.com/images/old_logo.png"
    result = Cloudinary::Uploader.upload_large(file, :chunk_size => 5243000, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect(result).to_not be_nil
    expect(result["width"]).to eq(TEST_IMG_W)
    expect(result["height"]).to eq(TEST_IMG_H)
  end
  
  context "unsigned" do
    after do
      Cloudinary.class_variable_set(:@@config, nil)
    end
    
    it "should support unsigned uploading using presets", :upload_preset => true do
      preset = Cloudinary::Api.create_upload_preset(:folder => "test_folder_upload", :unsigned => true, :tags => [TEST_TAG, TIMESTAMP_TAG])

      Cloudinary.config.api_key = nil
      Cloudinary.config.api_secret = nil

      result = Cloudinary::Uploader.unsigned_upload(TEST_IMG, preset["name"], :tags => [TEST_TAG, TIMESTAMP_TAG])
      expect(result["public_id"]).to match(/^test_folder_upload\/[a-z0-9]+$/)

      Cloudinary.class_variable_set(:@@config, nil)

    end
  end

  describe ":timeout" do
    before do
      @timeout = Cloudinary.config.timeout
      Cloudinary.config.timeout = 0.01
    end
    after do
      Cloudinary.config.timeout = @timeout
    end

    it "should fail if timeout is reached" do
      expect{Cloudinary::Uploader.upload(Pathname.new(TEST_IMG), :tags => [TEST_TAG, TIMESTAMP_TAG])}.to raise_error(RestClient::RequestTimeout)
    end
  end

  context ":responsive_breakpoints" do
    context ":create_derived with transformation and format conversion" do
      expected ={
          :url => /.*\/upload$/,
          [:payload, :responsive_breakpoints] => %r("transformation":"e_sepia/jpg"),
          [:payload, :responsive_breakpoints] => %r("transformation":"gif"),
          [:payload, :responsive_breakpoints] => %r("create_derived":true)
      }
      it 'should return a proper responsive_breakpoints hash in the response' do
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
        Cloudinary::Uploader.upload(TEST_IMG, responsive_breakpoints:[{transformation:{effect: "sepia"}, format:"jpg", bytes_step:20000, create_derived: true, :min_width => 200, :max_width => 1000, :max_images => 20},{format:"gif", create_derived:true, bytes_step:20000, :min_width => 200, :max_width => 1000, :max_images => 20}], :tags => [TEST_TAG, TIMESTAMP_TAG])
      end
    end
  end



  describe 'explicit' do

    context ":invalidate" do
      it 'should pass the invalidate value to the server' do
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :invalidate] => 1))
        Cloudinary::Uploader.explicit("cloudinary", :type=>"twitter_name", :eager=>[{:crop=>"scale", :width=>"2.0"}], :invalidate => true, :tags => [TEST_TAG, TIMESTAMP_TAG])
      end
    end
  end
end

