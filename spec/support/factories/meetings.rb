FactoryGirl.define do
  factory :meeting do
    name "Test Name"
    description "Test Description"
    location "Test Location"
    time "Test Time"
    maxmembers 1
    date Date.tomorrow
    sequence(:groupid)
  end
end
