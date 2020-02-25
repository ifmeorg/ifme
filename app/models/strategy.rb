# frozen_string_literal: true
# == Schema Information
#
# Table name: strategies
#
#  id           :bigint           not null, primary key
#  user_id      :integer
#  category     :text
#  description  :text
#  viewers      :text
#  comment      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  name         :string
#  slug         :string
#  published_at :datetime
#

class Strategy < ApplicationRecord
  include Viewer
  include CommonMethods
  extend FriendlyId

  friendly_id :name
  serialize :category, Array
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

  scope :published, -> { where.not(published_at: nil) }
  scope :recent, -> { order('created_at DESC') }

  has_many :moments_strategies, dependent: :destroy

  def active_reminders
    [perform_strategy_reminder].select(&:active?) if perform_strategy_reminder
  end

  def viewers_array_data
    viewers.map!(&:to_i)
  end

  def category_array_data
    return unless category.is_a?(Array)

    category_ids = category.collect(&:to_i)
    self.category = category_ids
    self.categories = Category.where(user_id: user_id, id: category_ids)
  end

  def published?
    published_at.present?
  end

  def comments
    Comment.comments_from(self)
  end

  def self.populate_strategies_categories
    Strategy.all.find_each do |strategy|
      strategy.category = Category.where(id: strategy.category).pluck(:id)
      strategy.save
    end
  end
end
