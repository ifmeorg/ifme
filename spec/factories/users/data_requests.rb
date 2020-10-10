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

FactoryBot.define do
  factory :users_data_request, class: 'Users::DataRequest' do
    
  end
end
