FactoryGirl.define do
  factory :user do
    firstname "Oprah"
    lastname  "Chang"
    email "oprah.chang@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :category do 
    name  "Test Category"
    description "Test Description"
  end

  factory :mood do 
    name  "Test Mood"
    description "Test Mood"
  end

  factory :trigger do 
    name  "Test Trigger"
    why "Test Why"
    fix "Test fix"
  end

  factory :comment do 
    comment_type "trigger"
    comment "Test Comment"
  end 
end