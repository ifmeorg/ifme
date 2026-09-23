# frozen_string_literal: true
FILENAME = "moment.webp"
FILE_PATH = "/spec/uploads/"

describe CloudinaryService do
  subject { described_class }

  let(:file) { File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME)) }
  let(:public_id) { "moment-public-id" }
  let(:upload_response) do
    {
      "public_id" => public_id,
      "secure_url" => "https://res.cloudinary.com/demo/image/upload/#{public_id}",
      "signature" => "signature",
      "original_filename" => "moment"
    }
  end

  describe '#upload' do
    context 'successfully' do
      it 'returns json response from cloudinary' do
        expect(Cloudinary::Uploader).to receive(:upload)
          .with(file, {})
          .and_return(upload_response)

        response = subject.upload(file)

        expect(response).to have_key("public_id")
        expect(response).to have_key("secure_url")
        expect(response).to have_key("signature")
        expect(response["original_filename"]).to eq("moment")
      end
    end

    context 'it gracefully fails' do
      it 'returns nil' do
        expect(Cloudinary::Uploader).to receive(:upload)
          .with(nil, {})
          .and_raise(StandardError)

        response = subject.upload(nil)
        expect(response).to be nil
      end
    end
  end

  describe '#delete' do
    context 'successfully' do
      it 'returns success json response from cloudinary' do
        expect(Cloudinary::Uploader).to receive(:destroy)
          .with(public_id, {})
          .and_return({"result"=>"ok"})

        response = subject.delete(public_id)
        expect(response).to eq({"result"=>"ok"})
      end
    end

    context 'gracefully fails' do
      it 'returns not found' do
        expect(Cloudinary::Uploader).to receive(:destroy)
          .with("untitled", {})
          .and_return({"result"=>"not found"})

        response = subject.delete("untitled")
        expect(response).to eq({"result"=>"not found"})
      end
    end
  end

  describe 'fetch' do
    context 'successfully' do
      it 'returns a secure url of an uploaded image' do
        cloudinary_secure_url = "https://res.cloudinary.com/demo/image/upload/"
        allow(ENV).to receive(:fetch)
          .with('CLOUDINARY_SECURE_URL', nil)
          .and_return(cloudinary_secure_url)

        response = subject.fetch(public_id)

        expect(response).to eq("#{cloudinary_secure_url}#{public_id}")
      end
    end
  end
end
