# frozen_string_literal: true
# == Schema Information
#
# Table name: supports
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer
#  support_type :string
#  support_ids  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Support < ApplicationRecord
  validates :user_id, :support_type, :support_ids, presence: true
  serialize :support_ids, Array
  validates :support_type, inclusion: %w[category mood moment strategy]
  before_save :array_data

  def array_data
    return unless support_ids.is_a?(Array)

    self.support_ids = support_ids.collect(&:to_i)
  end
end
