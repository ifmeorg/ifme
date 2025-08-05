RSpec.configure do |config|
  config.before(:each) do
    allow(Cloudinary::Utils).to receive(:cloudinary_url).and_return("https://res.cloudinary.com/test/image/upload/fake.jpg")
    allow(Cloudinary::Uploader).to receive(:upload).and_return({ "public_id" => "fake_id" })
    allow(Cloudinary::Uploader).to receive(:destroy).and_return({ "result" => "ok" })
  end
end
