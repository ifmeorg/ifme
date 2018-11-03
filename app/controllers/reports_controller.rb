# frozen_string_literal: true
class ReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_id = current_user.id
    ally_id = params[:ally_id].to_i
    comment_id = params[:comment_id]
    comment_id = -1 if comment_id.nil?
    @report = Report.create(reporter_id: user_id,
                            reportee_id: ally_id,
                            reasons: params[:report][:reasons],
                            comment_id: comment_id)
  end

  def destroy
    @admin_report = Report.find(params[:id])
    @admin_report.destroy
    redirect_to admin_dashboard_path
  end
end
