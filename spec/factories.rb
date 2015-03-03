FactoryGirl.define do
  factory :user1, class: User do
    firstname "Oprah"
    lastname  "Chang"
    email "oprah.chang@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :user2, class: User do
    firstname "Plum"
    lastname  "Blossom"
    email "plum.blossom@example.com"
    password "password"
    location "Toronto, ON, Canada"
    timezone "-05:00"
  end

  factory :allies_accepted, class: Ally do
    status :accepted
  end

  factory :allies_pending_from_userid1, class: Ally do
    status :pending_from_userid1
  end

  factory :allies_pending_from_userid2, class: Ally do
    status :pending_from_userid2
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
    comment true
  end

  factory :comment do
    comment_type "trigger"
    comment "Test Comment"
  end

  factory :strategy do
    name "Test Strategy"
    description "Test Description"
    comment true
  end
end