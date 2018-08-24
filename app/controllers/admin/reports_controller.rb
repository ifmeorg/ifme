class Admin::ReportsController < Admin::AdminController

  def index
     @admin_reports = Report.all
  end
  
  def show
    @admin_report = Report.find(params[:id])
    @admin_report.destroy
    redirect_to :back
  end
end
