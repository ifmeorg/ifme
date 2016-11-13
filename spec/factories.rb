FactoryGirl.define do
  factory :self_care_strategy_reminder do
    active true
  end
  factory :strategy_reminder do
    active true
  end
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
    name "Test Name"
    description "Test Description"
    location "Test Location"
    time "Test Time"
    maxmembers 1
    date Date.tomorrow
    sequence(:groupid)
  end

  factory :bad_group, class: Group do
    name "Test Group"
  end

  factory :group do
    name "Test Group"
    description "Group description"

    factory :group_with_member do
      transient do
        userid 1
        leader false
      end

      after(:create) do |group, evaluator|
        create :group_member, userid: evaluator.userid,
                              groupid: group.id,
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

    trait :with_allies do
      transient do
        number_of_allies 3
      end

      after(:create) do |user, evaluator|
        evaluator.number_of_allies.times do |i|
          ally = create :user1, name: "Ally #{i}"
          create :allyships_accepted, user_id: user.id, ally_id: ally.id
        end
      end
    end
  end

  factory :user3, class: User do
    name "Gentle Breezy"
    email "gentle.breezy@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :user_oauth, class: User do
    name "Orange Southland"
    email "orange.southland@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
    token "has_a_token"
  end

  factory :allyships_accepted, class: Allyship do
    status :accepted
  end

  factory :allyships_pending_from_userid1, class: Allyship do
    status :pending_from_user
  end

  factory :allyships_pending_from_userid2, class: Allyship do
    status :pending_from_ally
  end

  factory :category do
    name  "Test Category"
    description "Test Description"
  end

  factory :medication do
    name "Fancy Medication Name"
    dosage 10
    dosage_unit "tablet"
    refill 01/01/2020
    strength 12
    strength_unit "mg"
    total "30"
    total_unit "tablets"

    after(:create) do |medication|
      create :take_medication_reminder, medication: medication, active: false
      create :refill_reminder, medication: medication, active: false
    end

    trait :with_refill_reminder do
      after(:create) do |medication|
        create :take_medication_reminder, medication: medication, active: false
        create :refill_reminder, medication: medication
      end
    end

    trait :with_daily_reminder do
      after(:create) do |medication|
        create :refill_reminder, medication: medication, active: false
        create :take_medication_reminder, medication: medication
      end
    end

    trait :with_both_reminders do
      after(:create) do |medication|
        create :take_medication_reminder, medication: medication
        create :refill_reminder, medication: medication
      end
    end
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

  factory :take_medication_reminder do
    active true
  end

  factory :refill_reminder do
    active true
  end

  factory :strategy do
    name "Test Strategy"
    description "Test Description"
    comment true

    after(:create) do |strategy|
      create :strategy_reminder, strategy: strategy, active: false
      create :self_care_strategy_reminder, strategy: strategy, active: false
    end

    trait :with_self_care_strategy_reminder do
      after(:create) do |strategy|
        create :strategy_reminder, strategy: strategy, active: false
        create :self_care_strategy_reminder, strategy: strategy
      end
    end

    trait :with_daily_reminder do
      after(:create) do |strategy|
        create :self_care_strategy_reminder, strategy: strategy, active: false
        create :strategy_reminder, strategy: strategy
      end
    end

    trait :with_both_reminders do
      after(:create) do |strategy|
        create :strategy_reminder, strategy: strategy
        create :self_care_strategy_reminder, strategy: strategy
      end
    end
  end
end
