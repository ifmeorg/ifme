# frozen_string_literal: true
# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  reporter_id :integer
#  reportee_id :integer
#  reasons     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  comment_id  :integer
#  user_id     :integer
#

class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reporter, class_name: 'User'
  belongs_to :reportee, class_name: 'User'
  has_one :comment
  validates :reportee_id, presence: true
  validates :reporter_id, presence: true
  validates :reasons, presence: true
  after_create :send_mail_reports
  #make sure reporter_id and reportee_id are different

  def send_mail_reports
    reporter_mail = User.where(id: reporter_id).pluck(:email)[0]
    reportee_mail = User.where(id: reportee_id).pluck(:email)[0]
    ReportMailer.reported_email(reporter_id,
                                reportee_id,
                                reporter_mail).deliver_now
    ReportMailer.reportee_email(reportee_id,
                                reporter_id,
                                reportee_mail).deliver_now
  end
end
