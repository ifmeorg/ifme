FactoryGirl.define do
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
end
