# frozen_string_literal: true
FactoryBot.define do
  factory :report do
    reasons { 'MyText' }
    after(:build) do |report|
      if User.count > 1
        report.reporter = User.first
        report.reportee = User.last
      end
      report.reporter ||= create(:user1)
      report.reportee ||= create(:user2)
    end
  end
end
