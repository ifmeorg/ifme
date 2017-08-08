# frozen_string_literal: true

FactoryGirl.define do
  factory :notification do
    uniqueid 'MyString'
    data 'MyText'
    userid 1

    trait :with_user do
      association :user, factory: :user
    end
  end
end
