# == Schema Information
#
# Table name: supports
#
#  id           :integer          not null, primary key
#  userid       :integer
#  support_type :string
#  support_ids  :text
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :support do
    userid 1
    support_type "MyString"
    support_ids "MyString"
  end
end
