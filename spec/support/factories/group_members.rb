FactoryGirl.define do
  factory :group_member do
    association :user, factory: :user1
    group
    leader false

    factory :group_leader do
      leader true
    end
  end
end
