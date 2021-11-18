# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    data = {
      cutoff: false,
      user: 'Almond Butters',
      comment: 'Hello',
      typename: 'typename',
      type: 'type_comment_moment',
      typeid: 1,
      commentable_id: 1,
    }
    uniqueid { 'MyString' }
    data { data.to_json }
  end
end
