class Admin::ReportsController < ApplicationController
  
  def index
     @admin_reports = Report.all
  end
end
