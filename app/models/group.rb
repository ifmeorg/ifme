# frozen_string_literal: true
# == Schema Information
#
# Table name: groups
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string
#

class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :name, :description, presence: true
  has_many :group_members, dependent: :destroy
  has_many :members, -> { order 'name' }, through: :group_members, source: :user
  has_many :meetings, -> { order 'meetings.created_at DESC' },
           foreign_key: :group_id, dependent: :destroy
  has_many :leaders, -> { where(group_members: { leader: true }) },
           through: :group_members, source: :user
  after_destroy :destroy_notifications

  def led_by?(user)
    leaders.include? user
  end

  def member?(user)
    members.find_by(id: user.id).present?
  end

  def notifications
    Notification.where('uniqueid ilike ?', '%new_group%').select do |n|
      JSON.parse(n.data)['group_id'].to_i == id
    end
  end

  private

  def destroy_notifications
    notifications.each(&:destroy)
  end
end
