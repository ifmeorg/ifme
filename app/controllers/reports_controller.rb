# frozen_string_literal: true
class ReportsController < ApplicationController
  include ReportsHelper
  before_action :authenticate_user!

  def create
    @report = create_report
    redirect_to(
      new_report_path(uid: params[:uid]),
      notice_or_alert(@report)
    )
  end

  private

  def notice_or_alert(report)
    user = User.find_by(uid: params[:uid])
    { alert: t('reports.report_error', name: user.name) } unless report

    { notice: t('reports.report_sent', name: user.name) }
  end

  def create_report
    Report.create(reporter_id: current_user.id,
                  reportee_id: User.find_by(uid: params[:uid]).id,
                  reasons: params[:report][:reasons],
                  comment_id: params[:comment_id])
  end
end
