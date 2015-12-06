# == Schema Information
#
# Table name: allyships
#
#  id         :integer          not null, primary key
#  user_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  ally_id    :integer
#  status     :integer
#

class Allyship < ActiveRecord::Base
	attr_accessible :status, :user_id, :ally_id
	enum status: [:accepted, :pending_from_userid1, :pending_from_userid2]

	validate :different_users

	belongs_to :user
	belongs_to :ally, :class_name => "User"

	after_create :create_inverse, unless: :has_inverse?
	after_destroy :destroy_inverses, if: :has_inverse?

	def create_inverse
    self.class.create(inverse_allyship_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_allyship_options)
  end

  def inverses
    self.class.where(inverse_allyship_options)
  end

  def inverse_allyship_options
    { ally_id: user_id, user_id: ally_id }
  end

	def different_users
		self.errors.add(:user_id, "identical users") if self.user_id == self.ally_id
		self.errors.add(:user_id, "user_id is nil") if self.user_id.nil?
		self.errors.add(:ally_id, "ally_id is nil") if self.ally_id.nil?
	end
end
