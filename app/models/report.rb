# frozen_string_literal: true
# == Schema Information
#
# Table name: reports
#
#  id          :bigint(8)        not null, primary key
#  reporter_id :integer
#  reportee_id :integer
#  reasons     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  comment_id  :integer
#

class Report < ApplicationRecord
  belongs_to :reporter, class_name: 'User'
  belongs_to :reportee, class_name: 'User'
  belongs_to :comment, class_name: 'Comment'
  validates :reportee_id, presence: true
  validates :reporter_id, presence: true
  validates :reasons, presence: true
  after_create :send_emails

  def send_emails
    ReportMailer.reported_email(reporter, reportee).deliver_now
    ReportMailer.reportee_email(reportee).deliver_now
  end
end
