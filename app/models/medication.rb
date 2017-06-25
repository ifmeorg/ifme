# == Schema Information
#
# Table name: medications
#
#  id            :integer          not null, primary key
#  name          :string
#  dosage        :integer
#  refill        :string
#  created_at    :datetime
#  updated_at    :datetime
#  userid        :integer
#  total         :integer
#  strength      :integer
#  strength_unit :string
#  dosage_unit   :string
#  total_unit    :string
#  comments      :text
#  slug          :string
#

class Medication < ActiveRecord::Base
  # dosage: amount of medication taken at one time
  # total: total quantity of medication
  # strength: strength of medication

  extend FriendlyId
  friendly_id :name
  belongs_to :user, foreign_key: :userid
  has_one :take_medication_reminder
  has_one :refill_reminder
  accepts_nested_attributes_for :take_medication_reminder
  accepts_nested_attributes_for :refill_reminder
  validates_presence_of :name, :dosage, :refill, :userid, :total, :strength, :dosage_unit, :total_unit, :strength_unit
  validates :dosage, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total, :numericality => { :greater_than_or_equal_to => 0 }
  validates :strength, :numericality => { :greater_than_or_equal_to => 0 }

  attr_accessor :add_to_google_cal

  def active_reminders
    return unless refill_reminder && take_medication_reminder
    [refill_reminder, take_medication_reminder].select(&:active?)
  end
end
