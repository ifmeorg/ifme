FactoryGirl.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "some-email#{n}@ifme.org" }
    sequence(:name) { |n| "Some Person#{n}" }
    password 'password'
  end
end