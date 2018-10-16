# frozen_string_literal: true
# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
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

  def self.add_premade(user_id)
    (1..5).each do |num|
      Mood.create(
        user_id: user_id,
        name: I18n.t("moods.index.premade#{num}_name"),
        description: I18n.t("moods.index.premade#{num}_description")
      )
    end
  end
end
