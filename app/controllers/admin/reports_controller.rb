class Admin::ReportsController < Admin::AdminController

  def index
     @admin_reports = Report.all
  end
end
