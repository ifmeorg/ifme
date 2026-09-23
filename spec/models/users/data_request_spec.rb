# == Schema Information
#
# Table name: users_data_requests
#
#  id         :bigint           not null, primary key
#  request_id :string           not null
#  status_id  :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'zlib'

describe Users::DataRequest, type: :model do
  context 'validations' do
    it 'is invalid without a request_id' do
      data_request = build(:empty_request_id_data_request)
      expect(data_request).to have(1).error_on(:request_id)
    end

    it 'is invalid without a status_id' do
      data_request = build(:partial_data_request)
      expect(data_request).to have(2).error_on(:status_id)
    end

    it 'is invalid with an invalid status_id' do
      data_request = build(:invalid_status_data_request)
      expect(data_request).to have(1).error_on(:status_id)
    end

    it 'is a valid data request object' do
      data_request = create(:enqueued_data_request)
      expect(data_request.valid?).to be(true)
    end

	it 'fails unique request_id check' do
      data_request1 = create(:enqueued_data_request, use_example_uuid: true)
      data_request2 = build(:enqueued_data_request, use_example_uuid: true)
      expect(data_request2.valid?).to be(false)
    end
  end

  describe '#create_csv' do
    let(:data_request) { create(:enqueued_data_request) }

    it 'sets status to success and stores gzip data in file_data' do
      data_request.create_csv
      expect(data_request.reload.status_id).to eq(Users::DataRequest::STATUS[:success])
      expect(data_request.reload.file_data).to be_present
    end

    it 'produces valid gzip content' do
      data_request.create_csv
      content = Zlib::GzipReader.new(StringIO.new(data_request.reload.file_data)).read
      expect(content).to be_present
    end

    it 'sets status to failed and clears file_data when an error occurs' do
      allow(data_request).to receive(:write_to_csv).and_raise(StandardError, 'boom')
      data_request.create_csv
      expect(data_request.reload.status_id).to eq(Users::DataRequest::STATUS[:failed])
      expect(data_request.reload.file_data).to be_nil
    end
  end
end
