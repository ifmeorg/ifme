# == Schema Information
#
# Table name: care_plan_contacts
#
#  id         :bigint           not null, primary key
#  name       :string
#  phone      :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryBot.define do
  factory :care_plan_contact do
    name { 'Lovely Person' }
    phone { "416000000" }

    trait :with_user do
      user { create(:user1) }
    end
  end
end
