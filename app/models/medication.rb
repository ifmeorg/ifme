# frozen_string_literal: true
# == Schema Information
#
# Table name: medications
#
#  id                :bigint           not null, primary key
#  name              :string
#  dosage            :integer
#  refill            :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  total             :integer
#  strength          :integer
#  strength_unit     :string
#  dosage_unit       :string
#  total_unit        :string
#  comments          :text
#  slug              :string
#  add_to_google_cal :boolean          default(FALSE)
#  weekly_dosage     :integer          default(["0", "1", "2", "3", "4", "5", "6"]), is an Array

class Medication < ApplicationRecord
  # dosage: amount of medication taken at one time
  # total: total quantity of medication
  # strength: strength of medication

  USER_DATA_ATTRIBUTES = %w[
    id
    name
    dosage
    refill
    created_at
    updated_at
    user_id
    total
    strength
    strength_unit
    dosage_unit
    total_unit
    comments
    slug
    add_to_google_cal
    weekly_dosage
  ].map!(&:freeze).freeze

  extend FriendlyId
  friendly_id :name
  belongs_to :user
  has_one :take_medication_reminder, dependent: :destroy
  has_one :refill_reminder, dependent: :destroy
  accepts_nested_attributes_for :take_medication_reminder
  accepts_nested_attributes_for :refill_reminder
  validates :name, :dosage, :refill, :user_id, :total, :strength, :dosage_unit,
            :total_unit, :strength_unit, presence: true
  validates :dosage, numericality: { greater_than_or_equal_to: 0 }
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :strength, numericality: { greater_than_or_equal_to: 0 }

  def active_reminders
    return unless refill_reminder && take_medication_reminder

    [refill_reminder, take_medication_reminder].select(&:active?)
  end

  def daily?
    weekly_dosage.count == 7
  end
end
