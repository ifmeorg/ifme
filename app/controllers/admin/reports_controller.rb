class Admin::ReportsController < Admin::ApplicationController

  def index
     @admin_reports = Report.all
  end
end
