# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commentable_id { create(:moment, :with_user).id }
    commentable_type { 'moment'}
    comment_by { create(:user).id }
    comment { 'Test Comment' }
    visibility { :all }
  end
end
