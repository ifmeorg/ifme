class ReportsController < ApplicationController
        def new
        end
    
        def create
            user_id = current_user.id
            ally_id = params[:ally_id].to_i
            @report = Report.create(reporter_id: user_id, reportee_id: ally_id, reasons: params[:report][:reasons] )
        end    
end
