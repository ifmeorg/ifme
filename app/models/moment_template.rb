# frozen_string_literal: true
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

class MomentTemplate < ApplicationRecord
  extend FriendlyId

  friendly_id :name
  validates :user_id, :name, :description, presence: true
  belongs_to :user

  USER_DATA_ATTRIBUTES = %w[
    id
    name
    description
    created_at
    updated_at
    slug
  ].map!(&:freeze).freeze
end
