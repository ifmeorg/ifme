# frozen_string_literal: true
# == Schema Information
#
# Table name: moments
#
#  id                       :bigint           not null, primary key
#  name                     :string
#  why                      :text
#  fix                      :text
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#  viewers                  :text
#  comment                  :boolean
#  slug                     :string
#  secret_share_identifier  :uuid
#  secret_share_expires_at  :datetime
#  published_at             :datetime
#  bookmarked               :boolean          default(FALSE)
#  resource_recommendations :boolean          default(TRUE)
#

class Moment < ApplicationRecord
  include Viewer
  include CommonMethods
  extend FriendlyId

  USER_DATA_ATTRIBUTES = %w[
    id
    name
    why
    fix
    created_at
    updated_at
    viewers
    comment
    slug
    secret_share_identifier
    secret_share_expires_at
    published_at
    bookmarked
    resource_recommendations
  ].map!(&:freeze).freeze

  friendly_id :name
  serialize :viewers, Array

  before_save do
    elements_array_data(%w[category mood strategy])
  end
  before_save :viewers_array_data

  belongs_to :user

  has_many :comments, as: :commentable
  has_many :moments_moods, dependent: :destroy
  has_many :moods, through: :moments_moods
  has_many :moments_categories, dependent: :destroy
  has_many :categories, through: :moments_categories
  has_many :moments_strategies, dependent: :destroy
  has_many :strategies, through: :moments_strategies

  validates :comment, inclusion: [true, false]
  validates :bookmarked, inclusion: [true, false]
  validates :user_id, :name, :why, presence: true
  validates :why, length: { minimum: 1 }
  validates :secret_share_expires_at,
            presence: true, if: :secret_share_identifier?
  validates :resource_recommendations, inclusion: [true, false]

  scope :published, -> { where.not(published_at: nil) }
  scope :recent, -> { order('created_at DESC') }

  attr_accessor :mood, :category, :strategy

  def self.find_secret_share!(identifier)
    find_by!(
      # 'secret_share_expires_at > NOW()', TODO: Turn off temporarily
      secret_share_identifier: identifier
    )
  end

  def viewers_array_data
    self.viewers = viewers.collect(&:to_i) if viewers.is_a?(Array)
  end

  def owned_by?(user)
    user&.id == user_id
  end

  def published?
    published_at.present?
  end

  def shared?
    secret_share_identifier?
    # && Time.zone.now < secret_share_expires_at TODO: Turn off temporarily
  end

  def comments
    Comment.comments_from(self)
  end
end
