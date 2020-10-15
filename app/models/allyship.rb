# frozen_string_literal: true
# == Schema Information
#
# Table name: allyships
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  ally_id    :integer
#  status     :integer
#

class Allyship < ApplicationRecord
  USER_DATA_ATTRIBUTES = %w[
    id
    created_at
    updated_at
    ally_id
    status
  ].map!(&:freeze).freeze

  enum status: { accepted: 0, pending_from_user: 1, pending_from_ally: 2 }

  validate :different_users

  belongs_to :user
  belongs_to :ally, class_name: 'User'

  before_destroy :remove_activities_between_users

  after_create :create_inverse, unless: :inverse?
  after_update :approve_inverse, if: :inverse_unapproved?
  after_destroy :destroy_inverses, if: :inverse?

  def approve_inverse
    inverses.update_all(status: User::ALLY_STATUS[:accepted])
  end

  def create_inverse
    self.class.create(
      inverse_allyship_options.merge(
        status: User::ALLY_STATUS[:pending_from_user]
      )
    )
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def different_users
    errors.add(:user_id, 'identical users') if user_id == ally_id
    errors.add(:user_id, 'user_id is nil') if user_id.nil?
    errors.add(:ally_id, 'ally_id is nil') if ally_id.nil?
  end

  def inverse?
    self.class.exists?(inverse_allyship_options)
  end

  def inverses
    self.class.where(inverse_allyship_options)
  end

  def inverse_allyship_options
    { ally_id: user_id, user_id: ally_id }
  end

  def inverse_unapproved?
    inverses.where.not(status: User::ALLY_STATUS[:accepted]).any?
  end

  private

  def remove_activities_between_users
    remove_ally_notifications
    remove_ally_viewers
  end

  def remove_ally_notifications
    user_id = self.user_id
    ally_id = self.ally_id
    Notification.for_ally(user_id, ally_id).or(
      Notification.for_ally(ally_id, user_id)
    ).destroy_all
  end

  def remove_ally_viewers
    user_id = self.user_id
    ally_id = self.ally_id
    [Moment, Strategy].each do |viewed_class|
      viewed_class.destroy_viewer(user_id, ally_id)
      viewed_class.destroy_viewer(ally_id, user_id)
    end
  end
end
