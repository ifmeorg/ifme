FactoryGirl.define do
  factory :group do
    name "Test Group"
    description "Group description"

    factory :group_with_member do
      transient do
        userid 1
        leader false
      end

      after(:create) do |group, evaluator|
        create :group_member, userid: evaluator.userid,
               groupid: group.id,
               leader: evaluator.leader
      end
    end
  end

  factory :bad_group, class: Group do
    name "Test Group"
  end
end
