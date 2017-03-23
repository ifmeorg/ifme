FactoryGirl.define do
  factory :allyships_accepted, class: Allyship do
    status :accepted
  end

  factory :allyships_pending_from_userid1, class: Allyship do
    status :pending_from_user
  end

  factory :allyships_pending_from_userid2, class: Allyship do
    status :pending_from_ally
  end
end
