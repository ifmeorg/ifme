FactoryGirl.define do
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
end
