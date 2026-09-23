# frozen_string_literal: true
# == Schema Information
#
# Table name: moments
#
#  id                                  :bigint           not null, primary key
#  name                                :string
#  why                                 :text
#  fix                                 :text
#  created_at                          :datetime
#  updated_at                          :datetime
#  user_id                             :integer
#  viewers                             :text
#  comment                             :boolean
#  slug                                :string
#  secret_share_identifier             :uuid
#  secret_share_expires_at             :datetime
#  published_at                        :datetime
#  bookmarked                          :boolean          default(FALSE)
#  resource_recommendations            :boolean          default(TRUE)
#  crisis_prevention_acknowledged      :boolean          default(FALSE), not null
#  crisis_prevention_acknowledged_text :text
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
  before_update :reset_crisis_prevention_if_significant_change

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
  validates :name, :why, presence: true
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

  private

  def reset_crisis_prevention_if_significant_change
    return unless crisis_prevention_acknowledged?
    return if crisis_prevention_acknowledged_text.blank?
    return unless will_save_change_to_why?

    if significant_text_change?(crisis_prevention_acknowledged_text, why)
      self.crisis_prevention_acknowledged = false
      self.crisis_prevention_acknowledged_text = nil
    end
  end

  def significant_text_change?(old_text, new_text)
    old_clean = ActionController::Base.helpers.strip_tags(old_text.to_s).downcase.strip
    new_clean = ActionController::Base.helpers.strip_tags(new_text.to_s).downcase.strip

    return false if old_clean == new_clean
    return true if old_clean.blank?

    old_words = old_clean.split
    return true if old_words.empty?

    new_word_tally = new_clean.split.tally
    matching = old_words.count do |word|
      if new_word_tally[word].to_i > 0
        new_word_tally[word] -= 1
        true
      end
    end

    (1.0 - (matching.to_f / old_words.size)) > 0.30
  end
end
