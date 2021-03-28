# == Schema Information
#
# Table name: moment_templates
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  slug        :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :moment_template do
    name  { 'Test Moment Template Name' }
    description { 'Test Moment Template Description' }

    trait :with_user do
      user { create(:user1) }
    end
  end
end
