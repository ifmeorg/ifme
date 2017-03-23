FactoryGirl.define do
  factory :meeting_member do
    association :user, factory: :user1
    meeting
    leader false
  end
end
