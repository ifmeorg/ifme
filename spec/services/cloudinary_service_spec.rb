# frozen_string_literal: true
FILENAME = "moment.jpeg"
FILE_PATH = "/public/uploads/tmp/moment"
OPTIONS = {}

describe CloudinaryService do
  subject { described_class }

  describe '#upload' do
    context 'has no options' do
      it 'returns json response from cloudinary' do
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        response = subject.upload(file)

        expect(response).to have_key("public_id")
        expect(response).to have_key("secure_url")
        expect(response).to have_key("signature")
        expect(response["original_filename"]).to eq("moment")
      end
    end

    context 'has options' do
      it 'returns json response from cloudinary' do
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        response = subject.upload(file, OPTIONS)

        expect(response).to have_key("public_id")
        expect(response).to have_key("secure_url")
        expect(response).to have_key("signature")
        expect(response["original_filename"]).to eq("moment")
      end
    end

    context 'it gracefully fails' do
      it 'returns nil' do
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        response = subject.upload(nil, OPTIONS)
        expect(response).to be nil
      end
    end
  end

  describe '#delete' do
    context 'has no options' do
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

    context 'has options' do
      it 'returns json response from cloudinary' do
        # upload image
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        uploaded_file = subject.upload(file)
        expect(uploaded_file).to have_key("public_id")
        expect(uploaded_file).to have_key("secure_url")

        response = subject.delete(uploaded_file["public_id"], OPTIONS)
        expect(response).to eq({"result"=>"ok"})
      end
    end

    context 'gracefully fails' do
      it 'returns not found' do
        # upload image
        file = File.new(File.join(::Rails.root.to_s, FILE_PATH, FILENAME))
        uploaded_file = subject.upload(file)
        expect(uploaded_file).to have_key("public_id")
        expect(uploaded_file).to have_key("secure_url")

        response = subject.delete("untitled", OPTIONS)
        expect(response).to eq({"result"=>"not found"})
      end
    end
  end
end
