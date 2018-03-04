# frozen_string_literal: true
# == Schema Information
#
# Table name: moments
#
#  id                      :integer          not null, primary key
#  category                :text
#  name                    :string
#  mood                    :text
#  why                     :text
#  fix                     :text
#  created_at              :datetime
#  updated_at              :datetime
#  published_at            :datetime
#  userid                  :integer
#  viewers                 :text
#  comment                 :boolean
#  strategy                :text
#  slug                    :string
#  secret_share_identifier :uuid
#  secret_share_expires_at :datetime
#
class Moment < ApplicationRecord
  include Viewer
  extend FriendlyId

  friendly_id :name
  serialize :category, Array
  serialize :viewers, Array
  serialize :mood, Array
  serialize :strategy, Array

  before_save :category_array_data
  before_save :viewers_array_data
  before_save :mood_array_data
  before_save :strategy_array_data

  belongs_to :user, foreign_key: :userid
  has_many :comments, as: :commentable

  validates :comment, inclusion: [true, false]
  validates :userid, :name, :why, presence: true
  validates :why, length: { minimum: 1, maximum: 2000 }
  validates :fix, length: { maximum: 2000 }
  validates :secret_share_expires_at,
            presence: true, if: :secret_share_identifier?

  scope :published, -> { where.not(published_at: nil) }
  scope :recent, -> { order('created_at DESC') }

  def self.find_secret_share!(identifier)
    find_by!(
      'secret_share_expires_at > NOW()',
      secret_share_identifier: identifier
    )
  end

  def category_array_data
    self.category = category.collect(&:to_i) if category.is_a?(Array)
  end

  def viewers_array_data
    self.viewers = viewers.collect(&:to_i) if viewers.is_a?(Array)
  end

  def mood_array_data
    self.mood = mood.collect(&:to_i) if mood.is_a?(Array)
  end

  def strategy_array_data
    self.strategy = strategy.collect(&:to_i) if strategy.is_a?(Array)
  end

  def category_name
    category.try(:name)
  end

  def mood_name
    mood.try(:name)
  end

  def owned_by?(user)
    user&.id == userid
  end

  def published?
    !published_at.nil?
  end

  def shared?
    secret_share_identifier? &&
      Time.zone.now < secret_share_expires_at
  end

  def strategy_name
    strategy.try(:name)
  end
end
