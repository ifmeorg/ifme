# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  location    :text
#  time        :string
#  maxmembers  :integer
#  groupid     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  date        :string
#  slug        :string
#

class Meeting < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :name, :description, :location, :time, :groupid, :date,
            presence: true
  belongs_to :group, foreign_key: :groupid
  has_many :members, -> { order 'name' }, through: :meeting_members,
                                          source: :user
  has_many :meeting_members, foreign_key: :meetingid, dependent: :destroy
  has_many :leaders, -> { where(meeting_members: { leader: true }) },
           through: :meeting_members, source: :user
  has_many :comments, as: :commentable
end
