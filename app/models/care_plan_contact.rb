# frozen_string_literal: true
# == Schema Information
#
# Table name: care_plan_contacts
#
#  id         :bigint           not null, primary key
#  name       :string
#  phone      :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class CarePlanContact < ApplicationRecord
  USER_DATA_ATTRIBUTES = %w[
    id
    name
    phone
    created_at
    updated_at
  ].map!(&:freeze).freeze

  validates :user_id, :name, presence: true
  belongs_to :user
end
