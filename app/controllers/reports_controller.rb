class ReportsController < ApplicationController
  def new
  end

  def create
    user_id = current_user.id
    ally_id = params[:ally_id].to_i
    user_mail = current_user.email
    comment_id = params[:comment_id]
    commentable_type = params[:commentable_type]
    if comment_id.nil?
      comment_id = -1
    end
    if commentable_type == nil
      commentable_type = "User"
    end

    @report = Report.create(
      reporter_id: user_id,
      reportee_id: ally_id, 
      comments: params[:report][:comments], 
      commentable_id: comment_id, 
      commentable_type: commentable_type )
    ReportMailer.report_email(user_id,user_mail).deliver_now
  end
end
