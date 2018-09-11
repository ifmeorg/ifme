# frozen_string_literal: true

data = {
  cutoff: false,
  user: 'Julia Nguyen',
  comment: 'Hello',
  typename: 'typename',
  type: 'type_comment_moment',
  typeid: 1,
  commentable_id: 1
}

FactoryBot.define do
  factory :notification do
    uniqueid 'MyString'
    data data.to_json
    user_id 1

    trait :with_user do
      association :user, factory: :user
    end
  end
end
