# frozen_string_literal: true
# == Schema Information
#
# Table name: categories
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

class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name
  validates :user_id, :name, presence: true
  belongs_to :user

  has_many :moments_categories, dependent: :destroy
  has_many :strategies_categories, dependent: :destroy
  validates :visible, inclusion: [true, false]
end
