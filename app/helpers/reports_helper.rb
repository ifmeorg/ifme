# frozen_string_literal: true
module ReportsHelper
  include FormHelper

  def new_report_props(uid, comment_id = nil)
    new_form_props(
      report_form_inputs,
      reports_path(uid: uid, comment_id: comment_id)
    )
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
