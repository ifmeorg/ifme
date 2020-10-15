# frozen_string_literal: true
# == Schema Information
#
# Table name: moods
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  slug        :string
#  visible     :boolean          default(TRUE)
#

class Mood < ApplicationRecord
  USER_DATA_ATTRIBUTES = %w[
    id
    name
    description
    created_at
    updated_at
    slug
    visible
  ].map!(&:freeze).freeze

  extend FriendlyId
  friendly_id :name
  validates :user_id, :name, presence: true
  belongs_to :user

  has_many :moments_moods, dependent: :destroy
  validates :visible, inclusion: [true, false]
end
