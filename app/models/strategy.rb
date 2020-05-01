# frozen_string_literal: true
# == Schema Information
#
# Table name: strategies
#
#  id           :bigint           not null, primary key
#  user_id      :integer
#  description  :text
#  viewers      :text
#  comment      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  name         :string
#  slug         :string
#  published_at :datetime
#  visible     :boolean
#  bookmarked   :boolean
#

class Strategy < ApplicationRecord
  include Viewer
  include CommonMethods
  extend FriendlyId

  friendly_id :name
  serialize :viewers, Array

  before_save :category_array_data
  before_save :viewers_array_data

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :strategies_categories, dependent: :destroy
  has_many :categories, through: :strategies_categories

  has_one :perform_strategy_reminder
  accepts_nested_attributes_for :perform_strategy_reminder

  validates :comment, inclusion: [true, false]
  validates :user_id, :name, :description, presence: true
  validates :description, length: { minimum: 1 }
  validates :visible, inclusion: [true, false]

  scope :published, -> { where.not(published_at: nil) }
  scope :recent, -> { order('created_at DESC') }

  has_many :moments_strategies, dependent: :destroy

  attr_accessor :category

  def active_reminders
    [perform_strategy_reminder].select(&:active?) if perform_strategy_reminder
  end

  def viewers_array_data
    self.viewers = viewers.collect(&:to_i) if viewers.is_a?(Array)
  end

  def category_array_data
    return unless category.is_a?(Array)

    category_ids = category.collect(&:to_i)
    self.categories = Category.where(user_id: user_id, id: category_ids)
  end

  def published?
    published_at.present?
  end

  def comments
    Comment.comments_from(self)
  end
end
