# frozen_string_literal: true
# == Schema Information
#
# Table name: meetings
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  location    :text
#  time        :string
#  maxmembers  :integer
#  group_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  date        :string
#  slug        :string
#

class Meeting < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :name, :description, :location, :time, :group_id, :date,
            presence: true
  belongs_to :group, foreign_key: :group_id
  has_many :meeting_members, foreign_key: :meeting_id, dependent: :destroy
  has_many :members, -> { order 'name' }, through: :meeting_members,
                                          source: :user
  has_many :leaders, -> { where(meeting_members: { leader: true }) },
           through: :meeting_members, source: :user
  has_many :comments, as: :commentable

  def member?(user)
    members.find_by(id: user.id).present?
  end

  def meeting_member(user)
    meeting_members.find_by(user_id: user.id)
  end

  def led_by?(user)
    leaders.include? user
  end

  def comments
    Comment.comments_from(self)
  end

  def date_time
    return if (date = self.date).blank? || (time = self.time).blank?

    begin
      date = date.try(:to_date)
      time = Time.zone.parse(time)
    rescue ArgumentError
      return
    end

    DateTime.new(
      date.year, date.month, date.day, time.hour, time.min
    ).in_time_zone
  end
end
