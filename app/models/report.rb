class Report < ApplicationRecord
    belongs_to :user
    has_one :comment
    validates :reportee_id, presence: true
    validates :reporter_id, presence: true
    validates :reasons, presence: true
    after_create :send_mail_reports

    def send_mail_reports
        reporter_mail = User.where(id: reporter_id).pluck(:email)[0] 
        reportee_mail = User.where(id: reportee_id).pluck(:email)[0] 
        ReportMailer.reported_email(reporter_id,reportee_id,reporter_mail).deliver_now
        ReportMailer.reportee_email(reportee_id,reporter_id,reportee_mail).deliver_now
    end
end
