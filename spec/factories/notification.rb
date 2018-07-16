# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    uniqueid 'MyString'
    data 'MyText'
    user_id 1

    trait :with_user do
      association :user, factory: :user
    end
  end
end
