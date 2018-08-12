class ReportsController < ApplicationController
  def new
  end

  def create
    user_id = current_user.id
    ally_id = params[:ally_id].to_i
    comment_id = params[:comment_id]
    commentable_type = params[:commentable_type]
    @report = Report.create(reporter_id: user_id, reportee_id: ally_id, comments: params[:report][:comments], comment_id: comment_id, commentable_type: commentable_type )
  end
end
