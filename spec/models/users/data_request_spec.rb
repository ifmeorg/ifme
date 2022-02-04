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
end
