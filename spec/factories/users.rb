FactoryGirl.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "some-email#{n}@ifme.org" }
    password 'password'
  end
end