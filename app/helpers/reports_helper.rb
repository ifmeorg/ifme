# frozen_string_literal: true
module ReportsHelper
  include FormHelper

  def new_report_props(uid, comment_id = nil)
    new_form_props(
      report_form_inputs,
      reports_path(uid: uid, comment_id: comment_id)
    )
  end

  def reportee(report)
    User.find_by(id: report.reportee_id)
  end

  def reporter(report)
    User.find_by(id: report.reporter_id)
  end

  def banned_users
    User.where(banned: true)
  end

  private

  def report_form_inputs
    [
      {
        id: 'report_reasons',
        type: 'textarea',
        name: 'report[reasons]',
        label: t('reports.reasons')
      }.merge(value: nil, required: true, dark: true)
    ]
  end
end
