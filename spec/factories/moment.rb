# frozen_string_literal: true
FactoryBot.define do
  factory :moment do
    name  { 'Test Moment' }
    why { 'Test Why' }
    fix { 'Test fix' }
    comment { true }

    trait :with_secret_share do
      secret_share_identifier { SecureRandom.uuid }
      secret_share_expires_at { 1.day.from_now }
    end

    trait :with_expired_secret_share do
      secret_share_identifier { SecureRandom.uuid }
      secret_share_expires_at { 1.day.ago }
    end

    trait :with_published_at do
      published_at { Time.zone.now }
    end

    trait :with_user do
      user { create(:user1) }
    end
  end
end
