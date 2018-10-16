# frozen_string_literal: true

FactoryBot.define do
  factory :mood do
    name  { 'Test Mood' }
    description { 'Test Mood' }

    trait :with_user do
      user { create(:user1) }
    end
  end
end