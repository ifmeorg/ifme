# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment_type :string
#  commented_on :integer
#  comment_by   :integer
#  comment      :text
#  created_at   :datetime
#  updated_at   :datetime
#  visibility   :string
#  viewers      :text
#

class Comment < ActiveRecord::Base
  serialize :viewers, Array
  validates :comment, length: { minimum: 0, maximum: 1000 }
  validates :comment_type, :commented_on, :comment_by, :comment, presence: true
  validates :comment_type, inclusion: %w[moment strategy meeting]
  validates :visibility, inclusion: %w[all private]
  before_save :array_data

  def array_data
    return unless viewers.is_a?(Array)
    self.viewers = viewers.collect(&:to_i)
  end
end
