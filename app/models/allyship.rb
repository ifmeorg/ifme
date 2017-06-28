# == Schema Information
#
# Table name: allyships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  ally_id    :integer
#  status     :integer
#

class Allyship < ActiveRecord::Base
  enum status: [:accepted, :pending_from_user, :pending_from_ally]

  validate :different_users

  belongs_to :user
  belongs_to :ally, class_name: 'User'

  after_create :create_inverse, unless: :has_inverse?
  after_update :approve_inverse, if: :inverse_unapproved?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_allyship_options.merge(status: User::ALLY_STATUS[:pending_from_user]))
  end

  def approve_inverse
    inverses.update_all(status: User::ALLY_STATUS[:accepted])
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_allyship_options)
  end

  def inverse_unapproved?
    !inverses.where.not(status: User::ALLY_STATUS[:accepted]).empty?
  end

  def inverses
    self.class.where(inverse_allyship_options)
  end

  def inverse_allyship_options
    { ally_id: user_id, user_id: ally_id }
  end

  def different_users
    errors.add(:user_id, 'identical users') if user_id == ally_id
    errors.add(:user_id, 'user_id is nil') if user_id.nil?
    errors.add(:ally_id, 'ally_id is nil') if ally_id.nil?
  end
end
