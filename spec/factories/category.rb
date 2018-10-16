# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name  { 'Test category' }
    description { 'Test description category' }

    trait :with_user do
      user { create(:user1) }
    end
  end
end
