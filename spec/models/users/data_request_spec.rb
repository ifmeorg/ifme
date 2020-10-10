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

require 'rails_helper'

RSpec.describe Users::DataRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
