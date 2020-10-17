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

EXAMPLE_UUID = "89ebd1e0-c500-4bda-b879-370e01f7f7f9"

FactoryBot.define do
  factory :partial_data_request, class: 'Users::DataRequest' do 
  	transient do
  	  use_example_uuid { false }
  	end
    user { create(:user) }
    request_id { use_example_uuid ? EXAMPLE_UUID : SecureRandom.uuid }
  end

  factory :enqueued_data_request, parent: :partial_data_request do
  	status_id {Users::DataRequest::STATUS[:enqueued]}
  end

  factory :invalid_status_data_request, parent: :partial_data_request do
  	status_id { 10 }
  end

  factory :empty_request_id_data_request, parent: :enqueued_data_request do
  	request_id { nil }
  end
end
