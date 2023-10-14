# frozen_string_literal: true
# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uniqueid   :string
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  USER_DATA_ATTRIBUTES = %w[
    id
    uniqueid
    data
    created_at
    updated_at
  ].map!(&:freeze).freeze

  validates :user_id, :uniqueid, :data, presence: true
  belongs_to :user

  scope :for_ally, lambda { |user_id, ally_id|
    where(
      user_id:,
      uniqueid: %W[new_ally_request_#{ally_id} accepted_ally_request_#{ally_id}]
    )
  }
end
