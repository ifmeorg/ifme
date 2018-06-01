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
#  userid      :integer
#  slug        :string
#

class Mood < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :description, length: { maximum: 2000 }
  validates :userid, :name, presence: true

  belongs_to :user, foreign_key: :userid

  def self.link
    'moods'
  end

  def self.add_premade(user_id)
    (1..5).each do |num|
      Mood.create(
        userid: user_id,
        name: I18n.t("moods.index.premade#{num}_name"),
        description: I18n.t("moods.index.premade#{num}_description")
      )
    end
  end
end
