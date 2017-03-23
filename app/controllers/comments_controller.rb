class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  # WIP
  def create
    result =
      if service(comment_params).create
        generate_comment(service.comment, service.comment)
      else
        { no_save: true }
      end

    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  def destroy
    service.delete

    render nothing: true
  end

  private

  def service(svc_params = {})
    @comment_service ||= safe_klass.new(comment: @comment, user: current_user, params: svc_params)
  end

  def safe_klass
    "Comments::#{klass.camelize}Service".safe_constantize
  end

  def klass
    klass = required[:comment_type] || 'base'

    raise ArgumentError unless %w(strategy meeting moment base).include?(klass)

    klass
  end

  def set_comment
    @comment = Comment.find(params[:id])
  rescue
    respond_to_nothing if @comment.blank?
  end

  def comment_params
    hash = required.permit(:comment_type, :commented_on, :comment_by, :comment,
                           :visibility, :viewers)

    hash.merge!(viewers: hash[:viewers].split)
  end

  def required
    params.require(:comment)
  end
end
