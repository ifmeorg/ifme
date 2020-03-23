# frozen_string_literal: true

# == Schema Information
#
# Table name: supports
#
#  id           :integer          not null, primary key
#  user_id       :integer
#  support_type :string
#  support_ids  :text
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :support do
    user_id { 1 }
    support_type { 'MyString' }
    support_ids { 'MyString' }
  end
end
