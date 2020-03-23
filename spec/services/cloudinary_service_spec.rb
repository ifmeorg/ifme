# frozen_string_literal: true
FILENAME = "moment.jpeg"
FILE_PATH = "/spec/uploads/"

describe CloudinaryService do
  subject { described_class }

  describe '#upload' do
    context 'successfully' do
      it 'returns json response from cloudinary' do
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        response = subject.upload(file)

        expect(response).to have_key("public_id")
        expect(response).to have_key("secure_url")
        expect(response).to have_key("signature")
        expect(response["original_filename"]).to eq("moment")
      end
    end

    context 'it gracefully fails' do
      it 'returns nil' do
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        response = subject.upload(nil)
        expect(response).to be nil
      end
    end
  end

  describe '#delete' do
    context 'successfully' do
      it 'returns success json response from cloudinary' do
        # upload image
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        uploaded_file = subject.upload(file)
        expect(uploaded_file).to have_key("public_id")
        expect(uploaded_file).to have_key("secure_url")

        # delete image
        response = subject.delete(uploaded_file["public_id"])
        expect(response).to eq({"result"=>"ok"})
      end
    end

    context 'gracefully fails' do
      it 'returns not found' do
        # upload image
        response = subject.delete("untitled")
        expect(response).to eq({"result"=>"not found"})
      end
    end
  end

  describe 'fetch' do
    context 'successfully' do
      it 'returns a secure url of an uploaded image' do
        # upload image
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        uploaded_file = subject.upload(file)

        # delete image
        response = subject.fetch(uploaded_file["public_id"])
        expect(response).to include(ENV['CLOUDINARY_SECURE_URL'])
        expect(response).to include(uploaded_file["public_id"])
      end
    end
  end
end
