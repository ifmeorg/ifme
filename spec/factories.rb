FactoryGirl.define do
  factory :notification do
    association :user, factory: :user1
    uniqueid "MyString"
    data "MyText"
  end

  factory :group_member do
    association :user, factory: :user1
    group
    leader false

    factory :group_leader do
      leader true
    end
  end

  factory :meeting_member do
    association :user, factory: :user1
    meeting
    leader false
  end

  factory :meeting do
    group
    name "Test Name"
    description "Test Description"
    location "Test Location"
    time "Test Time"
    maxmembers 1
    date Date.tomorrow
  end

  factory :bad_group, class: Group do
    name "Test Group"
  end

  factory :group do
    name "Test Group"
    description "Group description"

    factory :group_with_member do
      transient do
        user_id 1
        leader false
      end

      after(:create) do |group, evaluator|
        create :group_member, user_id: evaluator.user_id,
                              group_id: group.id,
                              leader: evaluator.leader
      end
    end
  end

  factory :user1, class: User do
    name "Oprah Chang"
    sequence(:email) { |n| "oprah.chang#{n}@example.com" }
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :user2, class: User do
    name "Plum Blossom"
    email "plum.blossom@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :user3, class: User do
    name "Gentle Breezy"
    email "gentle.breezy@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :allyships_accepted, class: Allyship do
    status :accepted
  end

  factory :allyships_pending_from_user_id1, class: Allyship do
    status :pending_from_user
  end

  factory :allyships_pending_from_user_id2, class: Allyship do
    status :pending_from_ally
  end

  factory :category do
    name  "Test Category"
    description "Test Description"
  end

  factory :mood do
    name  "Test Mood"
    description "Test Mood"
  end

  factory :moment do
    name  "Test Moment"
    why "Test Why"
    fix "Test fix"
    comment true
  end

  factory :comment do
    comment_type "moment"
    comment "Test Comment"
  end

  factory :strategy do
    name "Test Strategy"
    description "Test Description"
    comment true
  end
end
