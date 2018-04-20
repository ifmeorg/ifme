require 'spec_helper'
require 'cloudinary'

describe Cloudinary::Api do
  break puts("Please setup environment for api test to run") if Cloudinary.config.api_secret.blank?
  include_context "cleanup", TIMESTAMP_TAG
  TEST_WIDTH = rand(1000)
  TEST_TRANSFOMATION = "c_scale,w_#{TEST_WIDTH}"
  prefix = "api_test_#{SUFFIX}"
  test_id_1 = "#{prefix}_1"
  test_id_2   = "#{prefix}_2"
  test_id_3   = "#{prefix}_3"
  test_key = "test_key_#{SUFFIX}"
  before(:all) do

    @api = Cloudinary::Api
    Cloudinary::Uploader.upload(TEST_IMG, :public_id => test_id_1, :tags => [TEST_TAG, TIMESTAMP_TAG], :context => "key=value", :eager =>[:width =>TEST_WIDTH, :crop =>:scale])
    Cloudinary::Uploader.upload(TEST_IMG, :public_id => test_id_2, :tags => [TEST_TAG, TIMESTAMP_TAG], :context => "key=value", :eager =>[:width =>TEST_WIDTH, :crop =>:scale])
    Cloudinary::Uploader.upload(TEST_IMG, :public_id => test_id_3, :tags => [TEST_TAG, TIMESTAMP_TAG], :context => "key=value", :eager =>[:width =>TEST_WIDTH, :crop =>:scale])
    Cloudinary::Uploader.upload(TEST_IMG, :public_id => test_id_1, :tags => [TEST_TAG, TIMESTAMP_TAG], :context => "#{test_key}=test", :eager =>[:width =>TEST_WIDTH, :crop =>:scale])
    Cloudinary::Uploader.upload(TEST_IMG, :public_id => test_id_3, :tags => [TEST_TAG, TIMESTAMP_TAG], :context => "#{test_key}=tasty", :eager =>[:width =>TEST_WIDTH, :crop =>:scale])
  end

  after(:all) do
    # in addition to "cleanup" context
    unless Cloudinary.config.keep_test_products
      up = Cloudinary::Api.upload_presets max_results: 500
      up["presets"].each do |u|
        tags = u["settings"]["tags"]
        name = u["name"]
        if tags =~ /.*#{TIMESTAMP_TAG}.*/
          Cloudinary::Api.delete_upload_preset(name)
        end
      end
    end
  end

  it "should allow listing resource_types" do
    expect(@api.resource_types()["resource_types"]).to include("image")
  end

  it "should allow listing resources" do
    resource = @api.resources()["resources"].find{|resource| resource["public_id"] == test_id_1
    }
    expect(resource).not_to be_blank
    expect(resource["type"]).to eq("upload")
  end

  it "should allow listing resources with cursor" do
    result = @api.resources(:max_results=>1)
    expect(result["resources"]).not_to be_blank
    expect(result["resources"].length).to eq(1)
    expect(result["next_cursor"]).not_to be_blank
    result2 = @api.resources(:max_results=>1, :next_cursor=>result["next_cursor"])
    expect(result2["resources"]).not_to be_blank
    expect(result2["resources"].length).to eq(1)
    expect(result2["resources"][0]["public_id"]).not_to eq(result["resources"][0]["public_id"] )
  end

  it "should allow listing resources by type" do
    resource = @api.resources(:type=>"upload", :tags=>true)["resources"].find{|resource| resource["public_id"] == test_id_1
    }
    expect(resource).not_to be_blank
    expect(resource["tags"]).to match_array([TEST_TAG, TIMESTAMP_TAG])
  end

  it "should allow listing resources by prefix" do
    resources = @api.resources(:type =>"upload", :prefix => prefix, :tags => true, :context => true)["resources"]
    expect(resources.map{|resource| resource["public_id"]}).to include(test_id_1, test_id_2)
    expect(resources.map{|resource| resource["tags"]}.flatten).to include(TEST_TAG, TIMESTAMP_TAG)
    expect(resources.map{|resource| resource["context"]}).to include({"custom" => {"key" => "value"}})
  end

  it "should allow listing resources by tag" do
    resources = @api.resources_by_tag(TEST_TAG, :tags => true, :context => true)["resources"]
    expect(resources.find{|resource| resource["public_id"] == test_id_1
    }).not_to be_blank
    expect(resources.map{|resource| resource["tags"]}.flatten).to include(TEST_TAG, TIMESTAMP_TAG)
    expect(resources.map{|resource| resource["context"]}).to include({"custom" => {"key" => "value"}})
  end

  it "should allow listing resources by context" do
    resources = @api.resources_by_context(test_key)["resources"]
    expect(resources.count).to eq(2)
    resources = @api.resources_by_context(test_key,'test')["resources"]
    expect(resources.count).to eq(1)
  end

  it "should allow listing resources by public ids" do
    resources = @api.resources_by_ids([test_id_1, test_id_2], :tags => true, :context => true)["resources"]
    expect(resources.length).to eq(2)
    expect(resources.find{|resource| resource["public_id"] == test_id_1
    }).not_to be_blank
    expect(resources.map{|resource| resource["tags"]}.flatten).to include(TEST_TAG, TIMESTAMP_TAG)
    expect(resources.map{|resource| resource["context"]}).to include({"custom" => {"key" => "value"}})
  end

  it "should allow listing resources by start date", :start_at => true do
    start_at = Time.now
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( {[:payload, :start_at] => start_at, [:payload, :direction] => "asc"}))
    @api.resources(:type=>"upload", :start_at=>start_at, :direction => "asc")
  end

  describe ":direction" do

    it "should accept a string 'desc' and 'asc'" do
      expected = {
          :url => /.*\/resources\/image\/tags\/#{TIMESTAMP_TAG}/,
          [:payload, :direction] => "asc"
      }
      expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

      @api.resources_by_tag(TIMESTAMP_TAG, :type=>"upload", :direction => "asc")
    end
    it "should accept an integer of '1' or '-1'" do
      expected = {
          :url => /.*\/resources\/image\/tags\/#{TIMESTAMP_TAG}/,
          [:payload, :direction] => "-1"
      }
      expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
      @api.resources_by_tag(TIMESTAMP_TAG, :type=>"upload", :direction => "-1")
    end
  end

  it "should allow get resource metadata" do
    resource = @api.resource(test_id_1)
    expect(resource).not_to be_blank
    expect(resource["public_id"]).to eq(test_id_1)
    expect(resource["bytes"]).to eq(3381)
    expect(resource["derived"].length).to eq(1)
  end

  it "should allow deleting derived resource" do
    derived_resource_id = "derived_id"
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( {[:payload, :derived_resource_ids] => derived_resource_id}))
    @api.delete_derived_resources(derived_resource_id)
  end

  it "should allow deleting derived resources by transformations" do
    public_id = "public_id"
    transformations = "c_crop,w_100"
    expect(RestClient::Request).to receive(:execute).with(
        deep_hash_value( {[:payload, :public_ids] => public_id,
                          [:payload, :transformations] => "c_crop,w_100"}))
    @api.delete_derived_by_transformation(public_id, "c_crop,w_100")

    transformations = {:crop => "crop", :width => 100}
    expect(RestClient::Request).to receive(:execute).with(
        deep_hash_value( {[:payload, :public_ids] => public_id,
                          [:payload, :transformations] => "c_crop,w_100"}))
    @api.delete_derived_by_transformation(public_id, transformations)

    transformations = [{:crop => "crop", :width => 100}, {:crop => "scale", :width => 300}]
    expect(RestClient::Request).to receive(:execute).with(
        deep_hash_value( {[:payload, :public_ids] => public_id,
                          [:payload, :transformations] => "c_crop,w_100|c_scale,w_300"}))
    @api.delete_derived_by_transformation(public_id, transformations)

  end

  it "should allow deleting multiple resources and comma inclusive public IDs", :focus => true do
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( {[:payload, :public_ids] => ["apit_test", "test_id_2", "api_test3"]}))
    @api.delete_resources(["apit_test", "test_id_2", "api_test3"])
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( {[:payload, :public_ids] => "apit_test,test_id_2,api_test3"}))
    @api.delete_resources("apit_test,test_id_2,api_test3")
  end

  it "should allow deleting resource transformations" do
    resource = Cloudinary::Uploader.upload(TEST_IMG, :eager => [{:width=>101,:crop=>:scale}, {:width=>200,:crop=>:crop}])
    public_id = resource["public_id"]
    expect(resource).not_to be_blank
    derived = resource["eager"].map{|d| d["transformation"]}
    expect(derived).to include("c_scale,w_101", "c_crop,w_200")
    @api.delete_resources([public_id], :transformations => "c_crop,w_200")
    resource = @api.resource(public_id)
    derived = resource["derived"].map{|d| d["transformation"]}
    expect(derived).not_to include("c_crop,w_200")
    expect(derived).to include("c_scale,w_101")
  end

  it "should allow deleting resources by prefix" do
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( {[:payload, :prefix] => "api_test_by"}))
    @api.delete_resources_by_prefix("api_test_by")
  end

  it "should allow deleting resources by tags" do
    expect(RestClient::Request).to receive(:execute).with(hash_including( :url => /.*\/tags\/api_test_tag_for_delete$/))
    @api.delete_resources_by_tag("api_test_tag_for_delete")
  end

  it "should allow listing tags" do
    tags = @api.tags(:max_results => 500)["tags"]
    expect(tags).to include(TEST_TAG)
  end

  it "should allow listing tag by prefix" do
    tags = @api.tags(:prefix=> TEST_TAG)["tags"]
    expect(tags).to include(TIMESTAMP_TAG)
    tags = @api.tags(:prefix=>"api_test_no_such_tag")["tags"]
    expect(tags).to be_blank
  end

  describe 'transformations' do
    it "should allow listing transformations" do
      transformation = @api.transformations(max_results: 500)["transformations"].find { |transformation| transformation["name"] == TEST_TRANSFOMATION }
      expect(transformation).not_to be_blank
      expect(transformation["used"]).to eq(true)
    end

    it "should allow getting transformation metadata" do
      transformation = @api.transformation(TEST_TRANSFOMATION)
      expect(transformation).not_to be_blank
      expect(transformation["info"]).to eq(["crop" => "scale", "width" => TEST_WIDTH])
      transformation = @api.transformation("crop" => "scale", "width" => TEST_WIDTH)
      expect(transformation).not_to be_blank
      expect(transformation["info"]).to eq(["crop" => "scale", "width" => TEST_WIDTH])
    end

    it "should allow updating transformation allowed_for_strict" do
      @api.update_transformation(TEST_TRANSFOMATION, :allowed_for_strict => true)
      transformation = @api.transformation(TEST_TRANSFOMATION)
      expect(transformation).not_to be_blank
      expect(transformation["allowed_for_strict"]).to eq(true)
      @api.update_transformation(TEST_TRANSFOMATION, :allowed_for_strict => false)
      transformation = @api.transformation(TEST_TRANSFOMATION)
      expect(transformation).not_to be_blank
      expect(transformation["allowed_for_strict"]).to eq(false)
    end

    it "should fetch two different derived images using next_cursor" do
      result = @api.transformation(TEST_TRANSFOMATION, :max_results=>1)
      expect(result["derived"]).not_to be_blank
      expect(result["derived"].length).to eq(1)
      expect(result["next_cursor"]).not_to be_blank
      result2 = @api.transformation(TEST_TRANSFOMATION, :max_results=>1, :next_cursor=>result["next_cursor"])
      expect(result2["derived"]).not_to be_blank
      expect(result2["derived"].length).to eq(1)
      expect(result2["derived"][0]["id"]).not_to eq(result["derived"][0]["id"] )
    end

    describe "named transformations" do
      it "should allow creating named transformation" do
        public_id = "api_test_transformation_#{Time.now.to_i}"
        @api.create_transformation(public_id, "crop" => "scale", "width" => 102)
        transformation = @api.transformation(public_id)
        expect(transformation).not_to be_blank
        expect(transformation["allowed_for_strict"]).to eq(true)
        expect(transformation["info"]).to eq(["crop" => "scale", "width" => 102])
        expect(transformation["used"]).to eq(false)
      end

      it "should allow deleting named transformation" do
        public_id = "api_test_transformation_#{Time.now.to_i}"
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value( :url => /.*\/transformations\/#{public_id}/, :method => :delete))
        @api.delete_transformation(public_id)
      end

      it "should allow unsafe update of named transformation" do
        public_id = "api_test_transformation_#{Time.now.to_i}"
        expected = {
            :url => /.*\/transformations\/#{public_id}$/,
            :method => :put,
            [:payload, :unsafe_update] => "c_scale,w_103"}
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
        @api.update_transformation(public_id, :unsafe_update => { "crop" => "scale", "width" => 103 })
      end

      it "should allow listing of named transformations" do
        expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :named ]=> true))
        @api.transformations :named => true
      end
      
    end
    it "should allow deleting implicit transformation" do
      @api.transformation(TEST_TRANSFOMATION)
      @api.delete_transformation(TEST_TRANSFOMATION)
      expect { @api.transformation(TEST_TRANSFOMATION) }.to raise_error(Cloudinary::Api::NotFound)
    end
  end

  it "should allow creating upload_presets" do
    expected = {:url => /.*\/upload_presets$/,
                [:payload, :name] => "new_preset",
                [:payload, :folder] => "some_folder"}
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))

    @api.create_upload_preset(:name => "new_preset", :folder => "some_folder", :tags => [TEST_TAG, TIMESTAMP_TAG])
  end

  describe "upload_presets" do
    it 'should not accept parameters' do
      expected = {
          :url => /.*\/upload_presets/,
          [:payload, :next_cursor] => 1234567,
          [:payload, :max_results] => 10
      }
      expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
      @api.upload_presets :next_cursor => 1234567, :max_results => 10

    end
  end
  it "should allow getting a single upload_preset", :upload_preset => true do
    result = @api.create_upload_preset(:unsigned => true, :folder => "folder", :width => 100, :crop => :scale, :tags => ["a","b","c", TEST_TAG, TIMESTAMP_TAG], :context => {:a => "b", :c => "d"})
    name = result["name"]
    preset = @api.upload_preset(name)
    expect(preset["name"]).to eq(name)
    expect(preset["unsigned"]).to eq(true)
    expect(preset["settings"]["folder"]).to eq("folder")
    expect(preset["settings"]["transformation"]).to eq([{"width" => 100, "crop" => "scale"}])
    expect(preset["settings"]["context"]).to eq({"a" => "b", "c" => "d"})
    expect(preset["settings"]["tags"]).to eq(["a","b","c", TEST_TAG, TIMESTAMP_TAG])
  end

  it "should allow deleting upload_presets", :upload_preset => true do
    id = "#{prefix}_upload_preset"
    @api.create_upload_preset(:name => id, :folder => "folder", :tags => [TEST_TAG, TIMESTAMP_TAG])
    preset = @api.upload_preset(id)
    @api.delete_upload_preset(id)
    expect{preset = @api.upload_preset(id)}.to raise_error(Cloudinary::Api::NotFound)
  end

  it "should allow updating upload_presets", :upload_preset => true do
    name = @api.create_upload_preset(:folder => "folder", :tags => [TEST_TAG, TIMESTAMP_TAG])["name"]
    preset = @api.upload_preset(name)
    @api.update_upload_preset(name, preset["settings"].merge(:colors => true, :unsigned => true, :disallow_public_id => true))
    preset = @api.upload_preset(name)
    expect(preset["name"]).to eq(name)
    expect(preset["unsigned"]).to eq(true)
    expect(preset["settings"]).to eq({"folder" => "folder", "colors" => true, "disallow_public_id" => true, "tags" => [TEST_TAG, TIMESTAMP_TAG]})
  end

  # this test must be last because it deletes (potentially) all dependent transformations which some tests rely on. Excluded by default.
  skip "should allow deleting all resources", :delete_all=>true do
    Cloudinary::Uploader.upload(TEST_IMG, :public_id=>"api_test5", :eager=>[:width=>101,:crop=>:scale], :tags => [TEST_TAG, TIMESTAMP_TAG])
    resource = @api.resource("api_test5")
    expect(resource).not_to be_blank
    expect(resource["derived"].length).to eq(1)
    @api.delete_all_resources(:keep_original => true)
    resource = @api.resource("api_test5")
    expect(resource).not_to be_blank
    expect(resource["derived"].length).to eq(0)
  end

  it "should support setting manual moderation status" do
    result = Cloudinary::Uploader.upload(TEST_IMG, {:moderation => :manual, :tags => [TEST_TAG, TIMESTAMP_TAG]})
    expect(result["moderation"][0]["status"]).to eq("pending")
    expect(result["moderation"][0]["kind"]).to eq("manual")
    api_result = Cloudinary::Api.update(result["public_id"], {:moderation_status => :approved})
    expect(api_result["moderation"][0]["status"]).to eq("approved")
    expect(api_result["moderation"][0]["kind"]).to eq("manual")
  end

  it "should support requesting raw conversion" do
    result = Cloudinary::Uploader.upload("spec/docx.docx", :resource_type => :raw, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect{Cloudinary::Api.update(result["public_id"], {:resource_type => :raw, :raw_convert => :illegal})}.to raise_error(Cloudinary::Api::BadRequest, /^Illegal value|not a valid/)
  end

  it "should support requesting categorization" do
    result = Cloudinary::Uploader.upload(TEST_IMG, :tags => [TEST_TAG, TIMESTAMP_TAG])
    expect{Cloudinary::Api.update(result["public_id"], {:categorization => :illegal})}.to raise_error(Cloudinary::Api::BadRequest, /^Illegal value/)
  end

  it "should support requesting detection with server notification", :focus => true do
    expected = {
      [:payload, :detection] => "adv_face",
      [:payload, :notification_url] => "http://example.com"
    }
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
    Cloudinary::Api.update("public_id", {:detection => "adv_face", :notification_url => "http://example.com"})
  end

  it "should support requesting auto_tagging" do
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :auto_tagging] => 0.5))
    Cloudinary::Api.update("public_id", {:auto_tagging => 0.5})
  end

  it "should support listing by moderation kind and value" do
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value([:url] => /.*manual\/approved$/, [:payload, :max_results] => 1000))
    Cloudinary::Api.resources_by_moderation(:manual, :approved, :max_results => 1000)
  end

  it "should support listing folders" do
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:url] => /.*\/folders$/, [:method] => :get))
    Cloudinary::Api.root_folders
    expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:url] => /.*\/folders\/test_folder1$/, [:method] => :get))
    Cloudinary::Api.subfolders("test_folder1")
  end

  it "should throw if folder is missing" do
    expect{Cloudinary::Api.subfolders("I_do_not_exist")}.to raise_error(Cloudinary::Api::NotFound)
  end

  describe '.restore'  do
    it 'should restore a deleted resource' do
      expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :public_ids] => "api_test_restore", [:url] => /.*\/restore$/))
      Cloudinary::Api.restore("api_test_restore")
    end
  end

  describe 'create_upload_mapping' do
    mapping = "api_test_upload_mapping#{rand(100000)}"
    it 'should create mapping' do
      expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :template] => "http://cloudinary.com"))
      Cloudinary::Api.create_upload_mapping(mapping, :template =>"http://cloudinary.com")
      expect(RestClient::Request).to receive(:execute).with(deep_hash_value( [:payload, :template] => "http://res.cloudinary.com"))
      Cloudinary::Api.update_upload_mapping(mapping, "template" =>"http://res.cloudinary.com")
    end


  end
  describe "access_mode" do
    i = 0

    publicId = ""
    access_mode_tag = ''
    before(:each) do
      i += 1
      access_mode_tag = TEST_TAG + "access_mode" + i.to_s
      result = Cloudinary::Uploader.upload TEST_IMG, access_mode: "authenticated", tags: [TEST_TAG, TIMESTAMP_TAG, access_mode_tag]
      publicId = result["public_id"]
      expect(result["access_mode"]).to eq("authenticated")
    end

    it "should update access mode by ids" do
      result = Cloudinary::Api.update_resources_access_mode_by_ids "public", [publicId]

      expect(result["updated"]).to be_an_instance_of(Array)
      expect(result["updated"].length).to eq(1)
      resource = result["updated"][0]
      expect(resource["public_id"]).to eq(publicId)
      expect(resource["access_mode"]).to eq('public')
    end
    it "should update access mode by prefix" do
      result = Cloudinary::Api.update_resources_access_mode_by_prefix "public", publicId[0..-3]

      expect(result["updated"]).to be_an_instance_of(Array)
      expect(result["updated"].length).to eq(1)
      resource = result["updated"][0]
      expect(resource["public_id"]).to eq(publicId)
      expect(resource["access_mode"]).to eq('public')
    end
    it "should update access mode by tag" do
      result = Cloudinary::Api.update_resources_access_mode_by_tag "public", access_mode_tag

      expect(result["updated"]).to be_an_instance_of(Array)
      expect(result["updated"].length).to eq(1)
      resource = result["updated"][0]
      expect(resource["public_id"]).to eq(publicId)
      expect(resource["access_mode"]).to eq('public')
    end
  end

  context "resource of type authenticated" do
    i = 0
    bytes = nil
    publicId = ""
    publish_resource_tag = "publish_resource_tag"
    before(:each) do
      i += 1
      result = Cloudinary::Uploader.upload TEST_IMG, type: "authenticated", tags: [TEST_TAG, TIMESTAMP_TAG, publish_resource_tag], transformation: {width: 100*i, crop: "scale"}
      publicId = result["public_id"]
      expect(result["type"]).to eq("authenticated")
    end

    it "should publish resources by ids" do
      result = Cloudinary::Api.publish_by_ids( [publicId])

      expect(result["published"]).to be_an_instance_of(Array)
      expect(result["published"].length).to eq(1)

      resource = result["published"][0]

      expect(resource["public_id"]).to eq(publicId)
      expect(resource["type"]).to eq('upload')

      bytes = resource["bytes"]
    end
    it "should publish resources by prefix and overwrite" do
      result = Cloudinary::Api.publish_by_prefix(publicId[0..-3], overwrite: true)

      expect(result["published"]).to be_an_instance_of(Array)
      expect(result["published"].length).to eq(1)

      resource = result["published"][0]

      expect(resource["public_id"]).to eq(publicId)
      expect(resource["bytes"]).not_to eq(bytes)
      expect(resource["type"]).to eq('upload')

      bytes = resource["bytes"]
    end
    it "should publish resources by tag and overwrite" do
      result = Cloudinary::Api.publish_by_tag(publish_resource_tag, overwrite: true)

      expect(result["published"]).to be_an_instance_of(Array)
      expect(result["published"].length).to eq(1)

      resource = result["published"][0]

      expect(resource["public_id"]).to eq(publicId)
      expect(resource["bytes"]).not_to eq(bytes)
      expect(resource["type"]).to eq('upload')

      bytes = resource["bytes"]
    end
  end
end

describe Cloudinary::Api::Response do
  let(:api_response) { described_class.new }

  shared_examples 'a Hash' do
    it 'inherits from Hash' do
      expect(api_response).to be_a Hash
    end
  end

  context 'when there is no argument given on instantiation' do
    it 'does not raise an error' do
      expect { api_response }.to_not raise_error
    end

    it_behaves_like 'a Hash'
  end

  context 'when the response is nil' do
    it 'does not raise an error' do
      expect { described_class.new nil }.to_not raise_error
    end

    it_behaves_like 'a Hash'
  end

  context 'when the response is present' do
    let(:body)          { { 'foo' => 'bar' } }
    let(:http_response) { double code: 200, body: body.to_json, headers: { x_featureratelimit_reset: Time.new.to_s } }
    let(:api_response)  { described_class.new http_response }

    it 'sets the instantiated self as the parsed response which is a Hash' do
      expect(api_response).to eq body
    end

    it_behaves_like 'a Hash'
  end
end
