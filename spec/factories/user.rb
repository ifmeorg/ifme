# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  location               :string
#  timezone               :string
#  about                  :text
#  avatar                 :string
#  conditions             :text
#  token                  :string
#  uid                    :string
#  provider               :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  comment_notify         :boolean
#  ally_notify            :boolean
#  group_notify           :boolean
#  meeting_notify         :boolean
#  locale                 :string
#  access_expires_at      :datetime
#  refresh_token          :string
#

FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "some-email#{n}@ifme.org" }
    sequence(:name) { |n| "Some Person#{n}" }
    password 'password'
    uuid 'uuid'
  end

  factory :user1, class: User do
    name "Oprah Chang"
    sequence(:email) { |n| "oprah.chang#{n}@example.com" }
    password "password"
    location "Toronto, ON, Canada"
  end

  factory :user2, class: User do
    name "Plum Blossom"
    email "plum.blossom@example.com"
    password "password"
    location "Toronto, ON, Canada"

    trait :with_allies do
      transient do
        number_of_allies 3
      end

      after(:create) do |user, evaluator|
        evaluator.number_of_allies.times do |i|
          ally = create :user1, name: "Ally #{i}"
          create :allyships_accepted, user_id: user.id, ally_id: ally.id
        end
      end
    end
  end

  factory :user3, class: User do
    name "Gentle Breezy"
    email "gentle.breezy@example.com"
    password "password"
    location "Toronto, ON, Canada"
  end

  factory :user_oauth, class: User do
    name "Orange Southland"
    email "orange.southland@example.com"
    password "password"
    location "Toronto, ON, Canada"
    token "has_a_token"
    access_expires_at { Time.zone.now + 600 }
  end
end
