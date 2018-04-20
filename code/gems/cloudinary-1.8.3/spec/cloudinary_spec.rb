require 'spec_helper'
require 'cloudinary'

describe Cloudinary do
  before :all do
    @user_platform = Cloudinary.user_platform
  end
  after :all do
    Cloudinary.user_platform = @user_platform
  end

  it 'should add a user platform to USER_AGENT' do
    Cloudinary.user_platform = "Spec/1.0 (Test)"
    expect(Cloudinary.USER_AGENT).to match( %r"Spec\/1.0 \(Test\) CloudinaryRuby/[\d.]+")

  end

  describe 'config' do
    before do
      @url_backup = ENV["CLOUDINARY_URL"]
    end
    after do
      ENV["CLOUDINARY_URL"] = @url_backup
      Cloudinary::config_from_url @url_backup
    end
    it "should allow nested values in CLOUDINARY_URL" do
      ENV["CLOUDINARY_URL"]  = "cloudinary://key:secret@test123?foo[bar]=value"
      Cloudinary::config_from_url ENV["CLOUDINARY_URL"]
      expect(Cloudinary::config.foo.bar).to eq 'value'
    end
  end
end