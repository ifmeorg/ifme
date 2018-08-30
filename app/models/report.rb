class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  validates :reportee_id, presence: true
  validates :reporter_id, presence: true
  validates :reasons, presence: true
  #after_create :send_instructions

  # def send_instructions
  #    @reporter_mail = User.find(r_mail: current)
  #    ReportMailer.report_email(reporter_id,'example@a.com').deliver_now
  # end

end

