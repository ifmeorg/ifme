class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  validates :reportee_id, presence: true
  validates :reporter_id, presence: true
  validates :reasons, presence: true

end

