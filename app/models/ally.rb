class Ally < ActiveRecord::Base
	attr_accessible :userid1, :userid2, :status
	enum status: [:accepted, :pending_from_userid1, :pending_from_userid2]

	validate :different_users

	def different_users
		self.errors.add(:userid1, "identical users") if self.userid1 == self.userid2
		self.errors.add(:userid1, "userid1 is nil") if self.userid1.nil?
		self.errors.add(:userid2, "userid2 is nil") if self.userid2.nil?
	end
end
