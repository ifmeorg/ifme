# frozen_string_literal: true
# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  slug        :string
#

class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :user_id, :name, presence: true

  belongs_to :user

  def self.link
    '/categories/'
  end
end
