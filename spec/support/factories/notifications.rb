FactoryGirl.define do
  factory :notification do
    association :user, factory: :user1
    uniqueid "MyString"
    data "MyText"
  end
end
