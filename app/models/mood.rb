# frozen_string_literal: true
# == Schema Information
#
# Table name: moods
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  slug        :string
#

class Mood < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :user_id, :name, presence: true
  belongs_to :user
end
